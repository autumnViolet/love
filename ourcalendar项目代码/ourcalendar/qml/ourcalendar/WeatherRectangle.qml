// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Item{
    width:280
    // opacity: 0.8
    smooth: true
    height: 100

    Rectangle {
        width:280
        opacity: 0.4
        smooth: true
        height: 100
        radius: 2
        border.color: "black"
        NumberAnimation on opacity{from:0;to:0.4;duration: 500}
    }
    //color:"white"

    Text{
        id:weathertext2
        //anchors.top:parent.top
        font.pointSize: 5
        color:"black"
        text:"Accuweather"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -72
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset:-25
    }
    Rectangle{id:rect2;width: parent.width;height: 1;color:"black";y:50}
    Text {
        id: weathertext3
        text: "Yahooweather"
        font.pointSize: 5
        color:"black"
        anchors.leftMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -70
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset:25
        // anchors.topMargin: 10
    }
}

