import QtQuick 2.13
import QtQuick.Controls 2.13
import "../Constants.js" as Constants

Rectangle {

    property alias textInputAddingName: textInputAddingName
    property alias buttonPlanAdd: buttonPlanAdd

    height: Constants.SPACING * 2 + viewPlans.blockHeight

    Rectangle {
        id: addingPlanBlock

        anchors.top: parent.top
        anchors.topMargin: Constants.SPACING * 2

        height: viewPlans.blockHeight
        width: parent.width

        radius: height / 3

        border {
            color: "black"
            width: 1
        }

        TextField {
            id: textInputAddingName

            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: buttonPlanAdd.left
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height / 1.5

            clip: true

            placeholderText: "Название списка"

            maximumLength: 30

            text: ""

            font.pixelSize: Math.max(Math.min(Math.min(height * 0.6,
                                                       width / 15),
                                              Constants.MAX_ITEM_FONT_SIZE),
                                     Constants.MIN_ITEM_FONT_SIZE)

            color: "black"
        }

        RoundButton {
            id: buttonPlanAdd

            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "/Images/plus.png"

            enabled: textInputAddingName.text.length > 0 ? true : false

            background: Rectangle {

                width: buttonPlanAdd.width
                height: buttonPlanAdd.height

                color: "white"
                border.color: Constants.BORDER_COLOR
                border.width: 1
                radius: width / 2
            }
        }
    }
}



