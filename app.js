const express = require("express");
const app = express();
var path = require('path');
const { exec } = require('child_process');
var os = require('os');

var APP_VERSION = '2.0';
var APP_COLOUR = 'blue'; 
var HOSTNAME = os.hostname();
 
var SIM= process.env.SIM;
if (SIM) console.log ("Running Simulated Data");
var sim = { 
	"balance": 50,
	"v1": 1.0,
	"v2": 2.0,
	"c1": "blue",
	"c2": "yellow"
};

function getRandomInt(max) {
	return Math.floor(Math.random() * Math.floor(max));
  }

var count = 0;
function addResponse(response, fromRequest) {
	response.route = fromRequest.url;
	response.time = new Date();
	response.count = count++;
	response.hostname = HOSTNAME;
	if (SIM) { 
		if (getRandomInt (100) < sim.balance)  { 
			response.version = sim.v1;
			response.colour = sim.c1; 
		}  else { 
			response.version = sim.v2;
			response.colour = sim.c2; 
		}
	} else { 
		response.version = APP_VERSION;
		response.colour = APP_COLOUR;
	}
};

app.get("/", function (req, res) {
	console.log(req.url); 
	// return the headers with some extra fields with HTML Formattings
	addResponse(req.headers, req)
	var response = JSON.stringify(req.headers, undefined, 4);
	res.send("Formated headers:	<br> <pre> " + response + "</pre>");
});


app.get("/test", function (req, res) { 
	var response = new Object();
	addResponse(response, req)
	res.setHeader('Content-Type', 'application/json');
	res.setHeader('Access-Control-Allow-Origin', '*'); 
	res.send(JSON.stringify(response, undefined, 4));
});

app.get("/index.html", function (req, res) { 
	res.sendFile(__dirname + "/index.html");
});

 
if (SIM) { 
app.get("/simconfig", function (req, res) { 
	var left = req.query.balance;
	if (left) {
		console.log(req.url + " param = " + left);
		sim.balance = left;
	}
	res.send( {
		"left": sim.balance,
		"right": 100-sim.balance,
		"updateInProgress": false,
		"proxy": true,
		"timeForLastUpdate": 0,
		"avgTimeForUpdate": 0
	});
});


app.get("/colour", function (req, res) { 
	var newColour = req.query.colour;
	if (newColour) {
		console.log(req.url + " colour = " + newColour);
		sim.v1 = sim.v2;
		sim.c1 = sim.c2;
		sim.v2 = (sim.v2+1);
		sim.c2 = newColour;
	}
	res.send( sim);
});

}




const port = process.env.PORT || 8080;
app.listen(port, function () {
	console.log("Hello world listening on port", port);
});

