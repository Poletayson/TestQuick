import QtQuick 2.0

ItemDelegatePlanForm {
    function setCount (){
        textCounter.text = plans.getRecordsCount(model.id, true)+ "/" + (plans.getRecordsCount(model.id, true) + plans.getRecordsCount(model.id, false))
    }

//    itemDelegatePlan.onDataChanged: {
//        setCount()
//    }

    buttonPlanDel.onClicked: {
        plans.removeRow(model.index)
    }

    areaPlanToRecords.onClicked: {
        viewPlans.currentIndex = model.index
    }

    areaPlanToRecords.onDoubleClicked: {
        planClicked({
                        "index": model.index,
                        "id": model.id,
                        "planName": model.name
                    })
    }

    textCounter.text: plans.getRecordsCount(model.id, true)+ "/" + (plans.getRecordsCount(model.id, true) + plans.getRecordsCount(model.id, false))




}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
