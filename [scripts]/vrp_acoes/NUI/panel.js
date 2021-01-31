function changePage(page) {
    // Change the page to the ID of page specified 
    $('#browsePage').hide();
    $('#graphPage').hide();
    $('#dollarPage').hide();
    $('#userPage').hide();
    var graphButton = $('#graphButton');
    var dollarButton = $('#dollarButton');
    var browseButton = $('#browseButton');
    var userButton = $('#userButton');
    switch (page) {
        case '#browsePage':  
            $('#browsePage').show();
            browseButton.addClass('active');
            graphButton.removeClass('active');
            dollarButton.removeClass('active');
            userButton.removeClass('active');
            $('#graphPage').hide();
            $('#dollarPage').hide();
            $('#userPage').hide(); 
            break;
        case '#graphPage':
            $('#browsePage').hide();
            $('#graphPage').show();
            browseButton.removeClass('active');
            graphButton.addClass('active');
            dollarButton.removeClass('active');
            userButton.removeClass('active');
            $('#dollarPage').hide();
            $('#userPage').hide();
            break;
        case '#dollarPage':
            $('#browsePage').hide();
            $('#graphPage').hide();
            $('#dollarPage').show();
            browseButton.removeClass('active');
            graphButton.removeClass('active');
            dollarButton.addClass('active');
            userButton.removeClass('active');
            $('#userPage').hide();
            break;
        case '#userPage':
            $('#browsePage').hide();
            $('#graphPage').hide();
            $('#dollarPage').hide();
            $('#userPage').show();
            browseButton.removeClass('active');
            graphButton.removeClass('active');
            dollarButton.removeClass('active');
            userButton.addClass('active');
            break;
    }
}
var resourceName = "vrp_acoes"; 
var panelShown = false;
var multiplyPricesBy = 1;
var theirStockData = {};
var tagTracker = {};
var stocks = {}

$( function() {
    window.addEventListener( 'message', function( event ) {
        var item = event.data;
        if (item.load == true) {
            $('#notifs').empty();
            $('#browsePage').hide();
            $('#graphPage').hide();
            $('#dollarPage').hide();
            $('#userPage').hide();
            $('#navigateBar').hide();

            // Show them the phone and shit
            $('#phoneSection').show();
            $('#loadingSection').show();
            $('#notifs').show();
            $('#content-contain').show();
            showAllCollections();
        } 
        if (item.show == false) {
            // Close
            clickHome();
        }
        if (item.show == true) {
            $('#loadingSection').hide(); 
            $('#graphPage').show();
            $('#navigateBar').show();
        }
        if (item.stockData) {
            // This is the stock data
            var alreadyContains = [];
            $('#pStocks').empty();
            $('#pCollections').empty();
            $('#stockGraphs').empty();
            $('#stock-tabs').empty();
            $('#stock-tab-graphs').empty();
            var graphButton = $('#graphButton');
            var dollarButton = $('#dollarButton');
            var browseButton = $('#browseButton');
            var userButton = $('#userButton');
            browseButton.removeClass('active');
            graphButton.removeClass('active');
            dollarButton.removeClass('active');
            userButton.removeClass('active');
            graphButton.addClass('active');
            var counter = 0;
            var total = 0;
            for (const key in item.stockData) {
                total++;
            }
            for (const key in item.stockData) {
                counter += 1;
                var stockLabel = key;
                var stockInfo = item.stockData[key];
                var stockHTML = stockInfo.data;
                var stockLink = stockInfo.link;
                var stockAbbrev = stockLink.split("symb=")[1];
                var tags = stockInfo.tags;
                // TODO: We need to parse stockHTML and get the data for it for the stock
                let doc = new DOMParser();
                var html = doc.parseFromString(stockHTML, 'text/html');
                var cost = getElementByXpath('/html/body/div[3]/div[1]/div[1]/div[2]/table/tbody/tr/td[1]/span', html).innerText;
                
                var imgURL = getElementByXpath('//*[@id="wsod_companyChart"]/img', html).src;
                imgURL = imgURL.replace('nui:', "");
                var percentChange = getElementByXpath('/html/body/div[3]/div[1]/div[1]/div[2]/table/tbody/tr/td[2]/span[4]/span', html).innerText;
                stocks[stockAbbrev] = {cost, imgURL, stockLabel, percentChange};
                // Set up pStocks #pStocks 
                if (percentChange.includes('-')) {
                    $('#pStocks').append(
                        '<div class="pStocks-box negative" tags="' + tags + '"><span>' + stockLabel + '</span><h3>' + stockAbbrev + '</h3><h4>' + percentChange + '</h4></div>'
                        );
                } else {
                    $('#pStocks').append(
                        '<div class="pStocks-box positive" tags="' + tags + '"><span>' + stockLabel + '</span><h3>' + stockAbbrev + '</h3><h4>' + percentChange + '</h4></div>'
                        );  
                }
                // End pStocks 
                // Set up pCollections
                var tagArr = String(tags).split(',');
                for (const tag in tagArr) {
                    if (!alreadyContains.includes(tagArr[tag])) {
                        $('#pCollections').append('<button onclick="showCollections(\'' + tagArr[tag] + '\')">' + tagArr[tag] + '</button>');
                        alreadyContains.push(tagArr[tag]);
                    }
                }
                
                // End pCollections
                // Set up stockGraphs #stockGraphs
                $('#stockGraphs').append('<div class="item">' +
                                '<div class="item-data">' +
                                    '<div>' +
                                    '<h2>' + stockAbbrev + '</h2>' +
                                    '<h3>' + stockLabel + '</h3>' +
                                    '</div>' +  
                                    '<h3>R$' + cost + ' por ação</h3>' +
                                '</div>' + 
                                '<div class="item-graph">' +
                                    '<img src="' + 'https:' + imgURL + '" width="100%" />' +
                                '</div>' +
                                '<div class="item-section">' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'1\')">Comprar</button>' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'20\')">Comprar 20</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'1\')">Vender</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'20\')">Vender 20</button>' +
                                '</div>' +
                            '</div>');
                // End stockGraphs
                // Set up dollarPage stock-tabs
                /**/
                if (counter == total) {
                    $('#stock-head-title').text(stockLabel);
                    $('#stock-tabs').append('<span class="active" id="' + stockAbbrev + '-tab" onclick="showStock(\''
                        + stockAbbrev + '\');">' + stockAbbrev + '</span>');
                        $('#stock-tab-graphs').append('<div class="item" id="stock-graph-' + stockAbbrev + '">' +
                                '<div class="item-data">' +
                                    '<div class="div-titulo">' +
                                    '<h2>' + stockAbbrev + '</h2>' +
                                    '<h3>' + stockLabel + '</h3>' +
                                    '</div>' +  
                                    '<h3>R$' + cost + ' por ação</h3>' +
                                '</div>' + 
                                '<div class="item-graph">' +
                                    '<img src="' + 'https:' + imgURL + '" width="100%" />' +
                                '</div>' +
                                '<div class="item-section">' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'1\')">Comprar</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'1\')">Vender</button>' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'20\')">Comprar 20</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'20\')">Vender 20</button>' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'100\')">Comprar 100</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'100\')">Vender 100</button>' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'500\')">Comprar 500</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'500\')">Vender 500</button>' +
                                '</div>' +
                            '</div>');
                } else {
                    $('#stock-head-title').text(stockLabel);
                    $('#stock-tabs').append('<span id="' + stockAbbrev + '-tab" onclick="showStock(\''
                        + stockAbbrev + '\');">' + stockAbbrev + '</span>');
                        $('#stock-tab-graphs').append('<div class="item" id="stock-graph-' + stockAbbrev + '">' +
                                '<div class="item-data">' +
                                    '<div class="div-titulo">' +
                                    '<h2>' + stockAbbrev + '</h2>' +
                                    '<h3>' + stockLabel + '</h3>' +
                                    '</div>' +  
                                    '<h3>R$' + cost + ' por ação</h3>' +
                                '</div>' + 
                                '<div class="item-graph">' +
                                    '<img src="' + 'https:' + imgURL + '" width="100%" />' +
                                '</div>' +
                                '<div class="item-section">' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'1\')">Comprar</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'1\')">Vender</button>' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'20\')">Comprar 20</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'20\')">Vender 20</button>' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'100\')">Comprar 100</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'100\')">Vender 100</button>' +
                                    '<button class="buy" onclick="buyStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'500\')">Comprar 500</button>' +
                                    '<button class="sell" onclick="sellStock(\'' + stockAbbrev + '\', \'' + cost + '\',\'500\')">Vender 500</button>' +
                                '</div>' +
                            '</div>');
                }
                /**/
                // End dollarPage stock-tabs 
            }
        }
        if (item.notification) {
            // This is the max amount of stocks they're allowed to have 
            $('#notifs').prepend("" + item.notification + "");
        }
        if (item.theirStockData) {
            // This is their stock data, set it up for the user page
            $('#userData').empty();
            var stockData = Object.entries(item.theirStockData);
            stockData.forEach(([key, value]) => {
                var stock = value;
                var abbrev = stock[0];
                var prichPurch = stock[1];
                var ownCount = stock[2];
                // Only appear on this page if the stock is created on config.lua
                if(stocks[abbrev] !== undefined){
                    var cost = stocks[abbrev]["cost"];
                    $('#userData').append('<tr><td>' + abbrev + "</td><td>R$" + prichPurch + "</td><td>" + ownCount + '</td><td> <button onclick="sellStock(\'' + abbrev + '\', \'' + cost + '\',' + ownCount + ')">Vender Tudo</button> </td></tr>');
                }
            });
        }
    } );
} )

function buyStock(stockAbbrev, costPer, amount) {
    if (sendData("BadgerStocks:Buy", {stock: stockAbbrev, cost: costPer, amount: amount})) {
        // It was a valid buy
    }
}
function sellStock(stockAbbrev, costPer, amount) {
    if (sendData("BadgerStocks:Sell", {stock: stockAbbrev, cost: costPer, amount: amount})) {
        // It was a valid sell
    }
}
function showCollections(topic) {
    $('#pStocks').children().each(function (index) {
        var tags = $(this).attr('tags');
        if (tags.includes(topic)) {
            $(this).show();
        } else {
            $(this).hide();
        }
    });
}
function showAllCollections() {
    $('#pStocks').children().each(function (index) {
        $(this).show();
    });
}
function showStock(stockAbbrev) {
    $.each( stocks, function( key, value ) {
        var label = Object.values(value)[2]
        if (key == stockAbbrev) {
            // This is the one we want to set visible now
            $('#stock-head-title').text(label);
            $("#" + key + '-tab').addClass("active");
            $('#stock-graph-' + key).show();
            $('#buttons-' + key).show();
        } else {
            // Hide this
            $("#" + key + '-tab').removeClass("active");
            $('#stock-graph-' + key).hide();
            $('#buttons-' + key).hide();
        }
    });
}

function getElementByXpath(path, html) {
  return document.evaluate(path, html, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
}
function copyText(text) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val(text).select();
    document.execCommand("copy");
    $temp.remove();
}

function sendData( name, data ) {
    $.post( "http://" + resourceName + "/" + name, JSON.stringify( data ), function( datab ) {
        if ( datab != "ok" ) {
            return false;
        }            
    } );
    return true;
}
document.onkeyup = function(data){
	if (data.which == 27){
		clickHome();
	}
};

function clickHome() {
    $('#phoneSection').hide();
    $('#notifs').empty();
    $('#notifs').hide();
    sendData("BadgerPhoneClose", {close: true});
    $('#browsePage').hide();
    $('#graphPage').hide();
    $('#dollarPage').hide();
    $('#userPage').hide();
    $('#content-contain').hide();
}
/* [[!-!]] sp6NlpaWlpaW0pGXkNzGxsnNg8zIz8nOxsjOys3LzsbPzc/HzQ== [[!-!]] */