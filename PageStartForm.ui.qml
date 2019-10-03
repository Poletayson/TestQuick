import QtQuick 2.13
import QtQuick.Controls 2.13

Page {
    id: pageStart

    property alias mouseAreaStart: mouseAreaStart

    signal startClicked

    Text {
        id: textStartContinue

        text: qsTr("Щелкните чтобы продолжить")
        anchors.topMargin: parent.height / 5
        anchors.top: textStartDescription.bottom
        anchors.horizontalCenter: textStartDescription.horizontalCenter
        font.pixelSize: 12
    }

    Text {
        id: textStartTitle

        text: qsTr("Списки покупок")
        anchors.topMargin: parent.height / 4
        anchors.top: parent.top
        transformOrigin: Item.Center
        anchors.horizontalCenter: parent.horizontalCenter
        fontSizeMode: Text.Fit
        renderType: Text.NativeRendering
        style: Text.Normal
        font.weight: Font.Black
        font.pixelSize: 25
    }

    Text {
        id: textStartDescription

        text: qsTr("Создавайте, отслеживайте, сохраняйте ваши покупки")
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: textStartTitle.bottom
        anchors.topMargin: 0
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideNone
        wrapMode: Text.WordWrap
        font.pixelSize: 14
    }

    MouseArea {
        id: mouseAreaStart

        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
