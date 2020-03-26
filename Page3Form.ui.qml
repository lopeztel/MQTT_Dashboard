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
    width: 800
    height: 480

    Button {
        id: relaybutton
        x: 140
        y: 296
        width: 128
        height: 48
        text: qsTr("Connect")
        font.pointSize: 14
        enabled: client.state === MqttClient.Connected
    }

    Switch {
        id: relaySwitch
        x: 564
        y: 296
        text: qsTr("Relay")
        font.pointSize: 14
        enabled: false
        checked: relay
    }

    Slider {
        id: red_slider
        x: 29
        y: 103
        width: 360
        height: 57
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
        width: 360
        height: 50
        stepSize: 1
        to: 255
        value: 0
        enabled: false
    }

    Slider {
        id: blue_slider
        x: 29
        y: 192
        width: 360
        height: 54
        stepSize: 1
        to: 255
        value: 0
        enabled: false
    }

    Text {
        id: element
        x: 107
        y: 68
        width: 234
        height: 38
        text: qsTr("RGB LED controls")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 24
    }

    Text {
        id: element1
        x: 502
        y: 68
        width: 234
        height: 38
        text: qsTr("RGB LED effects")
        font.pixelSize: 24
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Button {
        id: solidButton
        x: 549
        y: 112
        text: qsTr("Solid Color")
        font.pointSize: 14
        enabled: false
    }

    Button {
        id: fadeButton
        x: 566
        y: 176
        width: 106
        height: 48
        text: qsTr("Fade")
        font.pointSize: 14
        enabled: false
    }
}
