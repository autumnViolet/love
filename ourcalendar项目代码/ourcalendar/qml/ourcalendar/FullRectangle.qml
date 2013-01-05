// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: fullrectangle
    width: 480
    height:769
    color: "black"
    opacity: 0.3
    function disappearfullrectangle()
    {
        fullrectangle.destroy()
    }
    function changingopacity(){
       fullrectangle.opacity=0.01
       fullrectangle.height=854
    }
    function changetonormal(){
       fullrectangle.opacity=0.6
       fullrectangle.height=785
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {}
    }
}
