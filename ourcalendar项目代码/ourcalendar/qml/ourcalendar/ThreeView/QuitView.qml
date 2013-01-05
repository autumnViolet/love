// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id:quitrectangle
    width:360
    smooth: true
    height: 260
    radius: 15
    opacity: 0.6
    color:"black"
    signal cancelclicked
    Text{
        id:quitText
        anchors.top: parent.top;anchors.topMargin: 80;anchors.left: parent.left;anchors.leftMargin: 55
        font.pointSize: 18
        text:"您 确 定 要 退 出 吗 ?"
        font.family: "Nokia Sans"
        color:"white"
    }
    Row{
        anchors.bottom: parent.bottom ;anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 40
        Rectangle {
            width: 120
            height: 45
            smooth: true
            border.color: "grey"; border.width: 1
            opacity: 0.5; radius: 3
            gradient: Gradient {
                GradientStop {
                    id:okcolor1
                    position: 0
                    color: "#6c91c4"
                }

                GradientStop {
                    id:okcolor2
                    position: 0.700
                    color: "#202020"
                }
            }
            Text {
                anchors.centerIn: parent
                text: "是"
                font.family: "Nokia Sans"
                color: "#ffffff"
                font.pointSize: 16
            }
            states: [
                State {
                    when:okmousearea.pressed
                    PropertyChanges {
                        target:okcolor2
                        color:"#6c91c4"

                    }
                    PropertyChanges {
                        target:okcolor1
                        color:"#202020"

                    }
                }
            ]
            MouseArea{
                id:okmousearea
                anchors.fill: parent
                onClicked: {
                    Qt.quit()
                }
            }
        }

        Rectangle {
            width: 120
            height:45
            smooth:true
            gradient: Gradient {
                GradientStop {
                    id:cancelcolor1
                    position: 0
                    color: "#6c91c4"
                }

                GradientStop {
                    id:cancelcolor2
                    position: 0.700
                    color: "#202020"
                }
            }
            states: [
                State {
                    when:cancelmousearea.pressed
                    PropertyChanges {
                        target:cancelcolor2
                        color:"#6c91c4"

                    }
                    PropertyChanges {
                        target:cancelcolor1
                        color:"#202020"

                    }
                }
            ]
            border.color: "grey"; border.width: 1
            opacity: 0.5; radius: 3
            Text {
                anchors.centerIn: parent
                text: "否"
                font.family: "Nokia Sans"
                color: "#ffffff"
                font.pointSize: 16
            }
            MouseArea{
                id:cancelmousearea
                anchors.fill: parent
                onClicked: {
                    quitrectangle.destroy()
                    quitrectangle.cancelclicked()
                }
            }
        }
    }
}
