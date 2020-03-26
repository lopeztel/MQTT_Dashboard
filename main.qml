import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.VirtualKeyboard 2.4 //comment for Android
import MqttClient 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtCharts 2.3
import QtQuick.Controls.Material 2.3

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    maximumHeight: 480
    maximumWidth: 800
    minimumHeight: 480
    minimumWidth: 800
    Material.accent: Material.Teal

    title: qsTr("MQTT Dashboard")

    property var tempSubscription: 0
    property var humtySubscription: 0
    property var heatIdxSubscription: 0
    property var relaySubscription: 0
    property var solidSubscription: 0
    property var fadeSubscription: 0
    property bool relay : false
    property int tempSamples : 0
    property bool firstTemp : true
    property int humtySamples : 0
    property bool firstHumty: true
    property int heatIdxSamples : 0
    property bool firstHeatIdx : true
    property var startDate

    MqttClient {
        id: client
        clientId: "Qt_MQTT_Dashboard" //change this for android, multiple clients w/same name are a problem
        username: "pi" //MQTT broker username
        password: "<your_password>" //MQTT broker password
        cleanSession: true
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
            connectButton.onClicked: {
                client.hostname = hostnameField.text
                client.port = portField.text
                if (client.state === MqttClient.Connected) {
                    client.disconnectFromHost()
                    tempSubscription = 0
                    humtySubscription = 0
                    heatIdxSubscription = 0
                    relaySubscription = 0
                    Qt.quit()
                } else {
                    client.connectToHost()
                }
            }

            function stateToString(value) {
                if (value === 0)
                    return "Disconnected"
                else if (value === 1)
                    return "Connecting"
                else if (value === 2)
                    return "Connected"
                else
                    return "Unknown"
            }

            status.text: "Status:" + stateToString(client.state)

        }

        Page2Form {

            ChartView {
                enabled: client.state === MqttClient.Connected
                id: chartview
                antialiasing: true
                theme: ChartView.ChartThemeDark
                animationOptions: ChartView.SeriesAnimations
                x: 8
                y: 9
                width: 774
                height: 318
                Component.onCompleted: startDate = new Date()
                ValueAxis {
                    id: axisY
                    //min: 15.0
                    //max: 25.0
                }
                ValueAxis {
                    id: axisY2
                    min: 0
                    max: 100.0
                }
                DateTimeAxis {
                    id: timeAxis
                    format: "hh:mm"
                    //min: startDate
                    //max: startDate
                }
                SplineSeries {
                    name: "Temperature"
                    id: tempSeries
                    useOpenGL: true
                    axisY: axisY
                    //axisX: axisX
                    axisX: timeAxis
                }
                SplineSeries {
                    name: "Humidity"
                    id: humtySeries
                    useOpenGL: true
                    axisYRight: axisY2
                    //axisX: axisX
                    axisX: timeAxis
                }
                SplineSeries {
                    name: "Heat Index"
                    id: heatIdxSeries
                    useOpenGL: true
                    axisY: axisY
                    axisX: timeAxis
                }
            }

            function tempMessage(payload)
            {
                if (tempSamples <= 100){
                    if (firstTemp){
                        timeAxis.min = new Date()
                        firstTemp = false
                    }
                    timeAxis.max = new Date()
                    if (payload >= axisY.max){
                        axisY.max = payload + 5
                    }
                    if (payload < axisY.min){
                        axisY.min= payload - 5
                    }

                    tempSeries.append(new Date(),payload)
                    tempSamples++
                }else{
                    tempSeries.remove(0)
                    timeAxis.min = new Date(tempSeries.at(0).x)
                    if (payload >= axisY.max){
                        axisY.max = payload + 5
                    }
                    if (payload < axisY.min){
                        axisY.min= payload - 5
                    }
                    tempSeries.append(new Date(),payload)
                }

                tempLabel.text = "Temp: " + payload + " °C"
            }
            function humtyMessage(payload)
            {
                if (humtySamples <= 100){
                    if (firstHumty){
                        timeAxis.min = new Date()
                        firstHumty = false
                    }
                    timeAxis.max = new Date()
                    humtySeries.append(new Date(),payload)
                    humtySamples++
                }else{
                    humtySeries.remove(0)
                    timeAxis.min = new Date(humtySeries.at(0).x)
                    timeAxis.max = new Date()
                    humtySeries.append(new Date(),payload)
                }

                humtyLabel.text = "Humty: " + payload + " %"
            }
            function heatIdxMessage(payload)
            {
                if (heatIdxSamples <= 100){
                    if (firstHeatIdx){
                        timeAxis.min = new Date()
                        firstHeatIdx = false
                    }
                    timeAxis.max = new Date()
                    heatIdxSeries.append(new Date(),payload)
                    heatIdxSamples++
                }else{
                    heatIdxSeries.remove(0)
                    timeAxis.min = new Date(heatIdxSeries.at(0).x)
                    timeAxis.max = new Date()
                    heatIdxSeries.append(new Date(),payload)
                }
                heatIdxLabel.text = "HeatIdx: " + payload + " °C"
            }
            subscribebutton.onClicked: {
                tempSubscription = client.subscribe(qsTr("/mqtt/temperature"))
                tempSubscription.messageReceived.connect(tempMessage)
                humtySubscription = client.subscribe(qsTr("/mqtt/humidity"))
                humtySubscription.messageReceived.connect(humtyMessage)
                heatIdxSubscription = client.subscribe(qsTr("/mqtt/heatIndex"))
                heatIdxSubscription.messageReceived.connect(heatIdxMessage)
                subscribebutton.enabled = false
            }
        }

        Page3Form{
            function relayMessage(payload)
            {
                if (payload === 1){
                    relay = true
                } else {
                    relay = false
                }
            }
            function solidMessage(payload){
                if (payload !==0){
                    solidButton.enabled = true
                }else{
                    solidButton.enabled = false
                }
            }
            function fadeMessage(payload){
                if (payload !==0){
                    fadeButton.enabled = true
                }else{
                    fadeButton.enabled = false
                }
            }

            relaybutton.onClicked: {
                relaySubscription = client.subscribe(qsTr("/mqtt/relay"))
                relaySubscription.messageReceived.connect(relayMessage)
                solidSubscription = client.subscribe(qsTr("/mqtt/lights/solid"))
                solidSubscription.messageReceived.connect(solidMessage)
                fadeSubscription = client.subscribe(qsTr("/mqtt/lights/fade"))
                fadeSubscription.messageReceived.connect(fadeMessage)
                relaySwitch.enabled = true
                relaybutton.enabled = false
                solidButton.enabled = true
                fadeButton.enabled = true
            }

            relaySwitch.onReleased: {
                if (relaySwitch.checked)
                {
                    client.publish(qsTr("/mqtt/relay"),1,2,true)
                }
                else {
                    client.publish(qsTr("/mqtt/relay"),0,2,true)
                }
            }

            solidButton.onClicked: {
                //client.publish(qsTr("/mqtt/lights/fade"),String.fromCharCode(0),2,false)
                client.publish(qsTr("/mqtt/lights/solid"),String.fromCharCode(1),2,false)
                red_slider.enabled = true
                green_slider.enabled = true
                blue_slider.enabled = true
            }
            red_slider.onPressedChanged: {
                if (!red_slider.pressed){
                    client.publish(qsTr("/mqtt/lights/red"),String.fromCharCode(red_slider.value),2,false)
                }
            }
            green_slider.onPressedChanged: {
                if (!green_slider.pressed){
                    client.publish(qsTr("/mqtt/lights/green"),String.fromCharCode(green_slider.value),2,false)
                }
            }
            blue_slider.onPressedChanged: {
                if (!blue_slider.pressed){
                    client.publish(qsTr("/mqtt/lights/blue"),String.fromCharCode(blue_slider.value),2,false)
                }
            }
            fadeButton.onClicked: {
                client.publish(qsTr("/mqtt/lights/fade"),String.fromCharCode(1),2,false)
                //client.publish(qsTr("/mqtt/lights/solid"),String.fromCharCode(0),2,false)
                red_slider.enabled = false
                green_slider.enabled = false
                blue_slider.enabled = false
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Broker")
        }
        TabButton {
            text: qsTr("Weather")
        }
        TabButton {
            text: qsTr("RGB/Relay")
        }
    }

//Comment Input Panel section for Android ....

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
