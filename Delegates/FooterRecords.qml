import QtQuick 2.0

FooterRecordsForm {
    buttonRecordAdd.onClicked: {
        records.add(textInputAddingName.text.toString(), planId)
        textInputAddingName.clear()
    }
}
