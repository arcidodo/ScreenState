import QtQuick 2.1
import qb.components 1.0

Screen {
	id: screenstateFullScreen
	screenTitle: "Screenstate app Setup"

	onShown: {
		screenURL1.inputText = app.screenURL1;
		screenEntity_id.inputText= app.screenEntity_id;
		screenToken.inputText= app.screenToken;

		addCustomTopRightButton("Save");
	}

	onCustomButtonClicked: {
		app.saveSettings();
		hide();
	}


	function savescreenURL1(text) {
		if (text) {
			app.screenURL1 = text;
		}
	}

	function savescreenEntity_id(text) {
		if (text) {
			app.screenEntity_id = text;
		}
	}

	function savescreenToken(text) {
		if (text) {
			app.screenToken = text;
		}
	}



	Text {
		id: myLabel5
		text: "Example of valid URL: http://192.168.10.185:8123 :"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: domhaToggle.bottom
			leftMargin: 20
			topMargin: isNxt ? 20 : 15
		}
	}


	EditTextLabel4421 {
		id: screenURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "HA URL"
		anchors {
			left: parent.left
			top: myLabel5.bottom
			leftMargin: 20
			topMargin: isNxt ? 10 : 8
		}
		onClicked: {
			qkeyboard.open("URL", screenURL1.inputText, savescreenURL1)
		}
	}

	Text {
		id: myLabel6
		text: "Helper Entity_id in Home Assistant. Example : input_number.showdoorcamtoon :"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: screenURL1.bottom
			leftMargin: 20
			topMargin: isNxt ? 20 : 15
		}
	}

	EditTextLabel4421 {
		id: screenEntity_id
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "Entity_id"
		anchors {
			left: parent.left
			top: myLabel6.bottom
			leftMargin: 20
			topMargin: isNxt ? 10 : 8
		}

		onClicked: {
			qkeyboard.open("Entity_id", screenEntity_id.inputText, savescreenEntity_id)
		}
	}

	Text {
		id: myLabel7
		text: "Home Assistant long-lived access token :"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name
		anchors {
			left: parent.left
			top: screenEntity_id.bottom
			leftMargin: 20
			topMargin: isNxt ? 20 : 15
		}
	}

	EditTextLabel4421 {
		id: screenToken
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 100
		leftText: "Token"
		anchors {
			left: parent.left
			top: myLabel7.bottom
			leftMargin: 20
			topMargin: isNxt ? 10 : 8
		}

		onClicked: {
			qkeyboard.open("Token", screenToken.inputText, savescreenToken)
		}
	}

}
