import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 600
    height: 400

    //property var recordsList
    header: Label {
        text: qsTr("Page 2")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        text: qsTr("You are on Page 2.")
        anchors.centerIn: parent
    }

    //    ListModel {
    //        id: dataModel

    //        ListElement {
    //            date: "13.09.19"
    //            product: "Хлеб"
    //            isBought: true
    //        }
    //        ListElement {
    //            date: "12.09.19"
    //            product: "Молоко"
    //            isBought: false
    //        }
    //        ListElement {
    //            date: "11.09.19"
    //            product: "Горошек"
    //            isBought: false
    //        }
    //    }
    ListView {
        id: view
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 24
        anchors.bottomMargin: 65

        anchors.margins: 10
        anchors.fill: parent
        spacing: 10
        model: records //dataModel

        clip: true

        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        delegate: Item {
            id: itemDelegate

            width: view.width
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

                    //- buttonDeletePosition.width
                    renderType: Text.NativeRendering
                    // @disable-check M222
                    text: model.position
                    font.pixelSize: 16
                }

                RoundButton {
                    id: buttonDeletePosition

                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: "/Images/backet.png"
                }
            }
            MouseArea {
                anchors.fill: parent

                // @disable-check M223
                onClicked: {
                    //                    console.log("Щелчок по ", model.index, " итему")
                    //                    model.isBought = true
                    view.currentIndex = model.index
                    //                    model.position = "Edited"
                }

                // @disable-check M223
                onDoubleClicked: {
                    model.isBought = !model.isBought
                }
            }
            //}
        }

        footer: Rectangle {
            id: addingBlock

            width: view.width
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
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }

                TextInput {
                    id: textInputAddingName

                    //                    anchors.top: labelName.bottom
                    //                    anchors.topMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
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
                        records.add(textInputAddingName.text.toString())
                    }
                }
            }
        }
    }
}
