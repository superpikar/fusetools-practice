var Observable = require("FuseJS/Observable");
var mymodules = require("/jsmodules/mymodules/mymodules.js");
var news = Observable();

mymodules.getNews()
	.then(function(response){
		news.replaceAll(response);
	}).catch(function(error){
		console.log('couldnt get news '+error)
	});

module.exports = {
	devices: [
		{id: "device1", label: "Children 1"},
		{id: "device2", label: "Children 2"},
		{id: "device3", label: "Children 3"},
	],
	news: news,
	gotoActivity: function() {
		router.push("activity");
	},
	scanDevices: function(){
		console.log(mymodules.getInvisible());
		mymodules.getNews().then(function(response){
			response.forEach(function(val, key){
				console.log(val.label);
			});
		});
		return mymodules.getNews();
	}		
}