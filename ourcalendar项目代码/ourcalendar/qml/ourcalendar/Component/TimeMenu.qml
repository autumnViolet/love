// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Item{
    id: timemenu
    width:360
    smooth: true
    height: 260
    signal okbuttonclicked(int tmphour, int tmpminute)
    signal rectangelClicked()
    function setindex(tmphour, tmpminute){
        listhourview.currentIndex = tmphour;
        listminuteview.currentIndex = tmpminute;
    }

    Rectangle {
        width:360
        opacity: 0.7
        smooth: true
        height: 260
        radius: 15

        color:"#000000"
    }
    NumberAnimation on opacity {from:0; to:0.9; duration:600}
    NumberAnimation on y {from:890; to: 300; duration: 400}


    ListModel{id: listhourmodel;
        ListElement{hour:"00"} ListElement{hour:"01"} ListElement{hour:"02"} ListElement{hour:"03"} ListElement{hour:"04"}
        ListElement{hour:"05"} ListElement{hour:"06"} ListElement{hour:"07"} ListElement{hour:"08"} ListElement{hour:"09"}
        ListElement{hour:"10"} ListElement{hour:"11"} ListElement{hour:"12"} ListElement{hour:"13"} ListElement{hour:"14"}
        ListElement{hour:"15"} ListElement{hour:"16"} ListElement{hour:"17"} ListElement{hour:"18"} ListElement{hour:"19"}
        ListElement{hour:"20"} ListElement{hour:"21"} ListElement{hour:"22"} ListElement{hour:"23"}
    }
    ListModel{id: listminutemodel;
        ListElement{minute:"00"} ListElement{minute:"01"} ListElement{minute:"02"} ListElement{minute:"03"} ListElement{minute:"04"}
        ListElement{minute:"05"} ListElement{minute:"06"} ListElement{minute:"07"} ListElement{minute:"08"} ListElement{minute:"09"}
        ListElement{minute:"10"} ListElement{minute:"11"} ListElement{minute:"12"} ListElement{minute:"13"} ListElement{minute:"14"}
        ListElement{minute:"15"} ListElement{minute:"16"} ListElement{minute:"17"} ListElement{minute:"18"} ListElement{minute:"19"}

        ListElement{minute:"20"} ListElement{minute:"21"} ListElement{minute:"22"} ListElement{minute:"23"} ListElement{minute:"24"}
        ListElement{minute:"25"} ListElement{minute:"26"} ListElement{minute:"27"} ListElement{minute:"28"} ListElement{minute:"29"}
        ListElement{minute:"30"} ListElement{minute:"31"} ListElement{minute:"32"} ListElement{minute:"33"} ListElement{minute:"34"}
        ListElement{minute:"35"} ListElement{minute:"36"} ListElement{minute:"37"} ListElement{minute:"38"} ListElement{minute:"39"}

        ListElement{minute:"40"} ListElement{minute:"41"} ListElement{minute:"42"} ListElement{minute:"43"} ListElement{minute:"44"}
        ListElement{minute:"45"} ListElement{minute:"46"} ListElement{minute:"47"} ListElement{minute:"48"} ListElement{minute:"49"}
        ListElement{minute:"50"} ListElement{minute:"51"} ListElement{minute:"52"} ListElement{minute:"53"} ListElement{minute:"54"}
        ListElement{minute:"55"} ListElement{minute:"56"} ListElement{minute:"57"} ListElement{minute:"58"} ListElement{minute:"59"}
    }

    Component{
        id: listhourdelegate
        Item {
            width: 80; height: 20;
            Text { text: hour;font.pointSize: 15;anchors.centerIn: parent ;color: "#000000";font.family: "Nokia Sans"}
            MouseArea{
                anchors.fill: parent
                onClicked:listhourview.currentIndex=index
            }
        }
    }
    Component{
        id: listminutedelegate
        Item {
            width: 80; height: 20;
            Text { text: minute;font.pointSize: 15;anchors.centerIn: parent ;color: "#000000";font.family: "Nokia Sans"}
            MouseArea{
                anchors.fill: parent
                onClicked:listhourview.currentIndex=index
            }
        }
    }


    Row{
        id:listrow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset:0
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -25
        spacing: 4
        Rectangle{
            width: 90; height: 140
            border.width: 1
            radius:5
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#000000";
                }
                GradientStop {
                    position: 0.45;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 0.5;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 1;
                    color: "#000000";
                }
            }
            ListView{
                id:listhourview
                width: 90; height: 140
                opacity: 0.8
                spacing: 8
                model: listhourmodel
                delegate: listhourdelegate
                snapMode: ListView.SnapOneItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                boundsBehavior:Flickable.DragAndOvershootBounds
                clip:true
                preferredHighlightBegin: 64
                preferredHighlightEnd: 64
                onCurrentIndexChanged: {
                }
            }
        }
        Rectangle{
            width: 90; height: 140
            border.width: 1
            radius:5
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#000000";
                }
                GradientStop {
                    position: 0.45;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 0.5;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 1;
                    color: "#000000";
                }
            }
            ListView{
                id:listminuteview
                width: 90; height: 140
                opacity: 0.8
                spacing: 8
                model: listminutemodel
                delegate: listminutedelegate
                snapMode: ListView.SnapOneItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                boundsBehavior:Flickable.DragAndOvershootBounds
                clip:true
                preferredHighlightBegin: 64
                preferredHighlightEnd: 64
                onCurrentIndexChanged: {
                }
            }
        }
    }



    states:[State{
            name:"disappear"
            PropertyChanges{target: timemenu; y:890}
        }
    ]
    transitions: [
        Transition {
            from: ""
            to:"disappear"
            NumberAnimation{property: "y"; duration: 400

            }
        }
    ]

    Row{
        anchors.bottom: parent.bottom ;anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 40
        Rectangle {
            width: 120
            height: 40
            smooth: true
            border.color: "grey"; border.width: 1
            opacity: 0.7; radius: 3
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
                text: "确定"
                font.family: "Nokia Sans"
                color: "#ffffff"
                font.pointSize: 15
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
                    timemenu.state="disappear"
                    timemenu.okbuttonclicked(listhourview.currentIndex, listminuteview.currentIndex)
                    timemenu.rectangelClicked()
                    destroyed.start()
                }
            }
        }

        Rectangle {
            width: 120
            height: 40
            smooth:true
            // opacity:0.8
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
                text: "取消"
                font.family: "Nokia Sans"
                color: "#ffffff"
                font.pointSize: 15
            }
            MouseArea{
                id:cancelmousearea
                anchors.fill: parent
                onClicked: {
                    timemenu.state="disappear"
                    timemenu.rectangelClicked()
                    destroyed.start()
                }
            }
        }
    }

    Timer{
        id:destroyed
        interval: 400
        running: false
        onTriggered: timemenu.destroy()
    }

}
