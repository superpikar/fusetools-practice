var data = [1, 2, 3];
var invisible = "I'm invisible";
var news = [
	{id: "news1", label: "News 1"},
	{id: "news2", label: "News 2"},
	{id: "news3", label: "News 3"},
];

function getNews(){
    return new Promise(function(resolve, reject){
        setTimeout(function(){
            resolve(news);
        }, 0);
    });
}

module.exports = {
    data: data,
    getInvisible: function(){
    	return invisible;
    },
    getNews: getNews
};