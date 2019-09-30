import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import "../Constants.js" as Constants

Rectangle {

    property alias buttonRecordAdd: buttonRecordAdd
    property alias textInputAddingName: textInputAddingName

    height: Constants.SPACING * 2 + viewRecords.blockHeight

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
            

        }
    }
}
