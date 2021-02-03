
var fs = require('fs'); 

var args = process.argv.splice(2); 
if (args.length < 2) {
    console.log ("You must pass two file names to merge two files");
    console.log ("Usage:", process.argv[0], " csv-filename");
    process.exit(0);
}
var f1=args[0]
var f2=args[1]

console.log ("F1 = ",f1)
console.log ("F2 = ",f2) 


function mergeSarif(d1, d2) {
    var j1 = JSON.parse (d1)
    var j2 = JSON.parse (d2) 
    console.log (f1+ " nuumber of rules: ", j1.runs[0].tool.driver.rules.length) 
    console.log (f2 + " nuumber of rules: ", j2.runs[0].tool.driver.rules.length)  

    var combined=j1.runs[0].tool.driver.rules.concat (j2.runs[0].tool.driver.rules);

    // console.log (JSON.stringify(combined, null, 4))  
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

    var j1byid = new Object()
    j1.runs[0].results.forEach (function (e) { 
        j1byid[e.ruleId] = e;
    })
    var j2byid = new Object()
    j2.runs[0].results.forEach (function (e) { 
        j2byid[e.ruleId] = e;
    })  

      
    console.log ("Rules and locations pre-merge: ",  j1.runs[0].tool.driver.rules.length  )    
    j1.runs[0].results.forEach (function (e) {
        console.log ("Id:",  e.ruleId, " ", e.locations.length )    
    })
    // merge all into j1
    j1.runs[0].results.forEach (function (e) { 
        j2Has = j2byid[e.ruleId];
        if (j2Has) {   
            var combined = j1byid[e.ruleId].locations.concat(j2byid[e.ruleId].locations)
            var included = new Set()
            var uniq = []
            combined.forEach(function (e) {
                if (!included.has(e.physicalLocation.artifactLocation.uri)) {
                    included.add(e.physicalLocation.artifactLocation.uri);
                    uniq.push(e)
                }
            }) 
            j1byid[e.ruleId].locations = uniq 
        }  
    } )
    //  add j2 exclusive into j1
    j2.runs[0].results.forEach (function (e) { 
        j1Has = j1byid[e.ruleId];
        if (!j1Has) j1.runs[0].results.push (e)
    }  )
    
    console.log ("Rules and locations post-merge: ",  j1.runs[0].tool.driver.rules.length  )    
    j1.runs[0].results.forEach (function (e) {
        console.log ("Id:",  e.ruleId, " ", e.locations.length )    
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


  