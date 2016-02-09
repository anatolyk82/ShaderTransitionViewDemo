import QtQuick 2.5
import QtQuick.XmlListModel 2.0


MyPage {
    id: root

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/qml/background3.jpg"
    }

    property int errorCount: 0

    AnimatedImage {
        id: indicatorLoading
        z: 1
        width: 64
        height: 64
        visible: false
        anchors.centerIn: parent
        source: "qrc:/qml/BusyIndicator.gif"
    }

    XmlListModel {
        id: newsModel
        source: "http://news.yahoo.com/rss/topstories"
        query: "/rss/channel/item[child::media:content]"
        namespaceDeclarations: "declare namespace media = 'http://search.yahoo.com/mrss/';"

        XmlRole { name: "title"; query: "title/string()" }
        // Remove any links from the description
        XmlRole { name: "description"; query: "fn:replace(description/string(), '\&lt;a href=.*\/a\&gt;', '')" }
        XmlRole { name: "image"; query: "media:content/@url/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "pubDate"; query: "pubDate/string()" }
        onStatusChanged:  {
            if( status == XmlListModel.Ready ) {
                indicatorLoading.visible = false
                if( count > 0 ) {
                    txtDescription.text = newsModel.get(0).description
                }
            } else if ( status == XmlListModel.Null ) {
                if(newsModel == 3) {
                    console.log("Null::errorCount="+errorCount)
                    newsModel.reload()
                    errorCount += 1
                }
            } else if ( status == XmlListModel.Loading ) {
                indicatorLoading.visible = true
            } else if ( status == XmlListModel.Error ) {
                console.log("Error to load XML")
                errorString()
                errorCount += 1
                if( errorCount < 4 ) {
                    reload()
                }
                indicatorLoading.visible = false
            }
        }
    }

    Rectangle {
        id: mapWrapper
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: 420
        color: "transparent"

        ListView {
            id: listView
            model: newsModel
            anchors.fill: parent
            clip: true
            focus: true
            highlightFollowsCurrentItem: true
            spacing: 10
            delegate: Rectangle {
                id: itemWrapper
                radius: 8
                width: parent.width
                height: 100
                border.color: listView.currentIndex == index ? "white" : "transparent"
                border.width: 2
                gradient: Gradient {
                    GradientStop { id: grPos1; position: 0; color: "#88eb08" }
                    GradientStop { id: grPos2; position: 1; color: "#316500" }
                }
                Image {
                    id: imgItem
                    source: image
                    height: parent.height*0.9
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    id: txtTitle
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: imgItem.right
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    text: title
                    wrapMode: Text.WordWrap
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView.currentIndex = index
                        txtDescription.text = description
                    }
                }
            }
        }
    }

    Item {
        id: rightPanel
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: mapWrapper.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        Text {
            id: txtDescription
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            width: parent.width
            wrapMode: Text.WordWrap
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: 180
            height: 40
            text: "Back"
            onClicked: {
                stView.transitionOptions = { "forward":false }
                stView.pop()
            }
        }
    }

    Component.onCompleted: {
        newsModel.reload()
    }

}
