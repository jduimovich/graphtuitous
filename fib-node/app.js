const express = require("express");
const app = express();

const APP_VERSION = '1.0'; 
const APP_LOOP = 65000;
const APP_COLOUR = 'pink';
const APP_COMPUTE = 12;
const HOSTNAME = require('os').hostname();

function fib(n) {
	if (n < 3) return 1;
	return fib(n - 1) + fib(n - 2);
}

var healthCount=0;
app.get("/health", function (req, res) {
	healthCount++;
	var response = {
		"status": 'OK',
		"healthCount": healthCount
	};   
	res.setHeader('Content-Type', 'application/json; charset=utf-8');
	res.send(JSON.stringify(response, undefined, 4));
});
app.get("/", function (req, res) {
	var response = {
		"status": 'OK'
	};   
	res.setHeader('Content-Type', 'application/json; charset=utf-8');
	res.send(JSON.stringify(response, undefined, 4));
});

var count = 0; 
var response = {
	"hostname": HOSTNAME,
	"version": APP_VERSION, 
	"colour": APP_COLOUR, 
	"count": count,
	"stack": 'node.js',  
	"loop": APP_LOOP,
	"compute": 'fib(' + APP_COMPUTE + ')'
};

app.get("/fib", function (req, res) {
	response.count++;
 	console.log("/fib, called: " + response.count);
	var start = new Date(); 
	var c = APP_LOOP;
	while (c--) fib(APP_COMPUTE);
	var end = new Date();
	response.time = end - start; 
	res.setHeader('Content-Type', 'application/json; charset=utf-8');
	res.send(JSON.stringify(response));
});

const port = process.env.PORT || 8080;
app.listen(port, function () {
	console.log("Hello world listening on port", port);
});

