import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 600
    height: 400

    property var planId
    property var headerText: ""

    signal back

    header: Rectangle {

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10

        height: labelHeader.font.pixelSize

        //Button to back
        Rectangle {
            id: buttonBackToPlans

            height: 40
            width: 40
            Image {
                anchors.fill: parent
                anchors.margins: buttonBackToPlans.height/10
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
            text: headerText
            font.pixelSize: Qt.application.font.pixelSize * 2
            //padding: 10
        }
    }

    ListView {
        id: viewRecords
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 24
        anchors.bottomMargin: 65

        anchors.margins: 10
        anchors.fill: parent
        spacing: 10
        model: records

        clip: true

        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        delegate: Item {
            id: itemDelegate

            width: viewRecords.width
            height: 60

            property var view: ListView.view
            property var isCurrent: ListView.isCurrentItem

            Rectangle {
                color: model.isBought ? "#E0FFE0" : "#F0F0F0"
                radius: height / 3
                anchors.fill: parent

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    renderType: Text.NativeRendering
                    text: model.name
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: viewRecords.currentIndex = model.index

                    onDoubleClicked: model.isBought = model.isBought ?  false : true
                }

                RoundButton {
                    id: buttonDeletePosition

                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: "/Images/backet.png"

                    // @disable-check M222
                    onClicked: records.removeRows (model.index, 1) //model.name = "del"
                }
            }
        }

        footer: Rectangle {
            id: addingBlock

            width: viewRecords.width
            height: 60
            radius: height / 3
            //anchors.horizontalCenter: parent.horizontalCenter
            border {
                color: "black"
                width: 1
            }

            Column {
                id: columnInputPosition

                height: parent.height
                width: parent.width - 100

                Text {
                    id: labelName
                    color: "#363636"

                    renderType: Text.NativeRendering
                    font.pixelSize: 12

                    text: "Название"
                    fontSizeMode: Text.VerticalFit
                    //                    anchors.top: parent.top
                    //                    anchors.topMargin: 5
                    //                    anchors.left: parent.left
                    //                    anchors.leftMargin: 5
                }

                TextInput {
                    id: textInputAddingName

                    //                    anchors.top: labelName.bottom
                    //                    anchors.topMargin: 5
                    //                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    text: qsTr("Название")

                    font.pixelSize: 14
                }
            }

            Rectangle {
                id: buttonAddRecord

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: columnInputPosition.right
                anchors.right: parent.right
                //width: parent.width
                height: 30
                //width: 100
                radius: height / 3
                //anchors.horizontalCenter: parent.horizontalCenter
                border {
                    color: "black"
                    width: 1
                }
                Text {
                    anchors.centerIn: parent
                    renderType: Text.NativeRendering
                    text: "Добавить"
                }
                MouseArea {
                    anchors.fill: parent
                    // @disable-check M223
                    onClicked: {
                        // @disable-check M222
                        records.add(textInputAddingName.text.toString(),
                                    planId)
                    }
                }
            }
        }
    }
}
