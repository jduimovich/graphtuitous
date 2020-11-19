# rgb
  
This app has one endpoint /test and is used to demonstrate simple applications on kubernetes. 

It will return a JSON object. 
```
{ 
	"version": 1.0, 
	"colour": "green",
	"mode": "slow/fast"
}

```
`version` will have a version number for this service. Used in demos to show rolling forward version bumps.

`colour` is for demo usage where variable can be used to show visual differences between services (multiple deployment versions backing services).

`mode` is to enable demo of performance analysis. 



