import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import "Constants.js" as Constants

Page {
    id: page
    width: 600
    height: 400

    property var planId
    property var headerText: ""

    signal back

    header: Rectangle {
        id: header

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10

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
                anchors.fill: parent
                // @disable-check M222
                onClicked: back()
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

        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: Constants.SPACING
        anchors.bottomMargin: 10

        anchors.fill: parent

        spacing: Constants.SPACING

        model: records

        clip: true

        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        property int blockHeight: Math.max(Math.min(height / 5.5, 60), 40)

        delegate: Item {
            id: itemDelegate

            width: viewRecords.width
            height: viewRecords.blockHeight

            property var isCurrent: ListView.isCurrentItem

            Rectangle {
                color: model.isBought ? "#E0FFE0" : "#F0F0F0"
                radius: height / 3
                anchors.fill: parent

                Text {
                    id: textRecordName

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    renderType: Text.NativeRendering
                    text: model.name
                    font.pixelSize: Math.max(Math.min(
                                                 textRecordName.width / 15,
                                                 Constants.MAX_ITEM_FONT_SIZE),
                                             Constants.MIN_ITEM_FONT_SIZE)
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: viewRecords.currentIndex = model.index

                    onDoubleClicked: model.isBought = model.isBought ? false : true
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
                        border.color: "#696969"
                        border.width: 1
                        radius: width / 2
                    }

                    // @disable-check M222
                    onClicked: records.removeRows(model.index,
                                                  1) //model.name = "del"
                }
            }
        }

        footer: Rectangle {
            height: Constants.SPACING * 2 + viewRecords.blockHeight
            width: viewRecords.width

            Rectangle {
                id: addingRecordBlock

                anchors.top: parent.top
                anchors.topMargin: Constants.SPACING * 2

                height: viewRecords.blockHeight
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
                    anchors.right: buttonRecordAdd.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height / 1.5

                    clip: true

                    placeholderText: "Название товара"

                    maximumLength: 30

                    text: ""

                    font.pixelSize: Math.max(Math.min(
                                                 Math.min(height * 0.6,
                                                          width / 15),
                                                 Constants.MAX_ITEM_FONT_SIZE),
                                             Constants.MIN_ITEM_FONT_SIZE)

                    color: "black"
                }

                RoundButton {
                    id: buttonRecordAdd

                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: "/Images/plus.png"

                    enabled: textInputAddingName.text.length > 0 ? true : false

                    background: Rectangle {

                        width: buttonRecordAdd.width
                        height: buttonRecordAdd.height

                        color: "white"
                        border.color: Constants.BORDER_COLOR
                        border.width: 1
                        radius: width / 2
                    }

                    // @disable-check M223
                    onClicked: {
                        // @disable-check M222
                        records.add(textInputAddingName.text.toString(), planId)
                        textInputAddingName.text = ""
                    }
                }
            }
        }
    }
}
