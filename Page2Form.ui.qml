import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
//import QtCharts 2.3
import MqttClient 1.0

Page {
    width: 800
    height: 480
    property alias heatIdxLabel: heatIdxLabel
    property alias humtyLabel: humtyLabel
    property alias tempLabel: tempLabel
    property alias messageModel: messageModel
    property alias subscribebutton: subscribebutton

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
        font.pointSize: 14
        visible: client.state === MqttClient.Connected
    }

    Label {
        id: humtyLabel
        x: 369
        y: 401
        text: qsTr("Humty")
        font.pointSize: 14
        visible: client.state === MqttClient.Connected
    }

    Label {
        id: heatIdxLabel
        x: 552
        y: 401
        text: qsTr("HeatIdx")
        font.pointSize: 14
        visible: client.state === MqttClient.Connected
    }
}
