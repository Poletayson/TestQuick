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

        delegate: Rectangle {
            width: view.width
            height: 80
            color: model.color

            GridLayout {
                id: row

                rows: 3
                flow: GridLayout.TopToBottom
                anchors.fill: parent

                Text {
                    Layout.alignment: instead

                    renderType: Text.NativeRendering
                    text: model.date
                    font.pixelSize: 14
                }

                Text {
                    Layout.rowSpan: 3
                    Layout.leftMargin: 20

                    renderType: Text.NativeRendering
                    text: model.name
                    Layout.fillWidth: true
                    font.pixelSize: 18
                }

                RoundButton {

                    Layout.rowSpan: 3
                    icon.source: "/Images/backet.png"
                }
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
