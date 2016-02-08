import QtQuick 2.5
import ShaderTransitionView 1.0

MyPage {
    id: root

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/qml/background1.jpg"
    }

    Text {
        id: textTitle
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: "ShaderTransitionView demo"
        color: "white"
        font.pixelSize: 30
    }

    Flickable {
        id: flick

        width: parent.width*0.98
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textTitle.bottom
        anchors.topMargin: 10
        anchors.bottom: btnStart.top
        anchors.bottomMargin: 10
        contentWidth: edit.paintedWidth
        contentHeight: edit.paintedHeight
        clip: true

        flickableDirection: Flickable.VerticalFlick

        TextEdit {
            id: edit
            color: "white"
            width: flick.width
            height: flick.height
            focus: true
            wrapMode: TextEdit.Wrap
            textFormat: TextEdit.RichText
            readOnly: true
        }
    }

    Button {
        id: btnStart
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: 180
        height: 40
        text: "Start"
        onClicked: {
            stView.push("qrc:/qml/PageExample2.qml")
        }
    }


    Component.onCompleted: {
        var request = new XMLHttpRequest()
        request.open('GET', "https://github.com/anatolyk82/ShaderTransitionViewDemo/blob/master/qml/page.html" )
        request.onreadystatechange = function(event) {
            if (request.readyState == XMLHttpRequest.DONE) {
                edit.text = request.responseText
            }
            //indicatorLoadingChangeLog.visible = false
        }
        request.send()
        //indicatorLoadingChangeLog.visible = true
    }

}

