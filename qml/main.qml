import QtQuick 2.5
import QtQuick.Window 2.2

import ShaderTransitionView 1.0

Window {
    visible: true

    width: 1000
    height: 600

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/qml/background1.jpg"
    }

    ListModel {
        id: modelShaders
        ListElement { effect: "Wind" }
        ListElement { effect: "VerticalWind" }
        ListElement { effect: "PinWheel" }
        ListElement { effect: "CircleOpen" }
        ListElement { effect: "DirectionalWipe" }
        ListElement { effect: "RadialWipe" }
        ListElement { effect: "Pixelize" }
        ListElement { effect: "Flip" }
        ListElement { effect: "Fold" }
        ListElement { effect: "Doorway" }
        ListElement { effect: "FadeColor" }
        ListElement { effect: "MORPH" }
        ListElement { effect: "PolkaDots" }
        ListElement { effect: "Squeeze" }
        ListElement { effect: "HorizontalSlide" }
        ListElement { effect: "VerticalSlide" }
        ListElement { effect: "CrossZoom" }
        ListElement { effect: "Swirl" }
    }

    Rectangle {
        id: wrapperContent

        color: "transparent"
        border.color: "lightgrey"

        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: wrapperRightPanel.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        STView {
            id: stView
            anchors.fill: parent
            duration: 800
        }
    }


    Rectangle {
        id: wrapperRightPanel
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: 200
        color: "transparent"

        ListView {
            id: listView
            clip: true
            anchors.fill: parent
            model: modelShaders
            spacing: 5
            focus: true
            delegate: Rectangle {
                id: delegateWrapper
                width: parent.width
                height: 60
                color: "transparent"
                border.color: delegateWrapper.ListView.isCurrentItem ? "white" : "lightgrey"
                border.width: delegateWrapper.ListView.isCurrentItem ? 2 : 1
                Text {
                    color: delegateWrapper.ListView.isCurrentItem ? "white" : "lightgrey"
                    anchors.centerIn: parent
                    text: effect
                    font.bold: delegateWrapper.ListView.isCurrentItem ? true : false
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView.currentIndex = index
                        if( effect == "Wind" ) {
                            stView.transition = ShaderTransitionView.EffectWIND
                        } else if( effect == "VerticalWind" ) {
                            stView.transition = ShaderTransitionView.EffectVERTICALWIND
                        } else if( effect == "PinWheel" ) {
                            stView.transition = ShaderTransitionView.EffectPINWHEEL
                        } else if( effect == "CircleOpen" ) {
                            stView.transition = ShaderTransitionView.EffectCIRCLEOPEN
                        } else if( effect == "DirectionalWipe" ) {
                            stView.transition = ShaderTransitionView.EffectDIRECTIONALWIPE
                        } else if( effect == "Flip" ) {
                            stView.transition = ShaderTransitionView.EffectFLIP
                        } else if( effect == "Fold" ) {
                            stView.transition = ShaderTransitionView.EffectFOLD
                        } else if( effect == "Doorway" ) {
                            stView.transition = ShaderTransitionView.EffectDOORWAY
                        } else if( effect == "FadeColor" ) {
                            stView.transition = ShaderTransitionView.EffectFADECOLOR
                        } else if( effect == "MORPH" ) {
                            stView.transition = ShaderTransitionView.EffectMORPH
                        } else if( effect == "PolkaDots" ) {
                            stView.transition = ShaderTransitionView.EffectPOLKADOTS
                        } else if( effect == "Squeeze" ) {
                            stView.transition = ShaderTransitionView.EffectSQUEEZE
                        } else if( effect == "RadialWipe" ) {
                            stView.transition = ShaderTransitionView.EffectRADIALWIPE
                        } else if( effect == "HorizontalSlide" ) {
                            stView.transition = ShaderTransitionView.EffectHORIZONTALSLIDE
                        } else if( effect == "VerticalSlide" ) {
                            stView.transition = ShaderTransitionView.EffectVERTICALSLIDE
                        } else if( effect == "CrossZoom" ) {
                            stView.transition = ShaderTransitionView.EffectCROSSZOOM
                        } else if( effect == "Swirl" ) {
                            stView.transition = ShaderTransitionView.EffectSWIRL
                        } else if( effect == "Pixelize" ) {
                            stView.transition = ShaderTransitionView.EffectPIXELIZE
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        stView.push("qrc:/qml/PageExample1.qml")
    }
}


