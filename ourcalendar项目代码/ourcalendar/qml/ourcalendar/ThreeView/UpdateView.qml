// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id:updaterectangle
    property string mystring: ""
    width: 480
    height: 854
    color: "lightgrey"


    Image {
        id:themeImage
        width:480;height:854
        smooth: true
        source: imagesource
    }
    Rectangle{
        anchors{top:parent.top ;topMargin: 85}
        width:480
        height: 770
        opacity: 0.5
        color: "#535252"
    }
    Text{

        id:updatething
        text: "暂时没有更新！！"
        font.family:"Nokia Sans"
        font.pointSize: 20
        anchors.centerIn: parent
        color:"black"


    }

    Item{
        id:topitem
        anchors.horizontalCenter: parent.horizontalCenter
        width: 480
        height: 85
        anchors.top: parent.top
        Rectangle{
            width: 480
            height: 85
            color: "black"
            opacity: 0.7
            anchors.centerIn: parent


        }
        Text{
            id:updateText
            text:"软件更新"
            font.pointSize: 18
            font.family:"Nokia Sans"
            color:"white"
            anchors.centerIn: parent

        }
        Item{
            id:backitem
            width: 119
            height:56
            anchors{left: parent.left;leftMargin: 10;top:parent.top;topMargin: 17}
            Rectangle{
                id:backrectangle
                opacity: 0.3
                width: 119
                height:56
                border.width: 1
                border.color: "black"
                anchors.centerIn: parent
                gradient: Gradient {
                    GradientStop {
                        id:backcolor1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:backcolor2
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }


            Text {
                id: backtext
                text: "返回"
                color:"white"
                font.pointSize: 17
                anchors.centerIn: parent
                font.family: "Nokia Sans"
            }
            MouseArea{
                id:backmousearea
                anchors.fill: parent
                onClicked: {
                    updaterectangle.destroy()
                }
            }
            states:State {
                name: "backrctangle"
                when: backmousearea.pressed
                PropertyChanges {target:backcolor1;color:"black" }
                PropertyChanges {target:backcolor2;color:"black" }
                PropertyChanges {target:backtext; color:"#af2c2c"}


            }

        }

    }
}
