import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0
import ScreenStateController 1.0

Tile {
	id: screenstateTile

	function init() {}

	onClicked: {
		if (app.screenstateFullScreen) {
			app.screenstateFullScreen.show();
			console.log("ScreenState: app.screenstateFullScreen.show() called")
		}
	}
	function listProperty(item){
    		for (var p in item)
    			console.log(p + ": " + item[p]);
	}

 	function getscreenstate() {
        	var doc = new XMLHttpRequest();
        	doc.onreadystatechange = function() {
            		if (doc.readyState == XMLHttpRequest.DONE) {
				var JsonString = doc.responseText;

                                console.log(JsonString)

        			var JsonObject = JSON.parse(JsonString);
        			//retrieve values from JSON again
        			var aString = JsonObject.state;

				//check if screen is in color mode 
                                if (screenStateController.screenState == "1"){
					app.screencolormode = true
				} else {
					app.screencolormode = false
				}


                                if (aString == "110.0"){
                                        if (screenStateController.screenState != "1"){
	                                        screenStateController.wakeup();
					} 
                                        app.setscreenstate = false
                                }
                                if (aString == "111.0"){
                                        console.log("screenstate: listProperty(screenStateController)")
                                        listProperty(screenStateController)
                                        app.setscreenstate = false  
                                }

                                if (aString == "101.0"){
					if (screenStateController.screenState != "1"){
	                                        screenStateController.forceTestScreenState("1");
					}
                                        app.setscreenstate = true
                                }
                                if (aString == "102.0"){
                                        if (!app.screencolormode){
      	                                       if (screenStateController.screenState != "2"){ 
        	                                        screenStateController.forceTestScreenState("2");
                	                       }
					}
                                        app.setscreenstate = true
                                }
                                if (aString == "103.0"){
                                        if (!app.screencolormode){
                                               if (screenStateController.screenState != "3"){ 
                                                        screenStateController.forceTestScreenState("3"); //screen black/white mode
                                               }
                                        }
                                        app.setscreenstate = true
                                }
                                if (aString == "104.0"){
                                        if (!app.screencolormode){
                                               if (screenStateController.screenState != "4"){
                                                        screenStateController.forceTestScreenState("4"); //screen off
                                               }
                                        }
                                        app.setscreenstate = true
                                }
				//mainText.text = doc.responseText;
            		}
        	}
                var screenURl2 = app.screenURL1
                screenURl2 += "/api/states/"
                screenURl2 += app.screenEntity_id

                doc.open("GET", screenURl2, true);
                doc.setRequestHeader("Authorization", "Bearer " + app.screenToken);
                doc.setRequestHeader("Content-Type", "application/json");
        	doc.send();
   	 }

	Image {
		id: tileDoorcamImage1
    		width: 200; height: 140
		source: "qrc:/tsc/homeAssistantIconBig.png"
		anchors {
			verticalCenter: parent.verticalCenter
			horizontalCenter: parent.horizontalCenter
		}
		cache: false
	}

	Text {
		id: mytext
		text: "Screenstate"

		font {
			family: qfont.semiBold.name
			pixelSize: 24
		}

		anchors {
			bottom: parent.bottom
			bottomMargin: 5
			horizontalCenter: parent.horizontalCenter
		}
	}

	
	Timer {
        	id: sreeenstateTimer
        	interval: 4000
        	repeat: true
        	running: true
        	triggeredOnStart: true
                onTriggered: getscreenstate()
    	}
}

