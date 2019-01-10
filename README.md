## Csound Remote
 
**Csound Remote** is a remote GUI for controlling Csound via UDP messages. Csound must be started with --port option to listen to incoming UDP messages.

Csound Remote can be run on the same with Csound or on another one computer or on android device (currently no iOs port yet but it is possible). For example it can be useful to  control a running Csound instance on a headless Raspberry Pi from a touch screen device.

The app has **Main** tab for sending basic messages (send event, compile orchestra, send and receive control and string channel values, stop Csound) but you can load also custom QML files for your own UI design that use almost standard Csound API calls to communicate with Csound, the actual UDP work will be done by the app under the hood.

<br>
### To start...

Run csound with option --port \<portnumber\>:

	csound --port=6006 -odac your.csd
	
Set the IP address and according port in Csound Remote's main tab. Press _Update_ to pass the change to UDP handler (no need to it next time if the address stays the same).
 
To test, send Event `"i 1 0 1" ` (or whatever corresponds to your orchestra), see in Csound console, if the event was received and the instrument run.

<br>
### API 

The working horse of the app is class ``UdpClass``. For convenience it is forwarded to QML files as object `csound` to make the calls similar to usual Csound API calls. The conversion to required UDP message format will be done in  ``UdpClass``.


*Available methods:*

You can send any message straight to Csound UDP receiver (if, for example, new UDP command will be added to new Csound version) with method

	csound.sendMessage(message)

For example

	csound.sendMessage("@volume 0.8")

Other methods are hopefully self-explanatory:

```
csound.setControlChannel(channel, value);
csound.setStringChannel(channel, string);
csound.compileOrc(code);
csound.readScore(score);
csound.requestControlChannelValue(channel);
csound.requestStringChannelValue(channel);	  
csound.closeCsound();
```

<br>
### Receiving channel values (requestChannelValue/getChannel)

If you need to get a channel value from csound you have to send first command to request it: (`csound.requestControlChannelValue(channel) or csound.requestControlChannelValue(channel)`)

Csound sends the value back as an UDP message. For now the app's receiving port is hardcoded to 60606. Usually users should not worry about it, it takes place "under the hood". If some other software is using it, you just know to stop it, if possible.

When the value is received, it is stored in hash `controlChannelValues` or `stringChannelValues and`corresponding signal `newControlChannelValue(channel, value) `or `newStringChannelValue(channel, stringValue)` is sent to the UI where it can be used within `Connections ` section 

OR

use a `Timer` in QML code that fires a bit later than request was done and uses 
```
var value = csound.getControlChannel(channel);
or 
var string = csound.getStringChannel(channel);
```
to read the value from hash in `UdpClass`.

See source code of [main.qml](./main.qml) for examples.

<br>

### Writing and loading custom UI

You can export widgets from **CsoundQt** starting from version 0.9.6 with *File->Export widgets to QML*. Not all widgets are supported now (currently Label, Button, Slider, SpinBox (but only with integer step) and Knob are converted).

If you write your own QML UI-s it might be convenient to use Designer tool of [QtCreator](http://doc.qt.io/qtcreator/creator-visual-editor.html) that has great graphical interface for designing UI-s rather intuitively.

A minimal example of a QML could look:

```
import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    color: "lightblue"
    anchors.fill: parent

    Column {
		x: 5; y:5
        Button {
            text: "Event 1"
            onClicked: csound.readScore("i 1 0 1");
        }
        Slider {width: 100; onPositionChanged: csound.setControlChannel("value", position) }
    }
}
```


You can load this or similar QML files to tabs 1 or 2 by clicking on the folder icon down on the tab-bar.

Feel free to send me e-mail when you have any questions!

<br>
Copyright (c) Tarmo Johannes 2019, trmjhnns@gmail.com 