import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import FileIO 1.0

App {
	id: screenstateApp

	property url 		tileUrl : "ScreenstateTile.qml"
	property url 		thumbnailIcon: "qrc:/tsc/harddisk.png"
	property 		ScreenstateFullScreen screenstateFullScreen
	property 		ScreenstateTile screenstateTile
        property bool           setscreenstate : false
        property bool           screencolormode : false
	property string 	screenURL1 : "http://192.168.10.18:8123"
	property string 	screenEntity_id : "entity_id"
	property string 	screenToken : "screenToken"

// user settings from config file
	property variant screenstateSettingsJson : {
		'screenURL1': "",
		'screenEntity_id': "",
		'screenToken': "",

	}

	FileIO {
		id: screenstateSettingsFile
		source: "file:///mnt/data/tsc/screenstate_userSettings.json"
 	}

	QtObject {
		id: p
		property url screenstateFullScreenUrl : "ScreenstateFullScreen.qml"
	}

	function init() {
		registry.registerWidget("tile", tileUrl, this, "screenstateTile", {thumbLabel: qsTr("screenstate"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", p.screenstateFullScreenUrl, this, "screenstateFullScreen");
	}

	function listProperty(item){
    		for (var p in item)
    			console.log(p + ": " + item[p]);
	}


	Component.onCompleted: {
		try {
			screenstateSettingsJson = JSON.parse(screenstateSettingsFile.read());
			screenURL1 = screenstateSettingsJson['screenURL'];
			screenEntity_id = screenstateSettingsJson['entity_id'];
			screenToken = screenstateSettingsJson['token'];

		} catch(e) {
		}
	}



	function saveSettings() {
 		var setJson = {
			"screenURL" : screenURL1,
			"entity_id" : screenEntity_id,
			"token" : screenToken,

		}

  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/screenstate_userSettings.json");
   		doc3.send(JSON.stringify(setJson));
	}

}

