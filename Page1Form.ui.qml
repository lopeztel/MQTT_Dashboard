import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
import MqttClient 1.0

Page {
    id: page1
    width: 480
    height: 320

    property alias status: status
    property alias portField: portField
    property alias hostnameField: hostnameField
    property alias connectButton: connectButton

    header: Label {
        text: qsTr("Input your MQTT broker")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    TextField {
        id: hostnameField
        y: 0
        width: 280
        height: 43
        Layout.fillWidth: true
        text: qsTr("")
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenterOffset: -91
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
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: (hostnameField.text != ""
                  && portField.text != "") ? true : false
    }

    TextField {
        id: portField
        x: 318
        y: 0
        width: 154
        height: 43
        text: qsTr("")
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
