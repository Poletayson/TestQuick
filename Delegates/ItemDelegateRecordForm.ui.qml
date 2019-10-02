import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import "../Constants.js" as Constants

Item {
    id: itemDelegateRecord

    property var isCurrent: ListView.isCurrentItem
    property alias buttonPositionDel: buttonPositionDel
    property alias mouseArea: mouseArea

    signal recordChanged(var planId)

    Rectangle {
        color: model.isBought ? Constants.COLOR_GREEN : Constants.COLOR_GRAY
        radius: height / 3
        anchors.fill: parent

        Text {
            id: textRecordName

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: buttonPositionDel.left
            anchors.rightMargin: 5

            //clip: true
            renderType: Text.NativeRendering
            text: model.name
            font.pixelSize: Math.max(Math.min(textRecordName.width / 15,
                                              Constants.MAX_ITEM_FONT_SIZE),
                                     Constants.MIN_ITEM_FONT_SIZE)
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }

        RoundButton {
            id: buttonPositionDel

            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter

            icon.source: "/Images/backet.png"
            background: Rectangle {

                width: buttonPositionDel.width
                height: buttonPositionDel.height

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

