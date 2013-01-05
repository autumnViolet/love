// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "model" as Model
import "../lunardata.js" as LunarData
import "../"
Item {
    id:monthview
    width: 480
    height: 700
    property date ddd: new Date()
    property string choosedate: ""
    property string choosefestival:""
    property int i: 0
    signal datechoosed()
    signal festivalchoosed()
    signal dateItemchoosed()
    Row{
        id:week;width:480
        WeekDay{Text{anchors.centerIn: parent;text:("周日"); color: "#af2c2c"; font.pointSize: 16}}
        WeekDay{Text{anchors.centerIn: parent;text:("周一"); color: "#ffffff"; font.pointSize: 16}}
        WeekDay{Text{anchors.centerIn: parent;text:("周二"); color: "#ffffff"; font.pointSize: 16}}
        WeekDay{Text{anchors.centerIn: parent;text:("周三"); color: "#ffffff"; font.pointSize: 16}}
        WeekDay{Text{anchors.centerIn: parent;text:("周四"); color: "#ffffff"; font.pointSize: 16}}
        WeekDay{Text{anchors.centerIn: parent;text:("周五"); color: "#ffffff"; font.pointSize: 16}}
        WeekDay{Text{anchors.centerIn: parent;text:("周六"); color: "#af2c2c"; font.pointSize: 16}}
    }
    function lastmonth(){
        monthmodel.move(0,1,2)
        resetmodel()
        var lastdate = new Date(externdate.getFullYear(), externdate.getMonth()-1, externdate.getDate())
        setmodel(lastdate)
        externdate = lastdate

    }
    function currentmonth(){
        resetmodel()
        var currentdate = new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate())
        setmodel(currentdate)
        externdate = currentdate
    }
    function nextmonth(){
        monthmodel.move(0,1,1)
        monthmodel.move(1,2,1)
        resetmodel()
        var nextdate = new Date(externdate.getFullYear(), externdate.getMonth()+1, externdate.getDate())
        setmodel(nextdate)
        externdate = nextdate
    }

    function setlunarday(mysolardate){
        if(LunarData.judgesolarfestival(mysolardate) != ""){

            return LunarData.judgesolarfestival(mysolardate);
        }
        var lunardatestr = LunarData.GetLunarDateString(mysolardate)
        if(lunardatestr.substr(LunarData.getLen(lunardatestr)/2 - 2,2) == "初一"){
            if(lunardatestr.substr(LunarData.getLen(lunardatestr)/2 - 5,1) == "闰"){
                return lunardatestr.substr(LunarData.getLen(lunardatestr)/2 - 5,3)
            }else
                return lunardatestr.substr(LunarData.getLen(lunardatestr)/2 - 4,2)
        }else
            return lunardatestr.substr(LunarData.getLen(lunardatestr)/2 - 2,2)
    }

    function setmodel(monthdate){
        var weekday = new Date(monthdate.getFullYear(), monthdate.getMonth(),1).getDay()
        for(var i=0; i<new Date(monthdate.getFullYear(), monthdate.getMonth()+1, 0).getDate(); i++){
            repeatermodel.set(i+weekday, {"day": i+1,"lunarday": setlunarday(new Date(monthdate.getFullYear(), monthdate.getMonth(), i+1))})
        }
    }
    function resetmodel(){
        for(var i=0; i<42; i++){ repeatermodel.set(i,{"day": "","lunarday": ""})}
    }

    function monthchange(tmpindex){
        if(tmpindex == 0) { lastmonth()}
        else if(tmpindex == 1){currentmonth()}
        else if(tmpindex == 2){nextmonth()}
        else{console.log("ERROR")}
    }


    Model.MonthViewModel{id: monthmodel}
    Model.RepeaterModel{id:repeatermodel}


    Component{
        id: monthdelegate
        Grid{
            id: monthgrid; rows: 6; columns: 7; y: 60
            Repeater{
                id:repeater; height: 110; smooth: true; opacity: 0.2; model: repeatermodel
                Item{
                    id: repeaterect
                    width: 69; height: 105
                    smooth:true
                    states:[ State{
                            when:(index == new Date(externdate.getFullYear(), externdate.getMonth(), 1).getDay() + new Date().getDate()-1)
                                 && (externdate.getFullYear() == new Date().getFullYear()) && (externdate.getMonth() == new Date().getMonth())
                            PropertyChanges{target: highlightimage ; visible:true}
                            //PropertyChanges{target: highlightrectangle ; visible:true}
                        }
                        ,State{
                            when:repeatermodel.get(index).day==""
                            PropertyChanges{target: repeatermousearea;enabled:false}
                        }
                    ]
                    Image{
                        width: 55
                        height: 35
                        id:highlightimage
                        source:"ok2.ico"
                        visible: false
                        anchors.top: lunardaytext.bottom
                        anchors.horizontalCenter: lunardaytext.horizontalCenter
                        anchors.topMargin: -30
                        smooth:true
                    }
                    Rectangle{
                        id:highlightrectangle
                        width: 69;height: 80
                        anchors.centerIn: parent
                        visible: false
                        opacity: 0.5
                       // border.color: "red"
                        smooth: true
                        radius: 10
                        gradient: Gradient {
                            GradientStop {
                                position: 0.00;
                                color: "#d9d3d3";
                            }
                            GradientStop {
                                position: 0.28;
                                color: "#222121";
                            }
                            GradientStop {
                                position: 0.69;
                                color: "#0d0c0c";
                            }
                            GradientStop {
                                position: 1.00;
                                color: "#e0d9d9";
                            }
                        }

                    }

                    Text {id: daytext; text: repeatermodel.get(index).day; font.pointSize: 26; anchors.horizontalCenter: parent.horizontalCenter ;anchors.top: parent.top;anchors.topMargin: 15;color: "black";font.family: "Nokia Sans"
//                        font.bold: true
                    }
                    Text {id: lunardaytext; text: repeatermodel.get(index).lunarday; font.pointSize: 12; anchors.bottom: parent.bottom;anchors.bottomMargin: 30; anchors.horizontalCenter: parent.horizontalCenter;color:"black";font.family: "Nokia Sans"}

                    MouseArea{
                        id:repeatermousearea
                        anchors.fill: parent
                        onClicked:{
                            externdate = new Date(externdate.getFullYear(), externdate.getMonth(), daytext.text)
                            monthview.dateItemchoosed()

                        }
                    }
                    Component.onCompleted: {
                        if((index%7 == 0) || (index%7 == 6)){
                            lunardaytext.color = "#bb0909"
                            daytext.color = "#bb0909"

                        }


                    }
                }
            }
        }
    }

    ListView{
        id:monthlistview
        width:480
        height: 640
        anchors.fill: parent
        model: monthmodel
        delegate: monthdelegate
        currentIndex: 1
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        onCurrentIndexChanged: {
            monthchange(monthlistview.currentIndex)
        }
        clip: true
    }


}
