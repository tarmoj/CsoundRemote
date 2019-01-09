## Csound Remote
 
**Csound Remote** is a remote GUI for controlling Csound using UDP messages. Csound must be started with --port command to listen to incoming UDP messages.

It can be run on the same or other computer or android device (currently no iOs port yet), for example it can be useful to  control a running Csound instance in Raspberry Pi from a touch screen device.

The app has **Main** tab for sending basic messages (send event, compile orchestra, send and receive control and string channel values, stop Csound) but you can load also custom QML files with according API calls, the actual UDP work will be done by the app.

The app can load QML files that describe the UI

<br>
### To start...

run csound with option --port \<portnumber\>:

	csound --port=6006 -odac your.csd
	
 Set the IP addres and according port in Csound Remote's main tab. If you change somethin, press also _Update_.
 
To test, send Event `"i 1 0 1" ` (or what corresponds to your orchestra)

<br>
### API 

The working horse of the app is class ``UdpClass``. For convenience it is forwarded to QML files as object `csound` to make the calls similar to usual Csound API calls. The conversion to required UDP messages format will be done in  ``UdpClass``.


Available methods:

...


You can send any message straight to Csound (if for example new UDP command will be added to Csound) with method

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
### Receiving channel values (getChannel)

If you need to get a channel value from csound you have to send first command to request it (csound.requestControlChannelValue(channel) or csound.requestControlChannelValue(channel))

Csound sends the value back as an UDP message. For now the port is hardcoded to be 60606. Usually users should not worry about it, it takes place "under the hood".

When the value is received, it is stored in hash `controlChannelValues` or `stringChannelValues.`   Corresponding signal `newControlChannelValue(channel, value) `or `newStringChannelValue(channel, stringValue)` is sent to the UI where it can be used within `Connections ` section 

OR

using a timer that fires a bit later than request is done and uses 
```
csound.getControlChannel(channel);
or csound.getStringChannel(channel);
```
to read the value from hash in `UdpClass`.

See source code of [main.qml](./main.qml) for examples.

<br>

### Writing and loading custom UI

You can export widgets from **CsoundQt** starting from version 0.9.6 with *File->Export to QML*. Not all widgets are supported now (currently Label, Button, Slider, SpinBox (but only with integer step), Knob are converted).

If you write your own QML UI-s it might be convenient to use Designer tool of QtCreator that has great graphical interface for designing UI-s rather intuitively.

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



<br>
Copyright (c) Tarmo Johannes 2019, trmjhnns@gmail.com 