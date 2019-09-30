import QtQuick 2.0

FooterPlansForm {
    buttonPlanAdd.onClicked: {
            plans.add(textInputAddingName.text.toString(),
                      Qt.formatDateTime(new Date(), "yyyy-MM-dd"))
            textInputAddingName.text = ""
    }

}
