import QtQuick 2.13
import QtQuick.Controls 2.13

import QtQuick.VirtualKeyboard 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        interactive: false


        Page1Form {
            id: page1

            onPlanClicked: {
                page2.planId = plan.id
                page2.headerText = plan.planName
                records.fillRecords(plan.id)
                swipeView.currentIndex = 1
            }


        }

        Page2Form {
            id: page2

            onBack: swipeView.currentIndex = 0
        }

//        onCurrentIndexChanged: {

//            records.fillRecords(0);
//        }
    }


//    footer: TabBar {
//        id: tabBar
//        currentIndex: swipeView.currentIndex

//        TabButton {
//            text: qsTr("Page 1")
//        }
//        TabButton {
//            text: qsTr("Page 2")
//        }
//    }


//    InputPanel {
//        id: inputPanel
//        z: 99
//        x: 0
//        y: window.height
//        width: window.width

//        states: State {
//            name: "visible"
//            when: inputPanel.active
//            PropertyChanges {
//                target: inputPanel
//                y: window.height - inputPanel.height
//            }
//        }
//        transitions: Transition {
//            from: ""
//            to: "visible"
//            reversible: true
//            ParallelAnimation {
//                NumberAnimation {
//                    properties: "y"
//                    duration: 250
//                    easing.type: Easing.InOutQuad
//                }
//            }
//        }
//    }

    Component.onCompleted: {
        plans.fillPlans();
    }
}


