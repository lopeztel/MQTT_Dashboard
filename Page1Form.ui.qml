import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
import MqttClient 1.0

Page {
    id: page1
    width: 800
    height: 480

    property alias status: status
    property alias portField: portField
    property alias hostnameField: hostnameField
    property alias connectButton: connectButton

    header: Label {
        text: qsTr("MQTT Broker")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    TextField {
        id: hostnameField
        y: 0
        width: 348
        height: 43
        Layout.fillWidth: true
        text: qsTr("")
        font.pointSize: 15
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenterOffset: -159
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "<Enter host running MQTT broker>"
        enabled: client.state === MqttClient.Disconnected
    }

    Button {
        id: connectButton
        x: 36
        y: 49
        width: 397
        height: 48
        text: client.state === MqttClient.Connected ? "Disconnect" : "Connect"
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: (hostnameField.text != ""
                  && portField.text != "") ? true : false
    }

    TextField {
        id: portField
        x: 498
        y: 0
        width: 219
        height: 43
        text: qsTr("")
        font.pointSize: 15
        horizontalAlignment: Text.AlignHCenter
        placeholderText: "<Enter port number>"
        inputMethodHints: Qt.ImhDigitsOnly
        enabled: client.state === MqttClient.Disconnected
    }

    Label {
        id: status
        x: 196
        y: 104
        width: 138
        height: 37
        padding: 10
        text: qsTr("Label")
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        //enabled: client.state === MqttClient.Connected
        color: (client.state != MqttClient.Connected) ? "#000000" : "#66CD00"
        visible: (client.state != MqttClient.Connecting)
    }

    BusyIndicator {
        id: busyIndicator
        x: 211
        y: 93
        running: client.state === MqttClient.Connecting
    }
}
