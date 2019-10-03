import QtQuick 2.13
import QtQuick.Controls 2.13

import "Constants.js" as Constants
import "Delegates" as Delegates

Page {
    id: page

    property alias viewPlans: viewPlans

    signal planClicked(var plan)

    header: Label {
        id: header

        text: qsTr("Списки покупок")
        font.pixelSize: Math.max(Math.min(width / 10,
                                          Constants.MAX_HEADER_FONT_SIZE),
                                 Constants.MIN_HEADER_FONT_SIZE)
        padding: 10
    }

    ListView {
        id: viewPlans

        property int blockHeight: Math.max(Math.min(
                                               height / 5.5,
                                               60),
                                           40)

        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 0
        anchors.bottomMargin: 10
        anchors.fill: parent

        spacing: Constants.SPACING
        clip: true

        model: plans

        //splitting lists by dates
        section.property: "date"
        section.delegate: Rectangle {
            width: viewPlans.width
            height: Constants.SPACING * 2 + 20

            Rectangle {
                anchors.fill: parent
                anchors.topMargin: Constants.SPACING
                anchors.bottomMargin: Constants.SPACING

                border.color: Constants.BORDER_COLOR
                border.width: 1

                color: "lightgray"

                Text {
                    anchors.centerIn: parent
                    renderType: Text.NativeRendering
                    font.bold: true
                    text: section
                }
            }
        }

        delegate: Delegates.ItemDelegatePlan {
            id: itemDelegatePlan

            height: viewPlans.blockHeight
            width: viewPlans.width
        }

        footer: Delegates.FooterPlans {
            width: viewPlans.width
        }
    }
}
