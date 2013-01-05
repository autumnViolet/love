// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../lunardata.js" as LunarData

Component{
    Item{
        id:page

        //        property int randomX: Math.random() * (page.ListView.view.width-0.5*500) +70
        //        property int randomY: Math.random() * (page.ListView.view.height-0.5*500) +30

        property string tmpscheduledate: ""
        property bool stickyischanged: true
        property int stickyx: 0
        property int stickyy: 0
        property int tmpstickyx: page.ListView.view.width/2 -10;
        property int tmpstickyy: 100;
        signal passtogooglemaps(string tmpstring)
        signal pagemessagesend(string senscheduledate, int pageid, string sentheme, string senoccurTime, string senoccurAddress,
                               /*string senremindTime, string senremindWay, string senremindSequence,*/ string seneventRepeat, string sendetail)
        function resetlocation(newid){
           if(newid != -10){
            if(stickyischanged){
                stickyx = pagerepeater.itemAt(newid).x;
                stickyy = pagerepeater.itemAt(newid).y;
                stickyischanged = false;
            }


                pagerepeater.itemAt(newid).z = 10;
                pagerepeater.itemAt(newid).x = page.ListView.view.width/2-10;
                pagerepeater.itemAt(newid).y = 100;
            }
        }
        function backlocation(newid){
            if(newid != -10){
                pagerepeater.itemAt(newid).z = 0;
                pagerepeater.itemAt(newid).x = stickyx;
                pagerepeater.itemAt(newid).y = stickyy;
                stickyischanged = true;
            }
        }
        function tmpgoogleaddress(tmpaddressstring){
               var address=tmpaddressstring

            var googlemaps=Qt.createComponent("googlemaps.qml")            
            var googleObject=googlemaps.createObject(page)
//            var rect=Qt.createComponent("rectangle.qml")
//            var rectObject=rect.createObject(page)
            googleObject.height=854
            page.passtogooglemaps.connect(googleObject.getaddress)
            page.passtogooglemaps(tmpaddressstring)

        }

        width: ListView.view.width; height: ListView.view.height

        StickyModel{id: stickymodel}
        Image{
            source: "back.png"
            width: page.ListView.view.width; height: page.ListView.view.height
            fillMode: Image.PreserveAspectCrop
            clip: true
        }
        //        Text {
        //            text: name; x: 15; y: 10; height: 40; width: 370
        //            font.pixelSize: 18; font.bold: true; color: "white"
        //            style: Text.Outline; styleColor: "black"
        //        }
        //        Text {
        //            text: time; x: 150; y: 8; height: 40; width: 370
        //            font.pixelSize: 25; font.bold: true; color: "white"
        //            style: Text.Outline; styleColor: "black"
        //        }
        Component.onCompleted: {
            tmpscheduledate = ""
            var tmpdate = new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getFullYear();
            if((0 < new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getMonth()+1) && (new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getMonth()+1 < 10)){
                tmpdate += "0"+(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getMonth()+1);
            }else{
                tmpdate += ""+(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getMonth()+1);
            }
            if((0 < new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getDate()) && (new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getDate() < 10)){
                tmpdate += "0"+new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getDate();
            }else{
                tmpdate += ""+new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()+index).getDate();
            }
            tmpscheduledate = tmpdate;
            stickymodel.query = "/scheduledata/scheduledate[@scheduledateattr="+tmpdate+"]/schedule"
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
            Item{id:backitem
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
                    color:"lightgrey"
                    font.pointSize: 17
                    anchors.centerIn: parent
                    font.family: "Nokia Sans"
                }
                MouseArea{
                    id:backmousearea
                    anchors.fill: parent
                    onClicked: {
                        if(schedulerectangle.schedulefrom == 0){
                            externdate = new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-index);
                        }
                        schedulerectangle.backweekview()
                        schedulerectangle.destroy()
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

            Item{id: dateitem
                width: parent.width-backitem.width-additem.width
                height: 85
                anchors.left: backitem.right
                Text{
                    id:scheduletext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -15
                    anchors.verticalCenter: parent.verticalCenter
                    text:time
                    font.pointSize: 18
                    font.family:"Nokia Sans"
                    color:"white"
                }
                Text {
                    id: scheduletextlunardate
                    anchors.top: scheduletext.bottom
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -8
                    text: LunarData.GetLunarDateString(new Date(time.substr(0,4), time.substr(5,2)-1, time.substr(8,2)))
                    font.family:"Nokia Sans"
                    color:"white"
                    font.pointSize: 16
                }
            }
            Item{id:additem
                width: 119
                height:56
                anchors{right: parent.right;rightMargin: 10;top:parent.top;topMargin: 17}
                Rectangle{id:addbutten
                    opacity: 0.3
                    width: 119
                    height:56
                    border.width: 1
                    border.color: "black"
                    anchors.centerIn: parent
                    gradient: Gradient {
                        GradientStop {
                            id:addcolor1
                            position: 0.00;
                            color: "#242525";
                        }
                        GradientStop {
                            id:addcolor2
                            position: 1.00;
                            color: "#040505";
                        }
                    }
                }
                Text{id: addtext
                    text: "添加"
                    color:"lightgrey"
                    font.family: "Nokia Sans"
                    anchors.centerIn: parent
                    font.pointSize: 17
                }
                MouseArea{id: addmousearea
                    anchors.fill: parent
                    onClicked: {
                        var component = Qt.createComponent("../../FullRectangle.qml");
                        var fullrect = component.createObject(page);
                        fullrect.height = 854;
                        schedulerectangle.changetointeractive();

                        var component1 = Qt.createComponent("StickyPage.qml");
                        var stickypages = component1.createObject(page);
                        page.pagemessagesend.connect(stickypages.children[0].pagemessagerecived);
                        page.pagemessagesend(tmpscheduledate, "-10", "", "", "", "", "", "", "", "");
                        stickypages.children[0].x = page.width/2-10;
                        stickypages.children[0].y = 100;
                        stickypages.children[0].state = "addstate";
                        stickypages.children[0].addresschoosed.connect(page.tmpgoogleaddress)
                        stickypages.children[0].okbuttonclicked.connect(fullrect.disappearfullrectangle);
                        stickypages.children[0].okbuttonclicked.connect(schedulerectangle.changetonotinteractive);
                        stickypages.children[0].canclebuttonclicked.connect(fullrect.disappearfullrectangle);
                        stickypages.children[0].canclebuttonclicked.connect(schedulerectangle.changetonotinteractive);

                    }
                }
                states: [
                    State {
                        when: addmousearea.pressed
                        PropertyChanges {target:addcolor1;color:"black" }
                        PropertyChanges {target:addcolor2;color:"black" }
                        PropertyChanges {target:addtext;color:"#af2c2c" }
                    }
                ]
            }

        }
        Repeater{id: pagerepeater
            model: stickymodel
            Item{
                id:schedulepages
                property int randomX: Math.random() * (page.ListView.view.width-0.5*500) +70
                property int randomY: Math.random() * (page.ListView.view.height-0.5*500) +30
                x: randomX; y: randomY

                rotation: -scheduleview.horizontalVelocity/100;
                Behavior on rotation {
                    SpringAnimation{ spring: 2.0; damping: 0.15}
                }
                Component.onCompleted: {
                    var component = Qt.createComponent("StickyPage.qml");
                    var stickypages = component.createObject(schedulepages);
                    page.pagemessagesend.connect(stickypages.children[0].pagemessagerecived);
                    page.pagemessagesend(tmpscheduledate, index, theme, occurtime, occuraddress, remindtime, remindway, remindsequence, eventrepeat, detail);
                    stickypages.children[0].turntoeditable.connect(page.resetlocation);
                    stickypages.children[0].turntonotedit.connect(page.backlocation);
                    stickypages.children[0].addresschoosed.connect(page.tmpgoogleaddress)
                }
            }
        }
    }
}
