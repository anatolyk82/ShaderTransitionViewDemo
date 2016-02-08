import QtQuick 2.5
import QtPositioning 5.3
import QtLocation 5.3

MyPage {
    id: root

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/qml/background2.jpg"
    }

    Plugin {
        id: pluginOSM
        name: "osm"
    }

    Rectangle {
        id: mapWrapper
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: rightPanel.left
        anchors.rightMargin: 10

        Map {
            id: worldMap
            plugin: pluginOSM
            anchors.fill: parent

            center {
                latitude: 47.288471790172444
                longitude: 39.715083257720266
            }

            zoomLevel: (maximumZoomLevel-minimumZoomLevel)/1.1
        }

        Rectangle {
            id: verticalLine
            width: 1
            height: parent.height
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2
            color: "grey"
        }
        Rectangle {
            id: wrizontalLine
            height: 1
            width: parent.height
            anchors.top: parent.top
            anchors.topMargin: parent.height/2
            anchors.left: parent.left
            anchors.right: parent.right
            color: "grey"
        }
    }

    Item {
        id: rightPanel
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: 230

        Column {
            anchors.fill: parent
            spacing: 10
            Text {
                color: "white"
                font.pixelSize: 20
                text: "The map center at:"
            }
            Item { height: 10; width: 10 }
            Text {
                color: "white"
                text: "Latitude: " + ((""+worldMap.center).split(",")[0])
            }
            Text {
                color: "white"
                text: "Longitude: " + ((""+worldMap.center).split(",")[1])
            }
            Item { height: 10; width: 10 }
        }
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            spacing: 10
            Button {
                width: 180
                height: 40
                text: "Next"
                onClicked: {
                    stView.push("qrc:/qml/PageExample3.qml")
                }
            }
            Button {
                width: 180
                height: 40
                text: "Back"
                onClicked: {
                    stView.transitionOptions = { "forward":false }
                    stView.pop()
                }
            }
        }
    }
}
