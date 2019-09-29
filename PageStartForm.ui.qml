import QtQuick 2.13
import QtQuick.Controls 2.13

Page {
    id: pageStart
    width: 400
    height: 400
    property alias mouseAreaStart: mouseAreaStart

    Text {
        id: textStartContinue
        x: 115
        text: qsTr("Щелкните чтобы продолжить")
        anchors.topMargin: parent.height / 5
        anchors.top: textStartDescription.bottom
        anchors.horizontalCenter: textStartDescription.horizontalCenter
        font.pixelSize: 12
    }

    Text {
        id: textStartTitle
        x: 100
        width: 200
        height: 46
        text: qsTr("Список покупок")
        anchors.topMargin: parent.height / 4
        anchors.top: parent.top
        transformOrigin: Item.Center
        anchors.horizontalCenter: parent.horizontalCenter
        fontSizeMode: Text.Fit
        renderType: Text.NativeRendering
        font.underline: false
        font.strikeout: false
        font.italic: false
        style: Text.Normal
        font.weight: Font.Black
        font.pixelSize: 25
    }

    Text {
        id: textStartDescription
        x: 106
        width: 188
        height: 99
        text: qsTr("Создавайте, отслеживайте, сохраняйте ваши покупки")
        anchors.top: textStartTitle.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: textStartTitle.horizontalCenter
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
