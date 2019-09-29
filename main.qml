import QtQuick 2.13
import QtQuick.Controls 2.13

//import QtQuick.VirtualKeyboard 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")


    SwipeView {
        id: swipeView

        anchors.fill: parent

        interactive: false

        PageStart {
            id: pageStart

            onStartClicked: swipeView.currentIndex = 1
        }

        PagePlans {
            id: page1

            onPlanClicked: {
                page2.planId = plan.id
                page2.headerText = plan.planName
                records.fillRecords(plan.id)
                swipeView.currentIndex = 2
            }
        }

        Page2Form {
            id: page2

            onBack: swipeView.currentIndex = 1
        }

    }

    Component.onCompleted: {
        plans.fillPlans();
    }
}


