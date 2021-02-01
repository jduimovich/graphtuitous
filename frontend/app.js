const express = require("express");
const app = express();

const router = express.Router(); 
var fs = require('fs');


function install_redirects(settings) { 
	settings.forEach(function(r) { 
		router.get(r.localUrl, 
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
		cyclePorts = cyclePorts.concat(port);
		cyclePorts = cyclePorts.concat(port);
		cyclePorts = cyclePorts.concat(port);
	} else { 
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
		cyclePorts.push (port);
	}


	var active = 0;

	console.log("Cycle ports" + JSON.stringify(cyclePorts));
	const f = function (req, res) {
		active++;
		
		console.log("activerequests " + active);
		var endpoint = optionalurl ? optionalurl : req.url;
		var p = cyclePorts.shift();
		console.log("Cycle ports:" + p);
		var url = 'http://' + service + ':' + p + endpoint;
		console.log("Redirect to " + url);
		request(url, { json: true }, (err, response, body) => {
			if (err) { 
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
			cyclePorts.push(p);
			active--;
			res.send(body);
		});
	};
	return f;
}

const settings_file = process.env.SETTINGS || "./settings-server.json";

fs.readFile(settings_file,
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
		router.get("/health", function (req, res) {
			var response = {
				"status": 'OK'
			};
			res.setHeader('Content-Type', 'application/json');
			res.send(JSON.stringify(response, undefined, 4));
		});

		install_redirects(settings);
		app.use(express.static('.')); 
		app.use("/", router);  
		const port = process.env.PORT || 8080;
		app.listen(port, function () {
			console.log("FrontEnd listening on port", port);
		});
	});



