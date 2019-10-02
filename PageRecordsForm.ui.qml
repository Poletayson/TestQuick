import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import "Constants.js" as Constants
import "Delegates" as Delegates

Page {
    id: page
    width: 600
    height: 400
    property alias viewRecords: viewRecords
    property alias mouseArea: mouseArea

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
                color: "black"
                width: 1
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
            }
        }

        Label {
            id: labelHeader

            anchors.left: buttonBackToPlans.right
            anchors.leftMargin: 10

            anchors.verticalCenter: parent.verticalCenter

            text: headerText
            font.pixelSize: Math.max(Math.min(header.width / 15,
                                              Constants.MAX_HEADER_FONT_SIZE),
                                     Constants.MIN_HEADER_FONT_SIZE)
        }
    }

    ListView {
        id: viewRecords

        anchors.topMargin: Constants.SPACING
        anchors.fill: parent

        spacing: Constants.SPACING

        model: records

        clip: true

        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        property int blockHeight: Math.max(Math.min(height / 5.5, 60), 40)

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
