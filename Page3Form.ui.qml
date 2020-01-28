import QtQuick 2.12
import QtQuick.Controls 2.5
import MqttClient 1.0

Page {
    property alias blue_slider: blue_slider
    property alias green_slider: green_slider
    property alias red_slider: red_slider
    property alias fadeButton: fadeButton
    property alias solidButton: solidButton
    property alias relaySwitch: relaySwitch
    property alias relaybutton: relaybutton
    width: 480
    height: 320

    Button {
        id: relaybutton
        x: 12
        y: 9
        width: 97
        height: 48
        text: qsTr("Connect")
        enabled: client.state === MqttClient.Connected
    }

    Switch {
        id: relaySwitch
        x: 200
        y: 9
        text: qsTr("Relay")
        enabled: false
        checked: relay
    }

    Slider {
        id: red_slider
        x: 29
        y: 103
        font.family: "Times New Roman"
        stepSize: 1
        to: 255
        value: 0
        enabled: false
    }

    Slider {
        id: green_slider
        x: 29
        y: 149
        stepSize: 1
        to: 255
        value: 0
        enabled: false
    }

    Slider {
        id: blue_slider
        x: 29
        y: 192
        stepSize: 1
        to: 255
        value: 0
        enabled: false
    }

    Text {
        id: element
        x: 12
        y: 68
        width: 234
        height: 38
        text: qsTr("RGB LED controls")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }

    Text {
        id: element1
        x: 235
        y: 68
        width: 234
        height: 38
        text: qsTr("RGB LED effects")
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: solidButton
        x: 299
        y: 112
        text: qsTr("Solid Color")
        enabled: false
    }

    Button {
        id: fadeButton
        x: 299
        y: 176
        width: 106
        height: 48
        text: qsTr("Fade")
        enabled: false
    }
}
