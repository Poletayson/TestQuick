import QtQuick 2.13

PageStartForm {
    signal startClicked

    mouseAreaStart.onClicked: {
        startClicked ()
}
}
