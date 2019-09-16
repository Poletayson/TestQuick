import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Page {
    width: 600
    height: 400

    ListModel {
        id: dataModel

        ListElement {
            date: "13.09.19"
            name: "Мария-Ра"
            color: "red"
        }
        ListElement {
            date: "12.09.19"
            name: "Магнит"
            color: "green"
        }
        ListElement {
            date: "11.09.19"
            name: "Лента"
            color: "green"
        }
        ListElement {
            date: "10.09.19"
            name: "Ярче!"
            color: "green"
        }
        ListElement {
            date: "10.09.19"
            name: "Ярче!"
            color: "green"
        }
        ListElement {
            date: "13.09.19"
            name: "Мария-Ра"
            color: "red"
        }
    }

    header: Label {
        text: qsTr("Page 1")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    //    Column {
    //        id: columnList
    //        //anchors.margins: 10
    //        anchors.fill: parent
    //        spacing: 30
    ListView {
        id: view
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 24
        anchors.bottomMargin: 65

        anchors.margins: 10
        anchors.fill: parent
        spacing: 10
        model: dataModel

        clip: true

        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        section.property: "date"
        section.delegate: Rectangle {
            //            anchors.topMargin: 35
            //            anchors.bottomMargin: 30
            width: view.width
            height: 20
            color: "lightgray"
            Text {
                anchors.centerIn: parent
                renderType: Text.NativeRendering
                font.bold: true
                text: section
            }
        }

        delegate: Item {
            id: itemDelegate

            width: view.width
            height: 60

            property var view: ListView.view
            property var isCurrent: ListView.isCurrentItem

            Rectangle {

                color: model.color
                radius: height / 3
                anchors.fill: parent

                GridLayout {
                    id: row

                    rows: 3
                    flow: GridLayout.TopToBottom
                    anchors.fill: parent

                    Text {

                        //Layout.alignment: instead
                        renderType: Text.NativeRendering
                        text: model.date
                        font.pixelSize: 14
                    }

                    Text {
                        Layout.rowSpan: 3
                        Layout.leftMargin: 20

                        renderType: Text.NativeRendering
                        // @disable-check M222
                        text: "%1%2".arg(model.name).arg(isCurrent ? "*" : "")
                        Layout.fillWidth: true
                        font.pixelSize: 18
                    }

                    RoundButton {

                        Layout.rowSpan: 3
                        Layout.rightMargin: 8
                        icon.source: "/Images/backet.png"
                    }
                }
                MouseArea {
                    anchors.fill: parent

                    onClicked: view.currentIndex = model.index

                    // @disable-check M223
                    onDoubleClicked: {

                    }
                }
            }
        }

        footer: Rectangle {
            id: button

            width: view.width
            height: 40
            radius: height / 3
            //anchors.horizontalCenter: parent.horizontalCenter
            border {
                color: "black"
                width: 1
            }

            Text {
                anchors.centerIn: parent
                renderType: Text.NativeRendering
                text: "Add"
            }

            MouseArea {
                anchors.fill: parent
                // @disable-check M222
                onClicked: dataModel.append({})
            }
        }
    }

    TextInput {
        id: textInputMain
        x: 152
        y: -36
        width: 206
        height: 20
        text: qsTr("Здесь некоторый текст страницы 1")
        font.pixelSize: 12
    }
}
