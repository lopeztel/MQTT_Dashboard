import QtQuick 2.12
import QtQuick.Controls 2.5
import MqttClient 1.0

Page {

    property alias heatIdxLabel: heatIdxLabel
    property alias humtyLabel: humtyLabel
    property alias tempLabel: tempLabel
    property alias messageModel: messageModel
    property alias subscribebutton: subscribebutton

    width: 800
    height: 480

    ListModel {
        id: messageModel
    }

    Button {
        id: subscribebutton
        x: 23
        y: 387
        text: qsTr("Connect")
        font.pointSize: 14
        enabled: client.state === MqttClient.Connected
    }

    Label {
        id: tempLabel
        x: 181
        y: 401
        text: qsTr("Temp")
        color: "white"
        font.pointSize: 14
        visible: client.state === MqttClient.Connected
    }

    Label {
        id: humtyLabel
        x: 369
        y: 401
        text: qsTr("Humty")
        color: "white"
        font.pointSize: 14
        visible: client.state === MqttClient.Connected
    }

    Label {
        id: heatIdxLabel
        x: 552
        y: 401
        text: qsTr("HeatIdx")
        color: "white"
        font.pointSize: 14
        visible: client.state === MqttClient.Connected
    }
}
