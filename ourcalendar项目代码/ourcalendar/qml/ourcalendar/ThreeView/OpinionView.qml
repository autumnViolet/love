// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Rectangle {
    id:opinion
    width: 480
    height: 854
    Item{
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
            onClicked: {}
        }
    }

    Image {
        id:ouricon
        source:"kaiji.png"
        width: 480
        height: 770
        y:85
    }

    Column{
        id:opinioncolumn
        width: 280
        spacing:20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -50
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 50
        Text{
            id:opiniontext
            color: "#979aa0"
            text:" 如果发现软件Bug或者对本软件有建议，请访问"
            smooth: false
            width:380
            font.family: "Segoe Script"
            wrapMode: Text.WrapAnywhere
            font.pointSize: 15


        }
        Text{
            id:address
            textFormat: Text.RichText
            color: "#979aa0"
            text:"社区网站:<a href = \"http://www.open-src.org\">http://www.open-src.org\<\a>."
            font.italic: true
            font.pointSize: 15
            font.family:"Nokia Sans"




        }
    }

    Item{
        anchors.horizontalCenter: parent.horizontalCenter
        id:topitem
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

        Item{
            id:backitem
            width: 119
            height:56
            anchors{left: parent.left;leftMargin: 10;top:parent.top;topMargin: 15}
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
                        id:color1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:color2
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }
            Text {
                id: backtext
                text: "返回"
                anchors.centerIn: parent
                font.family: "Nokia Sans"
                color: "lightgrey"
                font.pointSize: 15
            }
            MouseArea{
                id:textmousearea
                anchors.fill: parent
                onClicked: {
                    backrectangle.state=""
                    opinion.destroy()
                }

            }
            states:State {
                name: "backRctangle"
                when: textmousearea.pressed
                PropertyChanges {target:color1;color:"black" }
                PropertyChanges {target:color2;color:"black" }
                PropertyChanges {target:backtext;color:"white"}

            }
        }
    }
}
