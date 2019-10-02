import QtQuick 2.13
import QtQuick.Controls 2.13

//import QtQuick.VirtualKeyboard 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Списки покупок")


    SwipeView {
        id: swipeView

        anchors.fill: parent

        interactive: false

        PageStart {
            id: pageStart

            onStartClicked: swipeView.currentIndex = 1
        }

        PagePlans {
            id: pagePlans

            onPlanClicked: {
                pageRecords.planId = plan.id
                pageRecords.planIndex = plan.index
                pageRecords.headerText = plan.planName
                records.fillRecords(plan.id)
                swipeView.currentIndex = 2
            }
        }

        PageRecords {
            id: pageRecords

            onBack: {
                plans.refreshCounts(planIndex)
                swipeView.currentIndex = 1
            }


        }

    }

    Component.onCompleted: {
        plans.fillPlans();
    }

}


