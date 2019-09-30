import QtQuick 2.0

ItemDelegateRecordForm {
    mouseArea.onClicked: {
        viewRecords.currentIndex = model.index
    }
    mouseArea.onDoubleClicked: {
        model.isBought = model.isBought ? false : true
    }

    buttonPositionDel.onClicked: {
        records.removeRows(model.index, 1)
    }

}
