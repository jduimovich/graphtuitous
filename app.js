const express = require("express");
const app = express();

var APP_VERSION = '1.1';
var APP_COLOUR = 'green'; // change me
 var APP_LOOP = 2000;
var APP_COMPUTE = 12;
var HOSTNAME = require('os').hostname();

app.get("/", function (req, res) {
	res.sendFile(__dirname + "/index.html");
});
app.get("/index.html", function (req, res) {
	res.sendFile(__dirname + "/index.html");
});
app.get("/usage.html", function (req, res) {
	res.sendFile(__dirname + "/usage.html");
});


function fib(n) {
	if (n < 3) return 1;
	return fib(n - 1) + fib(n - 2);
}
var count = 0;
app.get("/test", function (req, res) {
	var response = {
		"hostname": HOSTNAME,
		"version": APP_VERSION,
		"colour": APP_COLOUR, 
		"count": ++count,
		"stack": 'node.js',  
		"loop": APP_LOOP,
		"compute": 'fib(' + APP_COMPUTE + ')'
	};
	var start = new Date(); 
	var c = APP_LOOP;
	while (c--) fib(APP_COMPUTE);
	var end = new Date();
	response.time = end - start;

	res.setHeader('Content-Type', 'application/json');
	res.setHeader('Access-Control-Allow-Origin', '*');
	res.send(JSON.stringify(response, undefined, 4));
});

const port = process.env.PORT || 8080;
app.listen(port, function () {
	console.log("Hello world listening on port", port);
});

