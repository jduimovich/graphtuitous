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

let healthCount = 0;
app.get("/health", function (req, res) {
	healthCount++;
	const response = {
		"status": 'OK',
		"healthCount": healthCount
	};
	res.json(response);
});
app.get("/", function (req, res) {
	const response = {
		"status": 'OK'
	};
	res.json(response);
});

let count = 0;

app.get("/fib", function (req, res) {
	count++;
	if (count % 100 === 0) {
		console.log("/fib, called: " + count + " times");
	}
	const start = new Date();
	let c = APP_LOOP;
	while (c--) fib(APP_COMPUTE);
	const end = new Date();

	const response = {
		"hostname": HOSTNAME,
		"version": APP_VERSION,
		"colour": APP_COLOUR,
		"count": count,
		"stack": 'node.js',
		"loop": APP_LOOP,
		"compute": 'fib(' + APP_COMPUTE + ')',
		"time": end - start
	};

	res.json(response);
});

const port = process.env.PORT || 8080;
app.listen(port, function () {
	console.log("Hello world listening on port", port);
});
