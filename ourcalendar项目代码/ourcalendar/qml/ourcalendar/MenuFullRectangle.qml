// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: menufullrectangle
    width: 480
    height:854
    color: "black"
    opacity: 0.3
    signal menufullRectangleClicked2
    onMenufullRectangleClicked2: menufullrectangle.destroy()
    MouseArea{
        anchors.fill: parent
        onClicked: {}
    }
}
