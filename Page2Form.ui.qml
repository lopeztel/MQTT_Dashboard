import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
//import QtCharts 2.3
import MqttClient 1.0

Page {
    width: 480
    height: 320
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
        x: 7
        y: 221
        text: qsTr("Connect")
        enabled: client.state === MqttClient.Connected
    }

    Label {
        id: tempLabel
        x: 104
        y: 236
        text: qsTr("Temp")
        visible: client.state === MqttClient.Connected
    }

    Label {
        id: humtyLabel
        x: 228
        y: 236
        text: qsTr("Humty")
        visible: client.state === MqttClient.Connected
    }

    Label {
        id: heatIdxLabel
        x: 352
        y: 236
        text: qsTr("HeatIdx")
        visible: client.state === MqttClient.Connected
    }
}
