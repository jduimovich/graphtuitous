const express = require("express");
const app = express();
var fs = require('fs');

app.get("/health", function (req, res) {
	var response = {
		"status": 'OK'
	};
	res.setHeader('Content-Type', 'application/json');
	res.send(JSON.stringify(response, undefined, 4));
});

function returnIndex(req, res) {
	res.sendFile(__dirname + "/index.html");
}
app.get("/", returnIndex);
app.get("/index.html", returnIndex);
app.get("/usage.html", function (req, res) {
	res.sendFile(__dirname + "/usage.html");
});

function install_redirects(settings) { 
	settings.forEach(function(r) { 
		app.get(r.localUrl, 
				redirect(r.service, r.port, r.remoteUrl));
	}); 
}

var count = 0;
function redirect(service, port, optionalurl) {
	const request = require('request');
	console.log("Generation of redirect function");

	var cyclePorts = [];
	if (Array.isArray(port)) {
		cyclePorts = cyclePorts.concat(port);
	} else { 
		cyclePorts.push (port);
	}
	console.log("Cycle ports" + JSON.stringify(cyclePorts));
	const f = function (req, res) {
		var endpoint = optionalurl ? optionalurl : req.url;
		var p = cyclePorts.shift();
		cyclePorts.push(p);
		console.log("Cycle ports:" + p);
		var url = 'http://' + service + ':' + p + endpoint;
		console.log("Redirect to " + url);
		request(url, { json: true }, (err, response, body) => {
			if (err) {
				// cyclePorts.pop();
				console.log(err); 
				var body = { 
					"hostname": "Error:" + url, 
					"version": 0, 
					"colour": 'pink',
					"count": 0,
					"stack": 'frontend',  
					"loop": 0,
					"compute": 'error',
					"time": 0
				};
			}
			res.send(body);
		});
	};
	return f;
}

fs.readFile('./settings.json',
	function (err, data) {
		var settings = {};
		if (err) {
			console.log('No settings.json found (' + err + '). Using default settings');
		} else {
			try {
				settings = JSON.parse(data.toString('utf8', 0, data.length));
			} catch (e) {
				console.log('Error parsing settings.json: ' + e);
				process.exit(1);
			}
		} 
		install_redirects(settings);
		const port = process.env.PORT || 8080;
		app.listen(port, function () {
			console.log("FrontEnd listening on port", port);
		});
	});



