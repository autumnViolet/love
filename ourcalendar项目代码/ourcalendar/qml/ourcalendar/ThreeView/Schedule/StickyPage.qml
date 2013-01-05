// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    id: stickytop
    children:[
        Item {
            id: sticky
            property string mydate: ""
            property int stickyx: 0
            property int stickyy: 0

            property int mystickyid: -10
            property int mydatechange: 0
            property int stickyidchange: 0
            property int themechange: 0
            property int occurtimechange: 0
            property int occuraddresschange: 0
            //            property int remindtimechange: 0
            //            property int remindwaychange: 0
            //            property int remindsequencechange: 0
            property int eventrepeatchange: 0
            property int detailchange: 0
            property string addressstring:""
            property int myhour: 00
            property int myminute: 00
            signal pagemessagerecived(string recscheduledate, int pageid, string rectheme, string recoccurTime, string recoccurAddress,
                                      /*string recremindTime, string recremindWay, string recremindSequence,*/ string receventRepeat, string recdetail)
            signal okbuttonclicked()
            signal canclebuttonclicked()
            signal turntoeditable(int stickyid)
            signal turntonotedit(int stickyid)
            signal addresschoosed(string address)
            signal currenttime(int tmphour, int tmpminute)
            onTurntoeditable:    {
                sticky.x = 0;
                sticky.y = 0;
            }
            onTurntonotedit: {
                sticky.x = stickyx;
                sticky.y = stickyy;
            }
            onPagemessagerecived: {
                if(mydatechange == 0){ mydate = recscheduledate;mydatechange = 1}
                if(stickyidchange == 0){ mystickyid =  pageid; stickyidchange = 1}
                if(themechange == 0){ themeedit.text = rectheme; themechange = 1}
                if(occurtimechange == 0){ occurtimeedit.text = recoccurTime; occurtimechange = 1}
                if(occuraddresschange == 0){ occuraddressedit.text = recoccurAddress; occuraddresschange = 1}
                //                if(remindtimechange == 0){ remindtimeedit.text = recremindTime; remindtimechange = 1}
                //                if(remindwaychange == 0){ remindwayedit.text = recremindWay; remindwaychange = 1}
                //                if(remindsequencechange == 0){ remindsequenceedit.text = recremindSequence; remindsequencechange = 1}
                if(eventrepeatchange == 0){ eventrepeatedit.text = receventRepeat; eventrepeatchange = 1}
                if(detailchange == 0){ detailedit.text = recdetail; detailchange = 1}
            }
            onXChanged: { if( sticky.x!=0) { stickyx=sticky.x;} }
            onYChanged: { if( sticky.y!=0) { stickyy=sticky.y;} }
            function getoccurtime(tmphour, tmpminute){
                sticky.myhour = tmphour;
                sticky.myminute = tmpminute;
                occurtimeedit.text = sticky.myhour+"时"+sticky.myminute+"分";
            }
            scale: 0.5
            rotation: -5

            Image {id: stickyImage
                x:-width/2+tackImage.width/8;
                source: "cc.png"
                transformOrigin: Item.TopLeft
                smooth: true
            }
            Item{id: stickymouse
                x: stickyImage.x; y: stickyImage.y
                width: stickyImage.width * stickyImage.scale
                height: stickyImage.height * stickyImage.scale
                MouseArea{id: mouse
                    anchors.fill: parent
                    drag.target: sticky
                    drag.axis: Drag.XandYAxis
                    onClicked: {
                        sticky.state = "clickedstate";
                        sticky.turntoeditable(sticky.mystickyid);
                    }
                    onDoubleClicked: {
                        //                        sticky.state = "";
                        //                        sticky.turntonotedit(sticky.mystickyid);
                    }
                }
            }
            Image {id: tackImage
                x: -width/2;
                y: -height/4;
                source: "tack.png"
                transformOrigin: Item.TopLeft
                smooth: true
                Item {id: tackimg
                    x: 20;
                    width: tackImage.width * tackImage.scale-tackImage.x
                    height: tackImage.height * tackImage.scale
                    MouseArea{id: tackmousearea
                        anchors.fill: parent
                        onDoubleClicked: {
                            scheduledatacpp.deleteschedulexmldata(sticky.mydate, (sticky.mystickyid).toString())
                            stickytop.visible = false
                        }
                    }
                }
            }
            Column{
                id: scheduleColumn
                x: stickyImage.x + 40; y: stickyImage.y + tackImage.height/4*3
                width: stickyImage.width - 60
                height: stickyImage.height
                spacing: 15
                Row{
                    id: themerow
                    //anchors{left: parent.left;leftMagin:20}
                    width: 320;  height: 40; spacing: 20
                    Text{
                        id: themetext
                        text: "主题"
                        font.family: "Nokia Sans"
                        font.pointSize: 15
                    }
                    Rectangle{
                        id: themeborder
                        width: parent.width-10
                        height: parent.height
                        radius: 5; color: "lightyellow";border.width:1; border.color:"lightgrey"
                        TextEdit{
                            id: themeedit; x: 10
                            width: parent.width-20
                            height: parent.height
                            text: ""
                            wrapMode: TextEdit.Wrap
                            font.pointSize: 15
                        }
                    }
                }
                Row{id: occurtimerow
                    width: 320;  height: 40; spacing: 20
                    Text{
                        id: occurtimetext
                        text: "时间"
                        font.family: "Nokia Sans"
                        font.pointSize: 17
                    }
                    Rectangle{
                        id: occurtimeborder
                        width: parent.width-10
                        height: parent.height
                        radius: 5; color: "lightyellow";border.width:1; border.color:"lightgrey"
                        Text{
                            id: occurtimeedit; x: 10
                            width: parent.width-0
                            height: parent.height2
                            text: sticky.myhour+"时"+sticky.myminute+"分"
                            wrapMode: TextEdit.Wrap
                            font.pointSize: 16
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                var component1 = Qt.createComponent("../../MenuFullRectangle.qml");
                                var FullRectangle = component1.createObject(toprectangle);
                                var component2 = Qt.createComponent("../../Component/TimeMenu.qml");
                                var Object = component2.createObject(toprectangle);
                                Object.x=60;
                                sticky.currenttime.connect(Object.setindex);
                                sticky.currenttime(sticky.myhour, sticky.myminute);
                                Object.okbuttonclicked.connect(sticky.getoccurtime);
                                Object.rectangelClicked.connect(FullRectangle.menufullRectangleClicked2);
                            }
                        }
                    }
                }
                Row{id: occuraddressrow
                    width: 320;  height: 40; spacing: 20
                    Text{id: occuraddresstext
                        text: "地址"
                        font.family: "Nokia Sans"
                        font.pointSize: 17
                    }
                    Rectangle{id: occuraddressborder
                        width: parent.width-10
                        height: parent.height
                        radius: 5; color: "lightyellow";border.width:1; border.color:"lightgrey"
                        TextEdit{id: occuraddressedit; x: 10
                            width: parent.width-10
                            height: parent.height
                            text: ""
                            wrapMode: TextEdit.Wrap
                            font.pointSize: 16
                        }
                    }
                    //                    Text{id: googletext
                    //                        text: "GooGle"
                    //                        font.family: "Nokia Sans"
                    //                        font.pointSize: 17
                    //                        MouseArea{
                    //                            id:googlemousearea
                    //                            anchors.fill: parent
                    //                            onClicked: {
                    //                                sticky.addresschoosed(occuraddressedit.text)
                    //                            }
                    //                        }
                    //                    }
                    Image {
                        id: googleimage
                        source: "google.ico"
                        width: 45
                        height: 45
                        MouseArea{
                            id:googlemousearea
                            anchors.fill: parent
                            enabled: setting.gettinggooglestring()
                            onClicked: {
                                sticky.addresschoosed(occuraddressedit.text)
                            }
                        }
                    }
                }
                //                Row{id: remindtimerow
                //                    width: 320;  height: 40; spacing: 20
                //////                    visible: false
                //                    Text{id: remindtimetext
                //                        text: "提醒时间"
                //                        font.pointSize: 8
                //                    }
                //                    Rectangle{id: remindtimeborder
                //                        width: parent.width-35
                //                        height: parent.height
                //                        radius: 5; color: "lightyellow";border.width:1; border.color:"lightgrey"
                //                        TextEdit{id: remindtimeedit; x: 10
                //                            width: parent.width-20
                //                            height: parent.height
                //                            text: ""
                //                            wrapMode: TextEdit.Wrap
                //                            font.pointSize: 8
                //                        }
                //                    }
                //                }
                //                Row{id: remindwayrow
                //                    width: 320;  height: 40; spacing: 20
                ////                    visible: false
                //                    Text{id: remindwaytext
                //                        text: "提醒方式"
                //                        font.pointSize: 8
                //                    }
                //                    Rectangle{id: remindwayborder
                //                        width: parent.width-35
                //                        height: parent.height
                //                        radius: 5
                //                        TextEdit{id: remindwayedit; x: 10
                //                            width: parent.width-20
                //                            height: parent.height
                //                            readOnly: false
                //                            text: ""
                //                            wrapMode: TextEdit.Wrap
                //                            font.pointSize: 8
                //                        }
                //                    }
                //                }
                //                Row{id: remindsequencerow
                //                    width: 320;  height: 40; spacing: 20
                ////                    visible: false
                //                    Text{id: remindsequencetext
                //                        text: "提醒频率"
                //                        font.pointSize: 8
                //                    }
                //                    Rectangle{id: remindsequenceborder
                //                        width: parent.width-35
                //                        height: parent.height
                //                        radius: 5
                //                        TextEdit{id: remindsequenceedit; x: 10
                //                            width: parent.width-20
                //                            height: parent.height
                //                            text: ""
                //                            wrapMode: TextEdit.Wrap
                //                            font.pointSize: 8
                //                        }
                //                    }
                //                }
                Row{id: eventrepeatrow
                    width: 320;  height: 40; spacing: 20
                    visible: false
                    Text{id: eventrepeattext
                        text: "频率"
                        font.family: "Nokia Sans"
                        font.pointSize: 17
                    }
                    Rectangle{id: eventrepeatborder
                        width: parent.width-10
                        height: parent.height
                        radius: 5; color: "lightyellow";border.width:1; border.color:"lightgrey"
                        TextEdit{id: eventrepeatedit; x: 10
                            width: parent.width-20
                            height: parent.height
                            text: ""
                            wrapMode: TextEdit.Wrap

                            font.pointSize: 16
                        }
                    }
                }
                Row{id: detailrow
                    width: 320; height: 120; spacing: 20
                    visible: false
                    Text{id: detailtext
                        text: "事件"
                        font.family: "Nokia Sans"
                        font.pointSize: 17
                    }
                    Rectangle{id: detailborder
                        width: parent.width-10
                        height: parent.height
                        radius: 5; color: "lightyellow";border.width:1; border.color:"lightgrey"
                        TextEdit{id: detailedit; x: 10
                            width: parent.width-10
                            height: parent.height
                            text: ""
                            wrapMode: TextEdit.Wrap

                            font.pointSize: 16
                        }
                    }
                }
                Row{id: button
                    width: 180; height: 40
                    x: 80
                    spacing: 20
                    visible: false
                    Rectangle{
                        width: button.width/2 -15; height: button.height; radius: 5
                        gradient: Gradient {
                            GradientStop {
                                id: ok
                                position: 0.00;
                                color: "#ffffff";
                            }
                            GradientStop {
                                position: 0.8;
                                color: "#ffffff";
                            }
                        }
                        Text{id: oktext
                            text: "确定"
                            font.family: "Nokia Sans"
                            anchors.centerIn: parent
                            font.pointSize: 17
                            color:"black"
                        }
                        MouseArea{id: okmousearea
                            anchors.fill: parent
                            onClicked: {
                                sticky.state = "";
                                sticky.turntonotedit(sticky.mystickyid);
                                scheduledatacpp.updateschedulexmldata(sticky.mydate, sticky.mystickyid.toString(), themeedit.text, occurtimeedit.text, occuraddressedit.text/*, remindtimeedit.text,remindwayedit.text,remindsequenceedit.text*/,eventrepeatedit.text,detailedit.text);
                            }
                        }
                        states: [
                            State {
                                when: okmousearea.pressed
                                PropertyChanges {
                                    target: ok
                                    color: "#af2c2c"
                                }
                            }
                        ]
                    }
                    Rectangle{
                        width: button.width/2 -15; height: button.height; radius: 5
                        gradient: Gradient {
                            GradientStop {
                                id: cancelcolor
                                position: 0.00;
                                color: "#ffffff";
                            }
                            GradientStop {
                                position: 0.8;
                                color: "#ffffff";
                            }
                        }
                        Text{id: canceltext
                            text: "取消"
                            font.family: "Nokia Sans"
                            anchors.centerIn: parent
                            font.pointSize: 15
                            color: "black"
                        }
                        MouseArea{id: cancelmousearea
                            anchors.fill: parent
                            onClicked: {
                                sticky.state = "";
                                sticky.turntonotedit(sticky.mystickyid);
                            }
                        }
                        states: [
                            State {
                                when: cancelmousearea.pressed
                                PropertyChanges {
                                    target: cancelcolor
                                    color: "#af2c2c"
                                }
                            }
                        ]
                    }
                }
            }

            states: [
                State {
                    name: "clickedstate"
                    PropertyChanges { target: sticky; rotation: 0; scale: 0.86 }
                    PropertyChanges { target: eventrepeatrow; visible: true }
                    PropertyChanges { target: detailrow; visible: true }
                    PropertyChanges { target: button; visible: true }
                    PropertyChanges { target: mouse; onClicked: {}  onDoubleClicked:{ sticky.state = ""; sticky.turntonotedit(sticky.mystickyid)}}
                },State {
                    name: "addstate"
                    PropertyChanges { target: sticky; rotation: 0; scale: 0.86 }
                    PropertyChanges { target: eventrepeatrow; visible: true }
                    PropertyChanges { target: detailrow; visible: true }
                    PropertyChanges { target: button; visible: true }
                    PropertyChanges { target: mouse; onClicked: {}  onDoubleClicked:{}}
                    PropertyChanges { target: okmousearea;
                        onClicked:{
                            sticky.state = "adddefultstate";
                            sticky.okbuttonclicked();
                            scheduledatacpp.updateschedulexmldata(sticky.mydate, sticky.mystickyid.toString(), themeedit.text, occurtimeedit.text, occuraddressedit.text
                                                                  /*, remindtimeedit.text,remindwayedit.text,remindsequenceedit.text*/, eventrepeatedit.text,detailedit.text);
                        }}
                    PropertyChanges { target: cancelmousearea;
                        onClicked:{
                            sticky.state = "adddefultstate";
                            stickytop.visible = false;
                            sticky.canclebuttonclicked();
                        }}
                },State {
                    name: "adddefultstate"
                    PropertyChanges { target: sticky; scale: 0.5; rotation: -5;}
                    PropertyChanges { target: eventrepeatrow; visible: false }
                    PropertyChanges { target: detailrow; visible: false }
                    PropertyChanges { target: button; visible: false }
                    PropertyChanges { target: mouse; onClicked: {sticky.state = "addclickstate"}  onDoubleClicked:{}}
                },State {
                    name: "addclickstate"
                    PropertyChanges { target: sticky; rotation: 0; scale: 0.86; x:page.ListView.view.width/2 -10; y:100}
                    PropertyChanges { target: eventrepeatrow; visible: true }
                    PropertyChanges { target: detailrow; visible: true }
                    PropertyChanges { target: button; visible: true }
                    PropertyChanges { target: mouse; onClicked: {}  onDoubleClicked:{sticky.state ="adddefultstate"}}
                    PropertyChanges { target: okmousearea;
                        onClicked:{
                            sticky.state = "adddefultstate";
                            sticky.okbuttonclicked();
                            scheduledatacpp.updateschedulexmldata(sticky.mydate, sticky.mystickyid.toString(), themeedit.text, occurtimeedit.text, occuraddressedit.text
                                                                  /*, remindtimeedit.text,remindwayedit.text,remindsequenceedit.text*/, eventrepeatedit.text,detailedit.text);
                        }}
                    PropertyChanges { target: cancelmousearea;
                        onClicked:{
                            sticky.state = "adddefultstate";
                        }}
                }
            ]
            transitions: Transition {
                NumberAnimation { properties: "rotation,scale"; duration: 300 }
            }
        }
    ]
}
