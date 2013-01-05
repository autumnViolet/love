// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../lunardata.js" as LunarData

Item{
    id: datemenu
    width:360
    smooth: true
    height: 260


Rectangle {
   // id: datemenu
    width:360
    opacity: 0.7
    smooth: true
    height: 260
    radius: 15

    color:"#000000"
}
    NumberAnimation on opacity {from:0; to:0.9; duration:600}
    NumberAnimation on y {from:890; to: 300; duration: 400}

    property int tmpyear: 2000
    property int tmpmonth: 1
    property int tmpday: 1

    property int tmplunaryear:listyearview.currentIndex + 2000
    property int tmplunarmonth: listmonthview.currentIndex
    property int tmplunarday: listdayview.currentIndex

    property int yearbaseindex: -10
    property int monthbaseindex: -10
    property int daybaseindex: -10

    signal rectangelClicked

    function changedaymodel(yy,mm){
        var tmpdate= new Date(yy,mm+1,0).getDate();

        if(listdaymodel.count == 28){
            var tmpconut1 = listdaymodel.count
            for(var i1=0; i1<31-tmpconut1; i1++)
                listdaymodel.append({"day":28+i1+1})
        }else if(listdaymodel.count == 29){
            var tmpconut2 = listdaymodel.count
            for(var i2=0; i2<31-tmpconut2; i2++)
                listdaymodel.append({"day":29+i2+1})
        }else if(listdaymodel.count == 30){
            var tmpconut3 = listdaymodel.count
            for(var i3=0; i3<31-tmpconut3; i3++)
                listdaymodel.append({"day":30+i3+1})
        }

        if(tmpdate == 28){
            var tmpconut4 = listdaymodel.count
            for(var j1=0; j1<tmpconut4-28; j1++){
                listdaymodel.remove(28)
            }
        }else if(tmpdate == 29){
            var tmpconut5 = listdaymodel.count
            for(var j2=0; j2<tmpconut5-29; j2++)
                listdaymodel.remove(29)
        }else if(tmpdate == 30){
            var tmpconut6 = listdaymodel.count
            for(var j3=0; j3<tmpconut6-30; j3++)
                listdaymodel.remove(30)
        }
    }
    function changelunarmonthmodel(ly){
        var szText = new String("正二三四五六七八九十冬腊");
        var leapmonth = LunarData.GetLeapMonth(ly);

        for(var k=0; k<12; k++)
            listlunarmonthmodel.set(k,{month: szText.substr(k,1)});
        if(listlunarmonthmodel.count > 12)
            listlunarmonthmodel.remove(12);

        if(leapmonth != 0){
            for(var i=1; i<13; i++){
                if(leapmonth == i){
                    listlunarmonthmodel.set(i,{month:"闰"+szText.substr(i-1,1)});
                    for(var j=i; j<12; j++){
                        listlunarmonthmodel.set(j+1,{month: szText.substr(j,1)});
                    }
                }
            }
        }
    }
    function changelunardaymodel(ly,lm){
        listlunardaymodel.set(28,{day: "廿九"});
        listlunardaymodel.set(29,{day: "三十"});

        var lunarmonthdays = 0;
        var leapmonth = LunarData.GetLeapMonth(ly);
        if(leapmonth == 0){
            lunarmonthdays = LunarData.LunarMonthDays(ly,lm);
        }else{
            if(lm < leapmonth){
                lunarmonthdays = LunarData.LunarMonthDays(ly,lm);
            }else if(lm == leapmonth){
                lunarmonthdays = LunarData.LunarMonthDays(ly,lm)& 0xffff;
            }else if(lm == leapmonth+1){
                lunarmonthdays = (LunarData.LunarMonthDays(ly,lm-1) >> 16) & 0xffff;
            }else if(lm > leapmonth+1){
                lunarmonthdays = LunarData.LunarMonthDays(ly,lm-1);
            }
        }

        if(lunarmonthdays == 28){
            for(var i=0; i<listlunardaymodel.count-28; i++)
                listlunardaymodel.remove(28);
        }else if(lunarmonthdays == 29){
            for(var j=0; j<listlunardaymodel.count-29; j++)
                listlunardaymodel.remove(29);
        }
    }

    function changetosolarmodel(yindex,mindex,dindex){
        var dayschangecount = 0;
        if((yearbaseindex != -10) && (monthbaseindex != -10) && (daybaseindex != -10)){
            var basedaystofirstdays =  daystocurtyearfirstlunarday(yearbaseindex+2000, monthbaseindex+1, daybaseindex+1);
            var currentdaystofirstdays = daystocurtyearfirstlunarday(yindex+2000, mindex+1, dindex+1);
            if(yindex < yearbaseindex){
                for(var i = yindex; i < yearbaseindex; i++){
                    dayschangecount += LunarData.LunarYearDays(i+2000);
                }
                dayschangecount = dayschangecount + basedaystofirstdays - currentdaystofirstdays;
                externdate = new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-dayschangecount);

            }else if(yindex == yearbaseindex){
                dayschangecount = basedaystofirstdays - currentdaystofirstdays
                externdate = new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-dayschangecount);
            }else if(yindex > yearbaseindex){
                for(var j=yearbaseindex; j<yindex; j++){
                    dayschangecount += LunarData.LunarYearDays(j+2000);
                }
                dayschangecount = dayschangecount - basedaystofirstdays + currentdaystofirstdays;
                externdate = new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+dayschangecount);
            }

        }
    }
    function daystocurtyearfirstlunarday(lunaryear, lunarmonth, lunarday){
        var Days = 0;
        var tmp;
        var leapmonth = LunarData.GetLeapMonth(lunaryear);
        if(0 == leapmonth){
        }else if( lunarmonth <= leapmonth){
        }else if( lunarmonth-1 == leapmonth){
            Days = LunarData.LunarMonthDays(lunaryear, leapmonth)& 0xffff;
            lunarmonth = lunarmonth -1;
        }else if( lunarmonth-1 > leapmonth){
            lunarmonth = lunarmonth -1;
        }

        for (var i=1; i < lunarmonth; i++)
        {
            tmp = LunarData.LunarMonthDays(lunaryear, i);
            Days = Days + ((tmp >> 16) & 0xffff);
            Days = Days + (tmp & 0xffff);
        }
        Days = Days + lunarday;
        return Days;
    }

    function changetolunaryearmodel(tmpsolardate){
        var lunardatestring = LunarData.GetLunarDateString(tmpsolardate);
        var lunarmonthstring = new String(lunardatestring.substr(LunarData.getLen(lunardatestring)/2-4, 1));
        if((lunarmonthstring == "腊") && (tmpsolardate.getMonth() < 7)){
            listyearview.currentIndex = tmpsolardate.getFullYear()-2000-1;
        }
        return tmpsolardate.getFullYear();
    }
    function changetolunarmonthmodel(tmpsolardate){
        var lunaryyear = changetolunaryearmodel(tmpsolardate);
        var leapmonth = LunarData.GetLeapMonth(lunaryyear);
        var szText = new String("正二三四五六七八九十冬腊");
        var lunardatestring = LunarData.GetLunarDateString(tmpsolardate);
        if(leapmonth == 0){
            var lunarmonthstring = new String(lunardatestring.substr(LunarData.getLen(lunardatestring)/2-4, 1));
            for(var i=0; i<12; i++){
                if(lunarmonthstring == szText.substr(i,1)){
                    listmonthview.currentIndex = i;
                }
            }
        }else if(leapmonth != 0){
            var lunarmonthstring = new String(lunardatestring.substr(LunarData.getLen(lunardatestring)/2-5, 2));
            if (lunarmonthstring.substr(0,1) == "闰"){
                listmonthview.currentIndex = leapmonth;
            }else{
                for(var i=0; i<12; i++){
                    if(lunarmonthstring.substr(1,1) == szText.substr(i,1)){
                        if((i<leapmonth) ){
                            listmonthview.currentIndex = i;
                        }
                        else if((i>leapmonth) || (i==leapmonth)){
                            if(leapmonth != 0)
                                listmonthview.currentIndex = i+1;
                            else
                                listmonthview.currentIndex = i;
                        }
                    }
                }
            }
        }
    }

    function changetolunardaymodel(tmpsolardate){
        var szText1 = new String("初十廿三");
        var szText2 = new String("一二三四五六七八九");
        var lunardatestring = LunarData.GetLunarDateString(tmpsolardate);
        var lunardaystring = new String(lunardatestring.substr(LunarData.getLen(lunardatestring)/2-2, 2));
        var tens=0, unit=0;
        for(var i=0; i<4; i++){
            if(lunardaystring.substr(0,1) == szText1.substr(i, 1)){
                tens = i;
            }
        }
        if(lunardaystring.substr(1,1) == "十")
            unit = 0;
        for(var j=0; j<10; j++){
            if(lunardaystring.substr(1,1) == szText2.substr(j, 1)){
                unit = j+1;
            }
        }
        listdayview.currentIndex = tens*10+unit-1;
    }
    ListModel{
        id: listyearmodel;       ListElement{year: "2000"}ListElement{year: "2001"}
        ListElement{year: "2002"}ListElement{year: "2003"}ListElement{year: "2004"}
        ListElement{year: "2005"}ListElement{year: "2006"}ListElement{year: "2007"}
        ListElement{year: "2008"}ListElement{year: "2009"}ListElement{year: "2010"}
        ListElement{year: "2011"}ListElement{year: "2012"}ListElement{year: "2013"}

        ListElement{year: "2014"}ListElement{year: "2015"}ListElement{year: "2016"}
        ListElement{year: "2017"}ListElement{year: "2018"}ListElement{year: "2019"}
        ListElement{year: "2020"}ListElement{year: "2021"}ListElement{year: "2022"}
        ListElement{year: "2023"}ListElement{year: "2024"}ListElement{year: "2025"}
        ListElement{year: "2026"}ListElement{year: "2027"}ListElement{year: "2028"}

        ListElement{year: "2029"}ListElement{year: "2030"}ListElement{year: "2031"}
        ListElement{year: "2032"}ListElement{year: "2033"}ListElement{year: "2034"}
        ListElement{year: "2035"}ListElement{year: "2036"}ListElement{year: "2037"}
        ListElement{year: "2038"}ListElement{year: "2039"}ListElement{year: "2040"}

        ListElement{year: "2041"}ListElement{year: "2042"}ListElement{year: "2043"}
        ListElement{year: "2044"}ListElement{year: "2045"}ListElement{year: "2046"}
        ListElement{year: "2047"}ListElement{year: "2048"}ListElement{year: "2049"}
        ListElement{year: "2050"}
    }
    ListModel{id: listmonthmodel;
        ListElement{month: "1"} ListElement{month: "2"} ListElement{month: "3"}
        ListElement{month: "4"} ListElement{month: "5"} ListElement{month: "6"}
        ListElement{month: "7"} ListElement{month: "8"} ListElement{month: "9"}
        ListElement{month: "10"}ListElement{month: "11"}ListElement{month: "12"}
    }
    ListModel{id: listlunarmonthmodel;
        ListElement{month: "正"} ListElement{month: "二"} ListElement{month: "三"}
        ListElement{month: "四"} ListElement{month: "五"} ListElement{month: "六"}
        ListElement{month: "七"} ListElement{month: "八"} ListElement{month: "九"}
        ListElement{month: "十"} ListElement{month: "冬"} ListElement{month: "腊"}
    }
    ListModel{id: listdaymodel; ListElement{day: "1"}
        ListElement{day: "2"} ListElement{day: "3"} ListElement{day: "4"}
        ListElement{day: "5"} ListElement{day: "6"} ListElement{day: "7"}
        ListElement{day: "8"} ListElement{day: "9"} ListElement{day: "10"}
        ListElement{day: "11"}ListElement{day: "12"}ListElement{day: "13"}
        ListElement{day: "14"}ListElement{day: "15"}ListElement{day: "16"}

        ListElement{day: "17"}ListElement{day: "18"}ListElement{day: "19"}
        ListElement{day: "20"}ListElement{day: "21"}ListElement{day: "22"}
        ListElement{day: "23"}ListElement{day: "24"}ListElement{day: "25"}
        ListElement{day: "26"}ListElement{day: "27"}ListElement{day: "28"}
        ListElement{day: "29"}ListElement{day: "30"}ListElement{day: "31"}
    }
    ListModel{id: listlunardaymodel;
        ListElement{day: "初一"}ListElement{day: "初二"}ListElement{day: "初三"}
        ListElement{day: "初四"}ListElement{day: "初五"}ListElement{day: "初六"}
        ListElement{day: "初七"}ListElement{day: "初八"}ListElement{day: "初九"}
        ListElement{day: "初十"}ListElement{day: "十一"}ListElement{day: "十二"}
        ListElement{day: "十三"}ListElement{day: "十四"}ListElement{day: "十五"}

        ListElement{day: "十六"}ListElement{day: "十七"}ListElement{day: "十八"}
        ListElement{day: "十九"}ListElement{day: "廿十"}ListElement{day: "廿一"}
        ListElement{day: "廿二"}ListElement{day: "廿三"}ListElement{day: "廿四"}
        ListElement{day: "廿五"}ListElement{day: "廿六"}ListElement{day: "廿七"}
        ListElement{day: "廿八"}ListElement{day: "廿九"}ListElement{day: "三十"}
    }
    ListModel{id: listchangemodel;ListElement{change:"公历"} ListElement{change:"农历"}}

    Component{
        id: listyeardelegate
        Item {
            width: 80; height: 20;
            Text { text: year;font.pointSize: 15;anchors.centerIn: parent ;color: "#000000";font.family: "Nokia Sans"}
            MouseArea{
                anchors.fill: parent
                onClicked:listyearview.currentIndex=index
            }
        }
    }
    Component{
        id: listmonthdelegate
        Item {
            width: 60; height: 20 ;
            Text { text: month+"月";font.pointSize: 15; anchors.centerIn: parent;color: "#000000";font.family: "Nokia Sans"}
            MouseArea{
                anchors.fill: parent
                onClicked:listmonthview.currentIndex=index
            }
        }
    }
    Component{
        id: listdaydelegate
        Item{
            width: 60; height: 20
            Text { text: day;font.pointSize: 15; anchors.centerIn: parent;color: "#000000";font.family: "Nokia Sans"}
            MouseArea{
                anchors.fill: parent
                onClicked:listdayview.currentIndex=index
            }
        }
    }
    Component{
        id: listchangedelegate
        Item{
            width: 60; height: 20;
            Text { text: change;font.pointSize: 15; anchors.centerIn: parent; color: "#000000";font.family: "Nokia Sans"}
            MouseArea{
                anchors.fill: parent
                onClicked:listchangeview.currentIndex=index
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
                id:listyearview
                width: 90; height: 140
                opacity: 0.8
                spacing: 8
                model: listyearmodel
                currentIndex: externdate.getFullYear()-2000
                delegate: listyeardelegate
                snapMode: ListView.SnapOneItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                boundsBehavior:Flickable.DragAndOvershootBounds
                clip:true
                preferredHighlightBegin: 64
                preferredHighlightEnd: 64
                onCurrentIndexChanged: {
                    tmpyear = listyearmodel.get(listyearview.currentIndex).year
                    changedaymodel(tmpyear,tmpmonth)
                }
            }
        }
        Rectangle{
            width: 70; height: 140
            border.width: 1
            radius:6
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
                id:listmonthview
                width: 70; height: 140
                opacity: 0.8
                spacing:8
                model: listmonthmodel
                currentIndex: externdate.getMonth()
                delegate: listmonthdelegate
                snapMode: ListView.SnapOneItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                boundsBehavior:Flickable.DragAndOvershootBounds
                clip:true
                preferredHighlightBegin: 64
                preferredHighlightEnd: 64
                onCurrentIndexChanged: {
                    tmpmonth = listmonthmodel.get(listmonthview.currentIndex).month-1
                    changedaymodel(tmpyear,tmpmonth)
                }
            }
        }
        Rectangle{
            width: 70; height: 140
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
                id:listdayview
                width: 70; height: 140
                opacity: 0.8
                spacing: 8
                model: listdaymodel
                currentIndex: externdate.getDate()-1
                delegate: listdaydelegate
                snapMode: ListView.SnapOneItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                boundsBehavior:Flickable.DragAndOvershootBounds
                clip:true
                preferredHighlightBegin: 64
                preferredHighlightEnd: 64
                onCurrentIndexChanged: {
                    tmpday = listdaymodel.get(listdayview.currentIndex).day

                }
            }
        }
        Rectangle{
            id:listchangerect
            width: 70; height: 140
            border.width: 1
            radius:5
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#000000";
                }
                GradientStop {
                    position: 0.5;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 0.55;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 1;
                    color: "#000000";
                }
            }
            ListView{
                id:listchangeview
                width: 70; height: 140
                opacity: 0.8
                model: listchangemodel
                delegate: listchangedelegate
                snapMode: ListView.SnapOneItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                boundsBehavior:Flickable.DragAndOvershootBounds
                clip:true
                spacing: 8
                preferredHighlightBegin: 64
                preferredHighlightEnd: 64
                onCurrentIndexChanged: {
                    if(listchangeview.currentIndex == 0){
                        datemenu.state = "";
                        changetosolarmodel(listyearview.currentIndex,listmonthview.currentIndex,listdayview.currentIndex);
                        listyearview.currentIndex = externdate.getFullYear()-2000;
                        listmonthview.currentIndex = externdate.getMonth();
                        listdayview.currentIndex = externdate.getDate()-1;
                        tmpyear = listyearmodel.get(listyearview.currentIndex).year;
                        tmpmonth  = listmonthmodel.get(listmonthview.currentIndex).month-1;
                        tmpday = listdaymodel.get(listdayview.currentIndex).day;
                    }else if(listchangeview.currentIndex == 1){
                        externdate =new Date(tmpyear,tmpmonth,tmpday)
                        datemenu.state = "changetolunar";
                        changelunarmonthmodel(tmplunaryear);
                        changelunardaymodel(tmplunaryear,tmplunarmonth);
                        changetolunaryearmodel(externdate);
                        changetolunarmonthmodel(externdate);
                        changetolunardaymodel(externdate);

                        yearbaseindex = listyearview.currentIndex;
                        monthbaseindex = listmonthview.currentIndex;
                        daybaseindex = listdayview.currentIndex;
                    }
                }
                states:State {
                    when:okmousearea.pressed
                    PropertyChanges {
                        target:listchangeview
                        currentIndex: 0
                    }
                }
            }
        }

    }


    Rectangle{
        id: highlight
        x:24

        y: 95
       // anchors{left: parentleft;leftMargin: 8}

        width: parent.width-48
        height:28
        //color:"#84a09e"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#e1e6e6";
            }
            GradientStop {
                position: 0.43;
                color: "lightgrey";
            }
            GradientStop {
                position: 0.57;
                color: "lightgrey";
            }
            GradientStop {
                position: 1.00;
                color: "#e7eaea";
            }
        }
        //        color:"#84a09e"
        opacity: 0.2
    }

    states:[ State {
            name: "changetolunar"
            PropertyChanges {
                target: listyearview
                onCurrentIndexChanged:{
                    tmplunaryear = listyearview.currentIndex + 2000;
                    changelunarmonthmodel(tmplunaryear);
                    changelunardaymodel(tmplunaryear,tmplunarmonth);
                    //                yearcurrentindexchanged = listyearview.currentIndex;
                }
            }
            PropertyChanges {
                target: listmonthview
                model: listlunarmonthmodel
                onCurrentIndexChanged:{
                    tmplunarmonth = listmonthview.currentIndex;
                    changelunardaymodel(tmplunaryear,tmplunarmonth);
                    //                monthcurrentindexchanged = listmonthview.currentIndex;
                }
            }
            PropertyChanges {
                target: listdayview
                model: listlunardaymodel
                onCurrentIndexChanged:{
                    //                daycurrentindexchanged = listdayview.currentIndex;
                }
            }
        },State{
            name:"disappear"
            PropertyChanges{target: datemenu; y:890}
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
                    externdate =new Date(tmpyear,tmpmonth,tmpday);
                    var tenviewsourc = new String(externviewsource);

                    if (tenviewsourc.substr(LunarData.getLen(tenviewsourc) - 13, 13) == "MonthView.qml"){
                        externviewsource = ""
                        datedisplay.state = ""
                        externviewsource = "ThreeView/MonthView.qml"
                    }else if(tenviewsourc.substr(LunarData.getLen(tenviewsourc) - 12, 12)  == "WeekView.qml"){
                        externviewsource = ""
                        externviewsource = "ThreeView/WeekView.qml"
                    }else if(tenviewsourc.substr(LunarData.getLen(tenviewsourc) - 11, 11)  == "DayView.qml"){
                        externviewsource = ""
                        datedisplay.state = "showfulldate"
                        externviewsource = "ThreeView/DayView.qml"
                    }
                    datemenu.rectangelClicked()
                    datemenu.state="disappear"
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
                    datemenu.state="disappear"
                    datemenu.rectangelClicked()
                    destroyed.start()
                }
            }
        }
    }

    Timer{
        id:destroyed
        interval: 400
        running: false
        onTriggered: datemenu.destroy()
    }

}
