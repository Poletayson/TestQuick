import QtQuick 2.13
import QtQuick.Controls 2.13
//import QtQuick.Layouts 1.3
import "Constants.js" as Constants

Page {
    id: page

    width: 600
    height: 400

    property var currentId

    signal planClicked(var plan)

    header: Label {
        id: header

        text: qsTr("Списки покупок")
        font.pixelSize: Math.max(
                            Math.min(width / 10,
                                     Constants.MAX_HEADER_FONT_SIZE),
                            Constants.MIN_HEADER_FONT_SIZE) //Qt.application.font.pixelSize * 2
        padding: 10
    }

    ListView {
        id: viewPlans
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 0
        anchors.bottomMargin: 10

        anchors.fill: parent
        spacing: Constants.SPACING

        model: plans

        clip: true

        property int blockHeight: Math.max(Math.min(height / 5.5, 60), 40)

        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

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

        delegate: Item {
            id: itemDelegatePlan

            width: viewPlans.width
            height: viewPlans.blockHeight

            property var view: ListView.view
            property var isCurrent: ListView.isCurrentItem

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

                    clip: true

                    renderType: Text.NativeRendering

                    text: model.name //"%1%2".arg().arg(isCurrent ? "*" : "")
                    font.pixelSize: Math.max(Math.min(
                                                 textPlanName.width / 15,
                                                 Constants.MAX_ITEM_FONT_SIZE),
                                             Constants.MIN_ITEM_FONT_SIZE)
                }

                MouseArea {
                    id: areaPlanToRecords

                    anchors.fill: parent

                    onClicked: viewPlans.currentIndex = model.index

                    // @disable-check M223
                    onDoubleClicked: {
                        // @disable-check M222
                        planClicked({
                                        "id": model.id,
                                        "planName": model.name
                                    })
                    }
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

                    // @disable-check M222
                    onClicked: plans.removeRow(model.index)
                }
            }
        }

        footer: Rectangle {
            height: Constants.SPACING * 2 + viewPlans.blockHeight
            width: viewPlans.width

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

                    font.pixelSize: Math.max(Math.min(
                                                 Math.min(height * 0.6,
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

                    // @disable-check M223
                    onClicked: {
                        // @disable-check M222
                        plans.add(textInputAddingName.text.toString(),
                                  Qt.formatDateTime(new Date(), "yyyy-MM-dd"))
                        textInputAddingName.text = ""
                    }
                }
            }
        }
    }
}
