import QtQuick 2.13
import QtQuick.Controls 2.13
//import QtQuick.Layouts 1.3
import "../Constants.js" as Constants

Item {
    id: itemDelegatePlan

    property var view: ListView.view
    property var isCurrent: ListView.isCurrentItem
    property alias areaPlanToRecords: areaPlanToRecords
    property alias buttonPlanDel: buttonPlanDel

    Rectangle {

        color: "#D5FFD5"
        radius: height / 3
        anchors.fill: parent

        Text {
            id: textPlanName

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: buttonPlanDel.left
            anchors.rightMargin: 5

            //clip: true

            renderType: Text.NativeRendering

            text: model.name
            font.pixelSize: Math.max(Math.min(textPlanName.width / 15,
                                              Constants.MAX_ITEM_FONT_SIZE),
                                     Constants.MIN_ITEM_FONT_SIZE)
        }


        MouseArea {
            id: areaPlanToRecords

            anchors.fill: parent
        }

        RoundButton {
            id: buttonPlanDel

            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "/Images/backet.png"

            background: Rectangle {

                width: buttonPlanDel.width
                height: buttonPlanDel.height

                color: "white"
                border.color: Constants.BORDER_COLOR
                border.width: 1
                radius: width / 2
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

