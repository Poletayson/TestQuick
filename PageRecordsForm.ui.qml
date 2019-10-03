import QtQuick 2.13
import QtQuick.Controls 2.13

import "Constants.js" as Constants
import "Delegates" as Delegates

Page {
    id: page

    property alias viewRecords: viewRecords
    property alias mouseArea: mouseAreaBack

    property var planId
    property var planIndex
    property var headerText: ""

    signal back(int plan)

    header: Rectangle {
        id: header

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10

        height: 60

        //Button to back
        Rectangle {
            id: buttonBackToPlans

            height: header.height - Constants.SPACING * 2
            width: height

            anchors.verticalCenter: parent.verticalCenter

            Image {
                anchors.fill: parent
                anchors.margins: buttonBackToPlans.height / 10
                source: "/Images/back.png"
            }

            border {
                color: Constants.BORDER_COLOR
                width: 1
            }

            MouseArea {
                id: mouseAreaBack
                anchors.fill: parent
            }
        }

        Label {
            id: labelHeader

            anchors.left: buttonBackToPlans.right
            anchors.leftMargin: 10

            anchors.verticalCenter: parent.verticalCenter

            text: headerText
            //fontsize depends of the textlength
            font.pixelSize: Math.max(Math.min(header.width / (headerText.length / 1.2),
                                              Constants.MAX_HEADER_FONT_SIZE),
                                     Constants.MIN_HEADER_FONT_SIZE)
        }
    }

    ListView {
        id: viewRecords

        property int blockHeight: Math.max(Math.min(height / 5.5, 60), 40)

        anchors.fill: parent
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: Constants.SPACING

        spacing: Constants.SPACING

        clip: true

        model: records

        delegate: Delegates.ItemDelegateRecord {
            id: itemDelegateRecord

            height: viewRecords.blockHeight
            width: viewRecords.width
        }

        footer: Delegates.FooterRecords {
            width: viewRecords.width
        }
    }
}
