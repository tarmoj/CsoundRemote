import QtQuick 2.0
import QtQuick.Controls 2.0 // NB! Requires Qt 5.7 or later. Rewrite with QtQuick.Controls 1.X if using older Qt versions 

Rectangle {
	color: "#00ff00"
	width: 326
	height: 472
	anchors.fill: parent


	Flickable {
	anchors.fill: parent
	contentWidth: 326
	contentHeight: 472


				   Item {
					   id: scaleItem
					   anchors.fill: parent
				   }

				   PinchArea {
					   anchors.fill: parent
					   pinch.maximumScale: 2.5
					   pinch.minimumScale: 0.6
					   pinch.target: scaleItem

					   MouseArea {  // necessary for co-existense of flickable an pincharea
						   anchors.fill: parent
						   onClicked: console.log("Clicked tiny")
						   propagateComposedEvents: true
					   }
				   }
				   
	Slider {
		x: 113 * scaleItem.scale
		y: 257  * scaleItem.scale
		width: 30 * scaleItem.scale
		height: 100 * scaleItem.scale
		from: 200
		to: 1000
		value: 832
		orientation: Qt.Vertical
		onPositionChanged: csound.setControlChannel("freq", valueAt(position))
	}

	Rectangle {
		x: 63 * scaleItem.scale
		y: 28  * scaleItem.scale
		width: 243 * scaleItem.scale
		height: 46 * scaleItem.scale
		color: "#aaffff"
		border.width: 2
		radius: 5
		border.color: "#0000ff"

		Label {
			anchors.centerIn: parent
			font.pixelSize: 20 * scaleItem.scale
			text: "QML export test"
			color: "#0000ff"
		font.family: "Courier New"
		}
	}

	Button { 
		x: 80 * scaleItem.scale
		y: 192 * scaleItem.scale
		width: 100 * scaleItem.scale
		height: 30 * scaleItem.scale
		text: "Play"
		checkable: true
		property double pressedValue: 1
		property bool isEnventButton: true
onCheckedChanged: (checked) ? csound.readScore("i1 0 -1") : csound.readScore("i -1 0 -1")	}


	Dial {
		x: 159 * scaleItem.scale
		y: 258  * scaleItem.scale
		width: 127 * scaleItem.scale
		height: 99 * scaleItem.scale
		from: 0
		to: 3
		value: 0.423983
		onPositionChanged: csound.setControlChannel("volume", from + position*(to-from))
	}

	SpinBox {
		x: 192 * scaleItem.scale
		y: 114  * scaleItem.scale
		width: (52 + up.indicator.width + down.indicator.width)  * scaleItem.scale
		height: 34  * scaleItem.scale
		from: 0
		to: 99
		stepSize: 1
		value: 3
		editable: true
		onValueChanged: csound.setControlChannel("number", value)
	}
	Button { 
		x: 90 * scaleItem.scale
		y: 422 * scaleItem.scale
		width: 100 * scaleItem.scale
		height: 30 * scaleItem.scale
		text: "Bell"
		property double pressedValue: 1
		property bool isEnventButton: true
		onClicked: csound.readScore("i 2 0 2") 
	}


	Rectangle {
		x: 72 * scaleItem.scale
		y: 119  * scaleItem.scale
		width: 80 * scaleItem.scale
		height: 25 * scaleItem.scale
		color: "transparent"

	border.width: 0
		Label {
			anchors.centerIn: parent
			font.pixelSize: 12 * scaleItem.scale
			text: "Harmonics:"
			color: "#000000"
		font.family: "Arial"
		}
	}


	Rectangle {
		x: 42 * scaleItem.scale
		y: 306  * scaleItem.scale
		width: 48 * scaleItem.scale
		height: 26 * scaleItem.scale
		color: "transparent"

	border.width: 0
		Label {
			anchors.centerIn: parent
			font.pixelSize: 10 * scaleItem.scale
			text: "Freq"
			color: "#000000"
		font.family: "Arial"
		}
	}

	} // end Flickable
} // end Rectangle
