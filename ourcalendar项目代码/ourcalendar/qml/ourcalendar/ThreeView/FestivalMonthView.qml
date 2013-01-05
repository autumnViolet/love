// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "model" as Model
Rectangle {
    width: 480; height: 854;
    id:festivalmonthrectangle
    property int slideDistance: 0

    Image {
        id:festivalImage
        width:480;height:854
        Rectangle{
            anchors{bottom: parent.bottom}
            width:480
            height: 854-85
            color:"lightgrey"
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#101111";
                }
                GradientStop {
                    position: 0.1;
                    color: "#dfe6e6";
                }
                GradientStop {
                    position: 0.90;
                    color: "#d4dbdb";
                }
                GradientStop {
                    position: 1.00;
                    color: "#0e0f0e";
                }
            }
            opacity: 0.7
        }
        anchors.fill: parent
        smooth: true
        source: calendartheme.gettingstring()
    }


    transitions: [
        Transition {
            PropertyAnimation{property : "color";duration:1000}

        }
    ]
    Model.AprModel{id:aprmodel}
    Model.FebModel{id:febmodel}
    Model.JunModel{id:junmodel}
    Model.JulyModel{id:julymodel}
    Model.OctModel{id:octmodel}
    Model.AugModel{id:augmodel}
    Model.MarModel{id:marmodel}
    Model.MayModel{id:maymodel}
    Model.JanModel{id:janmodel}
    Model.DecModel{id:decmodel}
    Model.NovModel{id:novmodel}
    Model.SepModel{id:sepmodel}
    property int textopacity: 0
    ListModel{
        id:weekmodel
        ListElement{
            weeker:"一月"
            icon:"m1.png"
        }
        ListElement{
            weeker:"二月"
            icon:"m2.png"
        }
        ListElement{
            weeker:"三月"
            icon:"m3.png"
        }
        ListElement{
            weeker:"四月"
            icon:"m4.png"
        }
        ListElement{
            weeker:"五月"
            icon:"m5.png"
        }
        ListElement{
            weeker:"六月"
            icon:"m6.png"
        }
        ListElement{
            weeker:"七月"
            icon:"m7.png"
        }
        ListElement{
            weeker:"八月"
            icon:"m8.png"
        }
        ListElement{
            weeker:"九月"
            icon:"m9.png"
        }
        ListElement{
            weeker:"十月"
            icon:"m10.png"
        }
        ListElement{
            weeker:"十一月"
            icon:"m11.png"
        }
        ListElement{
            weeker:"十二月"
            icon:"m12.png"
        }
    }
    Item{
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
        }
    }

    Grid{
        id:festgrid; rows:4 ;columns:3;spacing: 200
        Repeater{
            id:festrepeater ; height:160;width: 160;smooth:true;model:weekmodel

            Item{
                id:gridrectangle
                width: 140
                height:140
                smooth:true
                Rectangle{
                    opacity: 0.7
                    width: 140
                    height:140
                    radius:5
                    gradient: Gradient {
                        GradientStop {
                            id:gridcolor1
                            position: 0
                            color: "#242525"
                        }

                        GradientStop {
                            id:gridcolor2
                            position: 1
                            color: "#040505"
                        }
                    }
                }
                Text {
                    id: gridtext
                    text:weeker
                    anchors.centerIn: parent
                    font.family: "Nokia Sans"
                    color: "white"
                    font.pointSize: 16
                }
                NumberAnimation on opacity {from:0;to:1;duration: 1500}
                states: [
                    State {
                        when:gridtextmousearea.pressed
                        PropertyChanges {
                            target:gridcolor1
                            color:"#040505"
                        }
                        PropertyChanges {
                            target:gridcolor2
                            color:"#242525"
                        }
                        PropertyChanges{
                            target:gridtext
                            color:"#af2c2c"
                        }

                    }

                ]
                MouseArea{
                    id:gridtextmousearea
                    anchors.fill: parent
                    onClicked: {
                        if(index==0)
                            feastview.model=janmodel
                        else if(index==1)
                            feastview.model=febmodel
                        else if(index==2)
                            feastview.model=marmodel
                        else if(index==3)
                            feastview.model=aprmodel
                        else if(index==4)
                            feastview.model=maymodel
                        else if(index==5)
                            feastview.model=junmodel
                        else if(index==6)
                            feastview.model=julymodel
                        else if(index==7)
                            feastview.model=augmodel
                        else if(index==8)
                            feastview.model=sepmodel
                        else if(index==9)
                            feastview.model=octmodel
                        else if(index==10)
                            feastview.model=novmodel
                        else if(index==11)
                            feastview.model=decmodel
                        // festivalmonthrectangle.state="turn"
                        flip.flipped=!flip.flipped
                        //gridtextmousearea.enabled=false
                        console.log(flip.state)
                        console.log(gridtextmousearea.enabled)
                    }

                }

            }

        }

        NumberAnimation on x{from:-200;to:20;duration: 1000}
        NumberAnimation on y{from:-200;to:180;duration: 1000}
        NumberAnimation on spacing{from:200;to:10;duration: 1000}
    }

    Component{
        id :feastdelegate
        Item{
            id: feast
            width: 480
            height: 150
            Rectangle{
                id:feastRectangle
                width:480
                height: 150
                smooth: true
                border.width: 2
                border.color: "black"
                color:"white"
                radius: 20
                opacity: 0.7
            }
            MouseArea{
                id:feastdetailarea
                anchors.fill: parent
                onClicked: {feast.state="detail"}
            }
            Row{
                id:festivalrow
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 15
                spacing: 15
                Image {
                    id:festivalimage
                    fillMode: Image.Stretch
                    width:120;height:120
                    smooth: true
                    source: picture

                }
                Column{
                    spacing: 10
                    Text {
                        text: fest
                        //                        verticalAlignment: Text.AlignVCenter
                        font.pointSize:18
                        font.family: "Nokia Sans"

                    }
                    Text {
                        id:festivaldetailtext
                        width:130
                        text: detail
                        //                        verticalAlignment: Text.AlignVCenter
                        font.pointSize:15
                        opacity: 0
                        font.letterSpacing: 4
                        wrapMode: Text.WordWrap
                        font.family: "Nokia Sans"

                    }

                }
            }
            Item {
                id: festivalstory; width: 480
                anchors { top: festivalrow.bottom; topMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
                opacity: 0


                Flickable {
                    id: flick
                    width: parent.width-20
                    anchors { top: festivalstory.top; topMargin:30; bottom: parent.bottom ;horizontalCenter:parent.horizontalCenter}
                    contentHeight: storyText.height
                    clip: true
                    Text { id: storyText; text: story; font.pointSize: 15;
                        anchors.horizontalCenter: parent.horizontalCenter
                        wrapMode:Text.WrapAnywhere ; width: parent.width-30
                        font.letterSpacing: 4
                        font.family: "Nokia Sans"
                    }
                }

                Image {
                    anchors { right: flick.right; top: flick.top }
                    source: "moreUp.png"
                    opacity: flick.atYBeginning ? 0 : 1
                }

                Image {
                    anchors { right: flick.right; bottom: flick.bottom }
                    source: "moreDown.png"
                    opacity: flick.atYEnd ? 0 : 1
                }
            }
            Image {
                id:closeimage
                opacity: 0.3
                anchors { top: feast.top; topMargin: 8; right: parent.right;rightMargin: 5}
                height: 40
                width: 40
                smooth: true
                visible: false
                source: "close1.png"
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        feast.state=""
                    }
                }

            }




            states: [
                State {
                    name: "detail"
                    PropertyChanges { target:feast.ListView.view ;contentY: feast.y}
                    PropertyChanges { target:feast; height:feastview.height}
                    PropertyChanges {target:feastRectangle;height:feastview.height}
                    PropertyChanges {target:closeimage;visible: true;z:2}
                    PropertyChanges {target:feastview ;interactive:false }
                    PropertyChanges {target:festivaldetailtext;opacity:1 }
                    PropertyChanges {target:festivalimage ;width:270;height:270}
                    PropertyChanges {target:festivalstory ;opacity:1}
                }


            ]
            transitions: Transition {
                NumberAnimation { duration: 300; properties: "contentY,height,width,opacity" }
            }
        }

    }



    ListView{

        id:feastview
        width: 480
        height:750
        delegate: feastdelegate
        clip:true
        anchors{top:parent.top;topMargin: 85;
        }

    }
    Flipable{
        id:flip
        width: 480
        height: 700
        property bool flipped:false
        front:festgrid
        back:feastview
        transform: Rotation{
            id:rotation
            origin.x:flip.width/2
            origin.y:flip.height/2
            axis.x: 0
            axis.y:1
            axis.z:0
            angle:0
        }
        states: [
            State {
                name: "back"
                PropertyChanges {
                    target:rotation
                    angle:180
                }
                when:flip.flipped
            }
        ]
        transitions: [
            Transition {
                NumberAnimation{target:rotation;property:"angle";duration: 1000}
            }

        ]
    }
    Item{
        width:480
        height: 85
        anchors.top: parent.top

        Rectangle{width: 480;height: 85;anchors.centerIn: parent;opacity: 0.7;color:"black"}
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
                color: "white"
                font.pointSize: 17
            }
            MouseArea{
                id:textmousearea
                anchors.fill: parent
                onClicked: {
                    backrectangle.state=""
                    if(flip.state=="back")
                    {   flip.flipped=!flip.flipped
                        feastview.currentItem.state=""
                        festivalmonthrectangle.state=""
                    }
                    else
                        festivalmonthrectangle.destroy()
                }

            }
            states:State {
                name: "backRctangle"
                when: textmousearea.pressed
                PropertyChanges {target:color1;color:"black" }
                PropertyChanges {target:color2;color:"black" }
                PropertyChanges {target:backtext;color:"#af2c2c" }

            }


        }

    }

}
