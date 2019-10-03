import QtQuick 2.0

ItemDelegatePlanForm {
    function setCount (){
        textCounter.text = model.countBoughtRecords + "/" + model.countAllRecords
    }

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

    textCounter.text: {
        model.countBoughtRecords + "/" + model.countAllRecords
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
