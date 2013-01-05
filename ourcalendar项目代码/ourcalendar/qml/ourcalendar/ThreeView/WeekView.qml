// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "Schedule" as Schedule
import "../lunardata.js" as LunarData

Item {id: weekviewitem
    width: 480; height:684
    property int slideDistance: 0
    property bool changecolor1: false
    property bool changecolor2: false
    signal turnbig()
    signal turnsmall()
    onTurnbig: {
        weekview.height = 854;
        weekview.interactive = false;
    }
    onTurnsmall: {
        weekview.height = 684;
        weekview.interactive = true;
    }

    function changetoLastweek(){
        setweek(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-7))
    }

    function changetoNextweek(){
        setweek(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+7))
    }
    function setweek(weekdate){
        var currentweeker = weekdate.getDay()
        var currentday = weekdate.getDate()
        for(var i=0; i<currentweeker; i++)
            weekmodel.set(i, {"day": new Date(weekdate.getFullYear(), weekdate.getMonth(), currentday-currentweeker+i).getDate()})
        for(var j=currentweeker; j<7; j++)
            weekmodel.set(j, {"day": new Date(weekdate.getFullYear(), weekdate.getMonth(), currentday-currentweeker+j).getDate()})
        externdate = new Date(weekdate.getFullYear(), weekdate.getMonth(), currentday-currentweeker)
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
    Rectangle{
        id: changeTolastMonth
        width: 480;height: 0;opacity:0.3
        gradient: Gradient {
            GradientStop {
                position: 0.770
                color: "#736d6d"
            }
            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        Text {
            id: changeText
            color: "black"
            text:  ("")
            font.pointSize: 18
            visible: false
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -8
            states: [
                State {
                    name: "nochange"
                    PropertyChanges {
                        target: changeText
                        text:  ("下拉选择上一周")
                        color:"black"
                    }
                },
                State {
                    name: "changetolast"
                    PropertyChanges {
                        target: changeText
                        text:  ("松开进入上一周")
                        color:"black"

                    }
                }

            ]
        }
    }

    ListModel{
        id:weekmodel
        ListElement{
            weeker:"周日"
            day: "00"
        }
        ListElement{
            weeker:"周一"
            day: "00"
        }
        ListElement{
            weeker:"周二"
            day: "00"
        }
        ListElement{
            weeker:"周三"
            day: "00"
        }
        ListElement{
            weeker:"周四"
            day: "00"
        }
        ListElement{
            weeker:"周五"
            day: "00"
        }
        ListElement{
            weeker:"周六"
            day: "00"
        }
        ListElement{
            weeker:"点击进入下一周"
            day: ""
        }
    }

    Component{
        id:weekdelegate
        Item{
            id: weekrectangle
            width: 480; height: 98
            Rectangle{
                width: 480; height: 98
                smooth: true
                opacity:0.1
                border.width: 2
                border.color: "black"
                radius:10
            }

            Row{
                id:weekRow
                anchors.verticalCenterOffset: 1
                anchors.left: parent.left
                anchors.leftMargin: 5
                spacing: 15
                anchors.verticalCenter: parent.verticalCenter
                Text{text: day; font.bold: true; font.pointSize: 25; anchors.verticalCenter: parent.verticalCenter;color:"black"}
                Text{id: weektext ; text: weeker; font.pointSize: 18; anchors.verticalCenter: parent.verticalCenter; anchors.verticalCenterOffset:2;color: "black"}

            }
            Text{id: weeklunartext;
                text: setlunarday(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index))
                color: "black"; anchors.right: parent.right;anchors.rightMargin: 20; anchors.verticalCenter: parent.verticalCenter ; font.pointSize: 18
            }

            Schedule.StickyModel{id: schedulemodel}
            Component.onCompleted: {
                if(index == 7){
                    weekrectangle.state = "changetonext"
                }
            }
            MouseArea{
                id: weekdayMousArea
                anchors.fill: parent
                onClicked: {
                    if(index <7){
                        externdate = new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index);
                        var component2 = Qt.createComponent("Schedule/ScheduleView.qml");
                        var Object = component2.createObject(weekview);
                        Object.backweekview.connect(weekviewitem.turnsmall);
//                        weekviewitem.turnbig.connect(Object.fromweekview);
                        weekviewitem.turnbig();
//                        weekviewitem.height = 854;
                    }
                }
            }
            states:[
                State {
                    name: "changetonext"
                    PropertyChanges {
                        target: weekdayMousArea
                        onClicked: {
                            changetoNextweek()
                            weekview.currentIndex = 0
                        }
                    }
                    PropertyChanges {
                        target: weektext
                        font.pointSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset:0
                    }
                    PropertyChanges {
                        target: weeklunartext
                        text: ""
                    }
                    AnchorChanges{
                        target: weektext
                        anchors.horizontalCenter: weekRow.horizontalCenter
                    }

                },State{
                    when:(LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)).substr(LunarData.getLen(LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)))/2 - 2,2) == "初一")&&
                         (LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)).substr(LunarData.getLen(LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)))/2 - 5,1) == "闰")
                    PropertyChanges {
                        target: weeklunartext
                        text: LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)).substr(LunarData.getLen(LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)))/2 - 5,3)
                    }
                },State {
                    when: LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)).substr(LunarData.getLen(LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)))/2 - 2,2) == "初一"
                    PropertyChanges {
                        target: weeklunartext
                        text: LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)).substr(LunarData.getLen(LunarData.GetLunarDateString(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index)))/2 - 4,2)
                    }
                },State {
                    when: day == "1"
                    PropertyChanges {
                        target: dateMonth
                        visible: true
                    }
                },State {
                    when:((new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index).getFullYear() == new Date().getFullYear())
                          && (new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index).getMonth() == new Date().getMonth())
                          &&(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index).getDate() == new Date().getDate()))
                    PropertyChanges {
                        target: dateMonth
                        visible:true

                    }
                    PropertyChanges {
                        target: dateMonthtext
                        text:"今天"

                    }
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation{ easing.type: Easing.InOutExpo;properties:"height,contenY,anchors.verticalCenterOffset";duration: 500;}
                }
            ]
            Rectangle{
                id: dateMonth
                width: dateMonthtext.width+20
                height: dateMonthtext.height+2
                color: "#af2c2c"
                radius: 3
                opacity:0.7
                //                gradient: Gradient {
                //                    GradientStop {
                //                        position: 0.07;
                //                        color: "#282d29";
                //                    }
                //                    GradientStop {
                //                        position: 0.98;
                //                        color: "#cbd7cc";
                //                    }
                //                    GradientStop {
                //                        position: 1.00;
                //                        color: "#ffffff";
                //                    }
                //                }
                smooth:true
                visible: false
                anchors.left: weekRow.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter; anchors.verticalCenterOffset: 5
                Text{
                    id: dateMonthtext;
                    text: new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index).getFullYear() +"-"+ (new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()+index).getMonth()+1)
                    color: "white"; font.pointSize: 18
                    anchors.centerIn: parent
                }
            }
        }
    }


    ListView{
        id: weekview
        width: 480; height:weekviewitem.height
        model: weekmodel
        delegate: weekdelegate
        clip: true
        boundsBehavior:Flickable.DragAndOvershootBounds
        highlightRangeMode: ListView.StrictlyEnforceRange
        Component.onCompleted: {
            setweek(externdate)
        }
        onCurrentIndexChanged: {
            if(weekview.currentIndex > 1)
                currentIndex = 1


        }
        onContentYChanged: {
            animateContenty.start()
            if(weekview.contentY > -20){
                changeText.state = ""
            }else if(weekview.contentY < -90){
                changeText.state = "changetolast"
                animateColor.start()
            }else if(weekview.contentY < -21){
                animateColor.stop()
                changeText.state = "nochange"
            }

            if(slideDistance > weekview.contentY)
                slideDistance = weekview.contentY
        }
        onMovementStarted: {
            changeText.visible = true
        }
        onMovementEnded: {
            changeText.visible = false
            if(slideDistance < -70)
                changetoLastweek()
            changeTolastMonth.state = ""
            slideDistance = 0
        }
    }
    PropertyAnimation {id: animateContenty; target: changeTolastMonth; properties: "height"; from: changeTolastMonth.height; to: 0-weekview.contentY; duration: 1}
    PropertyAnimation { id:animateColor;target: changeTolastMonth; properties: "color"; from: "lightgrey"; to: "black"; duration: 1000 }
}
