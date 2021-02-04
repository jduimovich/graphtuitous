
var fs = require('fs'); 

var args = process.argv.splice(2); 
if (args.length < 2) {
    console.log ("You must pass two file names to merge two files");
    console.log ("Usage:", process.argv[0], " csv-filename");
    process.exit(0);
}
var f1=args[0]
var f2=args[1] 


function mergeSarif(d1, d2) {
    var j1 = JSON.parse (d1)
    var j2 = JSON.parse (d2) 
    console.log (f1+ " rules found: ", j1.runs[0].tool.driver.rules.length) 
    console.log (f1+ " locations found: ", j1.runs[0].results.length) 
    console.log (f2+ " rules found: ", j2.runs[0].tool.driver.rules.length)  
    console.log (f1+ " locations found: ", j2.runs[0].results.length)  

    var combined=j1.runs[0].tool.driver.rules.concat (j2.runs[0].tool.driver.rules); 
    var included=new Set()
    var newRules = [] 
    combined.forEach (function (e) { 
        if (!included.has(e.id)) { 
            included.add (e.id);
            newRules.push (e) 
        } 
    }) 
    console.log ("Number of rules combined is: ",  newRules.length  )    
    j1.runs[0].tool.driver.rules = newRules;  
    var c=0;
    newRules.forEach (function (e) {
        console.log (c++, ':',  e.id)    
    })
    j1.runs[0].results = j1.runs[0].results.concat(j2.runs[0].results) 
    console.log ("Number of source locations combined is: ",  j1.runs[0].results.length  )  
    c=0;  
    j1.runs[0].results.forEach (function (e) {
        console.log (c++, ':',  e.ruleId)    
    })
    return j1;
} 
  
fs.readFile(f1, 'utf8', function(err, f1data) {   
    fs.readFile(f2, 'utf8', function(err, f2data) { 
        var merged = mergeSarif(f1data,f2data)
        writeJSON('merged.sarif', merged, process.exit)
    })
}) 
 
function writeJSON(file, value, then) { 
    var stream = fs.createWriteStream(file);
    stream.once('open', function(fd) { 
        stream.write(JSON.stringify(value));
        stream.end();
        console.log ("Created: ", file);
        then(0)
    });
}


  