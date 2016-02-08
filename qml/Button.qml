import QtQuick 2.0

Rectangle {
    id: button

    signal clicked()

    property alias text: buttonText.text

    property bool checkable: false
    property bool checked: false

    border.color: ma.pressed ? "white" : "lightgrey"
    border.width: ma.pressed ? 2 : 1
    color: "transparent"

    /*gradient: Gradient {
        GradientStop {
            id: grPos1;
            position: 0;
            color: button.checkable ? (button.checked ? "grey" : "white" ) : (ma.pressed ? "lightgrey" : "white")
        }
        GradientStop { id: grPos2; position: 1; color: "lightgrey" }
    }*/

    Text {
        id: buttonText
        color: ma.pressed ? "white" : (button.enabled ? "lightgrey" : "black")
        font.bold: ma.pressed
        anchors.centerIn: parent
    }

    MouseArea {
        id: ma
        enabled: button.enabled
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if( button.checkable ) {
                button.checked = !button.checked
            }
            button.clicked()
        }
        //onEntered: button.border.color = "grey"
        //onExited: button.border.color = "lightgrey"

    }
}
