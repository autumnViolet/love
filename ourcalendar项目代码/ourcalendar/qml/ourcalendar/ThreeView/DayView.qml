// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "model" as Model
import "Schedule" as Schedule
import "../lunardata.js" as LunarData

Item{
    id:dayview
    width: 480; height: 700;opacity: 1
    Rectangle{width: 480; height: 700;opacity: 0;color:"white"}
    Model.JanModel{id:janmodel}
    Model.FebModel{id:febmodel}
    Model.MarModel{id:marmodel}
    Model.AprModel{id:aprmodel}
    Model.MayModel{id:maymodel}
    Model.JunModel{id:junmodel}
    Model.JulyModel{id:julymodel}
    Model.AugModel{id:augmodel}
    Model.SepModel{id:sepmodel}
    Model.OctModel{id:octmodel}
    Model.NovModel{id:novmodel}
    Model.DecModel{id:decmodel}
    property int currentindexday: 0
    property int primaryindexday: externdate.getDate()-1
    signal createschedule()
    function changedaystring(curindex ){
        currentindexday = curindex
        if(currentindexday-primaryindexday == 0){
            if((curindex == 0) || (curindex == 1)){
                judgeDays(externdate.getFullYear(), externdate.getMonth()-1)
            }else if((1 < curindex)){
                judgeDays(externdate.getFullYear(), externdate.getMonth())
            }
        }else if(currentindexday-primaryindexday == -1){
            if(curindex == 1)
                judgeDays(externdate.getFullYear(), externdate.getMonth()-1)
        }else if(currentindexday-primaryindexday == 1){
            if(curindex == 2)
                judgeDays(externdate.getFullYear(), externdate.getMonth())
        }else if(currentindexday-primaryindexday < -1){
            if(curindex == 0)
                externdate = new Date(externdate.getFullYear(), externdate.getMonth()+1, 1)
            showMonthFirstDay(view.currentIndex)
        }else if(currentindexday-primaryindexday >1) {
            if(curindex == dayViewModel.count-1){
                externdate = new Date(externdate.getFullYear(), externdate.getMonth()-1, 1)
                showMonthFirstDay(view.currentIndex)
            }
        }
        externdate = new Date(externdate.getFullYear(), externdate.getMonth(), curindex+1)
        primaryindexday = currentindexday
    }

    function judgeDays(yy, mm){
        var tmpdate= new Date(yy,mm+1,0).getDate();

        if(dayViewModel.count == 28){
            var tmpconut1 = dayViewModel.count
            for(var i1=0; i1<31-tmpconut1; i1++){
                dayViewModel.append({"day":28+i1+1})
            }
        }else if(dayViewModel.count == 29){
            var tmpconut2 = dayViewModel.count
            for(var i2=0; i2<31-tmpconut2; i2++)
                dayViewModel.append({"day":29+i2+1})
        }else if(dayViewModel.count == 30){
            var tmpconut3 = dayViewModel.count
            for(var i3=0; i3<31-tmpconut3; i3++)
                dayViewModel.append({"day":30+i3+1})
        }

        if(tmpdate == 28){
            var tmpconut4 = dayViewModel.count
            for(var j1=0; j1<tmpconut4-28; j1++){
                dayViewModel.remove(28)
            }
        }else if(tmpdate == 29){
            var tmpconut5 = dayViewModel.count
            for(var j2=0; j2<tmpconut5-29; j2++)
                dayViewModel.remove(29)
        }else if(tmpdate == 30){
            var tmpconut6 = dayViewModel.count
            for(var j3=0; j3<tmpconut6-30; j3++)
                dayViewModel.remove(30)
        }
    }
    function showMonthFirstDay(currentindex){
        if(currentindex==0||currentindex==dayViewModel.count-1)
        {
            showmonthfirstday.text=(externdate.getMonth()+1)+"月"
            showmonthfirstday.visible=true
            showfirstdaytimer.start()

        }
    }

    Model.DayViewModel{id:dayViewModel}

    Text {
        id: showmonthfirstday
        width: 25
        height: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.horizontalCenterOffset: -10
        anchors.bottomMargin: 180
        text:""
        font.pointSize: 20
        font.family: "Adventure"
        visible: false
    }
    Text {
        id: showtoday
        width: 25
        height: 25
        anchors.left:parent.left
        anchors.leftMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 180
        text: ""
        font.pointSize: 20
        font.family: "Adventure"

    }
    Component {
        id: dayDelegate

        Item{
            id:mycomponent
            width: 180
            height:200
            opacity: PathView.myopacity
            visible: PathView.onPath
            z: PathView.zOrder
            anchors.top: parent.top
            anchors.topMargin: 20

            Item{
                id:rect
                width: 180
                height: 200
                x:0
                y:0
                Rectangle{
                    id:rectangle
                    z: 2
                    width: 180
                    height: 200
                    color: "#95999e"
                    //                radius: 12
                    gradient: Gradient {
                        GradientStop {
                            position: 0.28;
                            color: "#ffffff";
                        }
                        GradientStop {
                            position: 0.54;
                            color: "#dbe3e4";
                        }
                        GradientStop {
                            position: 0.91;
                            color: "#858f91";
                        }
                    }
                    anchors.horizontalCenterOffset: 0
                    smooth: true
                }
                Text {
                    id:pathtext
                    x:4
                    y:59
                    z:5
                    text: day
                    font.pointSize: 45
                    anchors.centerIn: rectangle
                    anchors.verticalCenterOffset: 8
                    anchors.horizontalCenterOffset: 2
                }

                anchors.horizontalCenter: parent.horizontalCenter

            }

            Item{
                id:subrect
                x: 0
                y:20
                width: 180
                height:200
                //color: "#f9f2f2"
                opacity: 0.4
                Text {
                    x: 0
                    y: -150
                    text: day
                    z: 2
                    color: "#000000"
                    font.pointSize: 45
                    anchors.verticalCenterOffset: -182
                    anchors.horizontalCenterOffset: -2
                    anchors.centerIn: subrect

                }
                anchors.horizontalCenter: parent.horizontalCenter
                transform: Rotation { origin.x: 0; origin.y: 90; axis { x: 1; y: 0; z: 0 } angle: 180 }
                //                radius: 12

                z: 0
                anchors.horizontalCenterOffset: 0
            }

            Rectangle{
                y: rect.height;
                x: 0
                smooth: true
                width: rect.width + 1
                height: mycomponent.PathView.bottomrectheight
                //                radius: 12
                gradient: Gradient {
                    GradientStop {
                        position: 0.00;
                        color: "#858f91";
                    }
                    GradientStop {
                        position: 0.36;
                        color: "#ffffff";
                    }

                }

                opacity: 0.60
            }

            transform:[
                Rotation{
                    angle: mycomponent.PathView.rotateY
                    axis { x: 0; y: 1; z: 0 }
                },
                Scale {
                    xScale:mycomponent.PathView.scalePic; yScale:mycomponent.PathView.scalePic
                    origin.x: 120/2; origin.y: 90/2
                }
            ]
        }
    }
    PathView {
        id: view
        focus: true
        model: dayViewModel
        delegate: dayDelegate
        anchors.fill: parent
        anchors.topMargin: 5
        pathItemCount: 5

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        onCurrentIndexChanged: {
            changedaystring(view.currentIndex)
            judgemodel()

            var tmpdate = externdate.getFullYear();
            if((0 < (externdate.getMonth()+1) && (externdate.getMonth()+1) < 10)){
                tmpdate += "0"+(externdate.getMonth()+1);
            }else{
                tmpdate += ""+(externdate.getMonth()+1);
            }
            if((0 < externdate.getDate()) && (externdate.getDate() < 10)){
                tmpdate += "0"+externdate.getDate();
            }else{
                tmpdate += ""+externdate.getDate();
            }
            schedulemodel.query = "/scheduledata/scheduledate[@scheduledateattr="+tmpdate+"]/schedule"
        }

        flickDeceleration: 390
        path: myPath
        Component.onCompleted: {
            changedaystring(primaryindexday)
            currentIndex = primaryindexday
            judgemodel()
        }
    }
    Path {
        id: myPath
        startX: 70; startY: 100
        PathAttribute {name: "rotateY"; value: 35.0}
        PathAttribute {name: "scalePic"; value: 0.6}
        PathAttribute {name: "zOrder"; value: 1}
        PathAttribute {name: "textX"; value: 0}
        PathAttribute {name: "myopacity"; value: 0.1}
        PathAttribute {name: "bottomrectheight"; value: 200}


        PathLine{x:200; y: 100}
        PathPercent {value: 0.44}
        PathAttribute {name: "rotateY"; value: 35.0}
        PathAttribute {name: "scalePic"; value: 0.6}
        PathAttribute {name: "zOrder"; value: 10}
        PathAttribute {name: "myopacity"; value: 0.8}
        PathAttribute {name: "bottomrectheight"; value: 200}

        PathQuad{x:240; y: 90; controlX: 320; controlY: 80}
        PathPercent {value: 0.50}
        PathAttribute {name: "rotateY"; value: 0.0}
        PathAttribute {name: "scalePic"; value: 0.9}
        PathAttribute {name: "zOrder"; value: 50}
        PathAttribute {name: "myopacity"; value: 1}
        PathAttribute {name: "bottomrectheight"; value: 100}

        PathQuad{x:320; y: 100; controlX: 318; controlY:100}
        PathPercent {value: 0.56}
        PathAttribute {name: "rotateY"; value: -35.0}
        PathAttribute {name: "scalePic"; value: 0.55}
        PathAttribute {name: "zOrder"; value: 10}
        PathAttribute {name: "myopacity"; value: 0.8}
        PathAttribute {name: "bottomrectheight"; value: 200}

        PathLine{x:460; y: 100}
        PathPercent {value: 1.00}
        PathAttribute {name: "rotateY"; value: -35.0}
        PathAttribute {name: "scalePic"; value: 0.55}
        PathAttribute {name: "zOrder"; value: 1}
        PathAttribute {name: "myopacity"; value: 0.1}
        PathAttribute {name: "bottomrectheight"; value: 200}
    }

    Timer{
        id:showfirstdaytimer
        running: false
        interval: 1000
        onTriggered: {
            showmonthfirstday.visible=false
        }

    }

    //    Text {
    //        id: dayviewsolartext
    //        text: externdate.getFullYear()+"年"+(externdate.getMonth()+1)+"月"+dayViewModel.get(currentindexday).day+"日"
    //        font.family: "华文行楷"
    //        anchors.bottom: parent.bottom
    //        anchors.bottomMargin: 270
    //        anchors.left:parent.left
    //        font.pointSize: 20
    //    }
    Item{
        id:feastitem
        width: 440
        height: 115
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 290
        anchors.left:parent.left
        anchors.leftMargin: 20
        Rectangle{
            width: 440
            height:150
            border.color: "black"
            border.width: 1
            opacity: 0.6
            anchors.top:parent.top
            anchors.topMargin: 4
            radius: 10
        }
        Rectangle{
            width: 440
            height: 1
            color: "black"
            opacity: 0.6
            anchors.top: parent.top
            anchors.topMargin: 40
        }

        Text {
            id: feasttext
            text:"节日:"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 80
            anchors.left:parent.left
            anchors.leftMargin: 20
            font.family: "Nokia Sans"

            font.pointSize: 17
        }
        Text {
            id: dayviewfestivaltext
            text:LunarData.judgesolarfestival(externdate)
            anchors.bottom: parent.bottom
            anchors.bottomMargin:80
            anchors.left:parent.left
            anchors.leftMargin:80
            font.pointSize: 17
        }
        Component{
            id:dayfestivaldetaildelegate
            Text {
                id:dayfestivaldetailtext
                width: 400

                wrapMode:Text.WordWrap
                font.letterSpacing: 2

                text:""
                font.pointSize: 16
                font.wordSpacing: 9
                visible: true
            }


        }
    }

    function judgemodel()
    {

        var month=externdate.getMonth()+1;
        var festivalstring=LunarData.judgesolarfestival(externdate)
        switch (month){
        case 1:
            feastview.currentItem.text="";
            for(var i=0; i<janmodel.count; i++){
                if(janmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=janmodel.get(i).detail
            }
            break;
        case 2:
            feastview.currentItem.text="";
            for(var i=0; i<febmodel.count; i++){
                if(febmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=febmodel.get(i).detail
            }
            break;
        case 3:
            feastview.currentItem.text="";
            for(var i=0; i<marmodel.count; i++){
                if(marmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=marmodel.get(i).detail
            }
            break;
        case 4:
            feastview.currentItem.text="";
            for(var i=0; i<aprmodel.count; i++){
                if(aprmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=aprmodel.get(i).detail
            }
            break;
        case 5:
            feastview.currentItem.text="";
            for(var i=0; i<maymodel.count; i++){
                if(maymodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=maymodel.get(i).detail
            }
            break;
        case 6:
            feastview.currentItem.text="";
            for(var i=0; i<junmodel.count; i++){
                if(junmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=junmodel.get(i).detail
            }
            break;
        case 7:
            feastview.currentItem.text="";
            for(var i=0; i<julymodel.count; i++){
                if(julymodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=julymodel.get(i).detail
            }
            break;
        case 8:
            feastview.currentItem.text="";
            for(var i=0; i<augmodel.count; i++){
                if(augmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=augmodel.get(i).detail
            }
            break;
        case 9:
            feastview.currentItem.text="";
            for(var i=0; i<sepmodel.count; i++){
                if(sepmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=sepmodel.get(i).detail
            }
            break;
        case 10:
            feastview.currentItem.text="";
            for(var i=0; i<octmodel.count; i++){
                if(octmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=octmodel.get(i).detail
            }
            break;
        case 11:
            feastview.currentItem.text="";
            for(var i=0; i<novmodel.count; i++){
                if(novmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=novmodel.get(i).detail
            }
            break;
        case 12:
            feastview.currentItem.text="";
            for(var i=0; i<decmodel.count; i++){
                if(decmodel.get(i).fest == festivalstring)
                    feastview.currentItem.text=decmodel.get(i).detail
            }
            break;
        }

    }
    Item{
        id:scheduleitem
        width: 440
        height: 154
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 55
        anchors.left: parent.left
        anchors.leftMargin: 20
        Rectangle{
            width: 440
            height:154
            border.color: "black"
            border.width: 1
            opacity: 0.6
            anchors.centerIn: parent
            radius: 10
        }
        Rectangle{
            width: 440
            height: 1
            color: "black"
            opacity: 0.6
            anchors.top: parent.top
            anchors.topMargin: 30
        }
        Rectangle{
            width: 440
            height: 1
            color: "black"
            opacity: 0.6
            anchors.top: parent.top
            anchors.topMargin: 61
        }
        Rectangle{
            width: 440
            height: 1
            color: "black"
            opacity: 0.6
            anchors.top: parent.top
            anchors.topMargin: 92
        }
        Rectangle{
            width: 440
            height: 1
            color: "black"
            opacity: 0.6
            anchors.top: parent.top
            anchors.topMargin: 122
        }

        Text {
            id: scheduletext
            text:"日程主题"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 160
            anchors.left:parent.left
            anchors.leftMargin: 10
            font.family: "Nokia Sans"

            font.pointSize: 17
        }
        ListView{
            clip:true
            width: 420
            height: 154
            preferredHighlightBegin: 8
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightEnd: 8
            spacing: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left:parent.left
            anchors.leftMargin: 30
            model: schedulemodel
            delegate: scheduledelegate
            onCurrentIndexChanged: {
                if(currentIndex > 1){
                    currentIndex=1

                }
            }
        }


    }

    ListView{
        id:feastview
        model:1
        delegate: dayfestivaldetaildelegate
        anchors.left:parent.left
        anchors.leftMargin: 30
        anchors.top: feastitem.top
        anchors.topMargin:50
        height: currentItem.height
        opacity: 1
    }


    Schedule.StickyModel{id: schedulemodel}
    Component.onCompleted: {
        var tmpdate = externdate.getFullYear();
        if((0 < (externdate.getMonth()+1) && (externdate.getMonth()+1) < 10)){
            tmpdate += "0"+(externdate.getMonth()+1);
        }else{
            tmpdate += ""+(externdate.getMonth()+1);
        }
        if((0 < externdate.getDate()) && (externdate.getDate() < 10)){
            tmpdate += "0"+externdate.getDate();
        }else{
            tmpdate += ""+externdate.getDate();
        }
        schedulemodel.query = "/scheduledata/scheduledate[@scheduledateattr="+tmpdate+"]/schedule"
    }
    Component{
        id: scheduledelegate
        Item{
            width: 420
            height: 30

            Column{
                Text { id: themetext
                    text: theme
                    font.pointSize: 16
                }
                Text { id: detailtext
                    text: detail
                }
            }
            MouseArea{
                anchors.fill: parent
                onDoubleClicked: {
                    var component2 = Qt.createComponent("Schedule/ScheduleView.qml");
                    var Object = component2.createObject(dayview);
                    Object.y = -85;
                    dayview.createschedule.connect(Object.dayschedule);
                    Object.dayschedule();
                }
            }
        }
    }
}
