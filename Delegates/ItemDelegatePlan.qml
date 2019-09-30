import QtQuick 2.0

ItemDelegatePlanForm {
    buttonPlanDel.onClicked: {
        plans.removeRow(model.index)
    }

    areaPlanToRecords.onClicked: {
        viewPlans.currentIndex = model.index
    }

    areaPlanToRecords.onDoubleClicked: {
        planClicked({
                                        "id": model.id,
                                        "planName": model.name
                                    })
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
