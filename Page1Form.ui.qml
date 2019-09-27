import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Page {
    width: 600
    height: 400

    property var currentId
    signal planClicked(var plan)

    header: Label {
        text: qsTr("Списки покупок")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    ListView {
        id: viewPlans
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 24
        anchors.bottomMargin: 65

        anchors.margins: 10
        anchors.fill: parent
        spacing: 10
        model: plans

        clip: true

        highlight: Rectangle {
            color: "skyblue"
        }
        highlightFollowsCurrentItem: true

        section.property: "date"
        section.delegate: Rectangle {
            //            anchors.topMargin: 35
            //            anchors.bottomMargin: 30


            width: viewPlans.width
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
            id: itemDelegatePlan

            width: viewPlans.width
            height: 60

            property var view: ListView.view
            property var isCurrent: ListView.isCurrentItem

            //property int planId: model.id
            Rectangle {

                color: "#D5FFD5"
                radius: height / 3
                anchors.fill: parent


                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 5

                        renderType: Text.NativeRendering
                        // @disable-check M222
                        text: "%1%2".arg(model.name).arg(isCurrent ? "*" : "")
                        Layout.fillWidth: true
                        font.pixelSize: 18
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


                //                }
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
                        border.color: "#696969"
                        border.width: 1
                        radius: width/2
                    }


                    // @disable-check M222
                    onClicked: plans.removeRow(model.index)
                }
            }
        }

        footer: Rectangle {
            id: addingPlanBlock

            width: viewPlans.width
            height: 60
            radius: height / 3
            //anchors.horizontalCenter: parent.horizontalCenter
            border {
                color: "black"
                width: 1
            }

//            Column {
//                id: columnInputPosition

//                height: parent.height
//                width: parent.width - 100

                Text {
                    id: labelName

                    anchors.left: parent.left
                    anchors.leftMargin: 15

                    color: "#363636"

                    renderType: Text.NativeRendering
                    font.pixelSize: 12

                    text: "Название"
                    fontSizeMode: Text.VerticalFit
                    ///anchors.top: parent.top
                    //anchors.topMargin: 5
                    //anchors.left: parent.left
                    //anchors.leftMargin: 5
                }

                TextInput {
                    id: textInputAddingName

                    //                    anchors.top: labelName.bottom
                    //                    anchors.topMargin: 5
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.right: buttonPlanAdd.left
                    anchors.rightMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Название")

                    font.pixelSize: 14
                }
            //}


            RoundButton {
                id: buttonPlanAdd

                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "/Images/plus.png"
                background: Rectangle {

                    width: buttonPlanAdd.width
                    height: buttonPlanAdd.height

                    color: "white"
                    border.color: "#696969"
                    border.width: 1
                    radius: width/2
                }

                // @disable-check M222
                onClicked: plans.add(textInputAddingName.text.toString(),
                                        Qt.formatDateTime(new Date(), "yy-MM-dd"))
            }


        }
    }
}
