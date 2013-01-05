
// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import "lunardata.js" as LunarData
import "ThreeView"

Rectangle {
    id: toprectangle; width: 480; height: 854; color: "#000000";
    property string mainview: ""

    property date basedate: new Date()
    property alias externdate: toprectangle.basedate
    property alias imagesource: mainImage.source
    property alias externviewsource: threeview.source
    signal menudestroy()
    signal fullrectangledestroy()
    signal menutofullrectangle
    signal menutofullrectangle2
    function changefullrectangle(){
        toprectangle.menutofullrectangle()
    }
    function changefullrectangle2(){
        toprectangle.menutofullrectangle2()
    }
    function backtonormal(){
        fuction4.state=""
        toprectangle.menudestroy()
        toprectangle.fullrectangledestroy()
        function1mousearea.enabled=true
        function2mousearea.enabled=true
        function3mousearea.enabled=true
    }
    function backtotoday(){
        externdate = new Date()

        var tenviewsourc = new String(externviewsource);
        console.log(tenviewsourc)
        console.log(tenviewsourc.substr(LunarData.getLen(tenviewsourc) - 13, 13))
        if (tenviewsourc.substr(LunarData.getLen(tenviewsourc) - 13, 13) == "MonthView.qml"){
            externviewsource = ""
            datedisplay.state = ""
            externviewsource = "ThreeView/MonthView.qml"
        }else if(tenviewsourc.substr(LunarData.getLen(tenviewsourc) - 12, 12)  == "WeekView.qml"){
            externviewsource = ""
            externviewsource = "ThreeView/WeekView.qml"
        }else if(tenviewsourc.substr(LunarData.getLen(tenviewsourc) - 11, 11)  == "DayView.qml"){
            externviewsource = ""
            datedisplay.state = ""
            externviewsource = "ThreeView/DayView.qml"
        }
    }
    Image {
        id:mainImage
        Rectangle{
            anchors{top:parent.top;topMargin: 85}
            width:480
            height: 684
            color:"lightgrey"
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#323333";
                }
                GradientStop {
                    position: 0.11;
                    color: "#d8d9d9";
                }
                GradientStop {
                    position: 0.18;
                    color: "#f2f7f7";
                }
                GradientStop {
                    position: 0.84;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 0.91;
                    color: "#d8d9d9";
                }
                GradientStop {
                    position: 1.00;
                    color: "#080908";
                }
            }
            opacity: 0.8
        }
        anchors.fill: parent
        smooth: true
        source: calendartheme.gettingstring()
    }
    Rectangle{
        width: 480
        height:85
        color:"black"
        opacity: 0.5
    }
        Row{
            id: topmenu
            anchors.top: parent.top; opacity: 0.8; anchors.left: parent.left;anchors.leftMargin: 10
            Button{
                id: backtoday;height: 56; y:15 ;x:20;width: 119
                Rectangle{
                    border.color: "black"
                    border.width: 1
                    height: parent.height;width: parent.width; anchors.centerIn: parent;opacity: 0.3
                    gradient: Gradient {
                        GradientStop {
                            id:todaycolor1
                            position: 0.00;
                            color: "#242525";
                        }
                        GradientStop {
                            id:todaycolor2
                            position: 1.00;
                            color: "#040505";
                        }
                    }
                }     

               smooth: true
                Text {
                    id:backtext
                    anchors.centerIn: parent
                    text: "回今天"
                    font.family: "Nokia Sans"
                    color: "#ffffff"
                    font.pointSize: 17
                }
                states: [
                    State {
                        when:backmousearea.pressed
                        PropertyChanges {
                            target:todaycolor1
                            color:"#000000"
                        }
                        PropertyChanges {
                            target: todaycolor2
                            color:"#000000"
                        }
                        PropertyChanges{
                            target:backtext
                            color: "#af2c2c"
                        }

                    }
                ]
                MouseArea{
                    id:backmousearea
                    anchors.fill: parent
                    onClicked: {
                        backtotoday()
                    }
                }
            }
            Button{
                id: datedisplay
                width: 220;
                Text {
                    id: showpartedate
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -10
                    text: externdate.getFullYear()+"年"+(externdate.getMonth()+1)+"月"
                    color: "#ffffff"
                    font.pointSize: 25
                }
                Text {
                    id: showpartelunardate
                    anchors.top: showpartedate.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -3
                    text: LunarData.GetLunarDateString(externdate).substr(0,LunarData.getLen(LunarData.GetLunarDateString(externdate))/2 - 2)
                    color: "#ffffff"
                    font.pointSize: 16
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        var component1 = Qt.createComponent("MenuFullRectangle.qml");
                        var FullRectangle = component1.createObject(toprectangle);
                        var component2 = Qt.createComponent("Component/datemenu/DateMenu.qml");
                        var Object = component2.createObject(toprectangle);
                        Object.x=60;
                        Object.rectangelClicked.connect(FullRectangle.menufullRectangleClicked2)

                    }
                }

                states: State {
                    name: "showfulldate"
                    PropertyChanges {
                        target: showpartelunardate
                        text:  LunarData.GetLunarDateString(externdate)
                    }
                }
            }
        }

    Rectangle{
        height:85
        color:"black";opacity: 0.5;anchors.bottom: parent.bottom ;anchors.horizontalCenter: parent.horizontalCenter;width:480
    }
    Row{
        id: functionmenu;opacity: 1;anchors.bottom: parent.bottom ;anchors.horizontalCenter: parent.horizontalCenter; width:480
        Button{
            id: function1;
            smooth: true
            Rectangle{
                id:fuction1a;anchors.centerIn: parent;width: parent.width;height:parent.height ;opacity:0.5
                border.color: "black"
                border.width: 1
                gradient: Gradient {
                    GradientStop {
                        id:fun1color1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:fun1color2
                        position: 1.00;
                        color: "#040505";
                    }
                }

            }
            Text {
                id:function1text
                anchors.centerIn: parent
                text: "日"
                font.family: "Nokia Sans"
                color: "#ffffff"
                font.pointSize: 18
            }
            states: [
                State {
                    when:function1mousearea.pressed
//                    PropertyChanges {
//                        target:fun1color1
//                        color:"#040505"
//                    }
//                    PropertyChanges {
//                        target: fun1color2
//                        color:"#242525"
//                    }
                    PropertyChanges {
                            target: fun1color2
                            position: 0.00;
                            color: "#5f6060";
                        }
                       PropertyChanges {
                            target:fun1color1
                            position: 1.00;
                            color: "#171818";
                        }

                    PropertyChanges{
                        target:function1text
                        color: "#af2c2c"
                    }
                }
            ]
            MouseArea{
                id:function1mousearea
                anchors.fill: parent
                onClicked: {
                    threeview.source = "ThreeView/DayView.qml"
                    datedisplay.state = "showfulldate"
                }
            }
        }
        Button{
            id: function2;
            smooth: true
            Rectangle{
                id:fuction2a;width: parent.width;height:parent.height ;opacity:0.5
                border.color: "black"
                border.width: 1
                gradient: Gradient {
                    GradientStop {
                        id:fun2color1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:fun2color2
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }

            Text {
                id:function2text
                anchors.centerIn: parent
                text: "月"
                font.family: "Nokia Sans"
                color: "#ffffff"
                font.pointSize: 18
            }
            states: [
                State {
                    when:function2mousearea.pressed
                    PropertyChanges {
                            target: fun2color2
                            position: 0.00;
                            color: "#5f6060";
                        }
                       PropertyChanges {
                            target:fun2color1
                            position: 1.00;
                            color: "#171818";
                        }
                    PropertyChanges{
                        target:function2text
                        color: "#af2c2c"
                    }

                }
            ]
            MouseArea{
                id:function2mousearea
                anchors.fill: parent
                onClicked: {
                    threeview.source = "ThreeView/MonthView.qml"
                    datedisplay.state = ""
                }
            }
        }
        Button{
            id: function3;
            smooth: true
            Rectangle{
                id:fuction3a;width: parent.width;height:parent.height ;opacity:0.5
                border.color: "black"
                border.width: 1
                gradient: Gradient {
                    GradientStop {
                        id:fun3color1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:fun3color2
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }
            Text{
                id:function3text
                anchors.centerIn: parent
                text:"周"
                font.family: "Nokia Sans"

                color: "#ffffff"
                font.pointSize: 18
            }
            states: [
                State {
                    when:function3mousearea.pressed
                    PropertyChanges {
                            target: fun3color2
                            position: 0.00;
                            color: "#5f6060";
                        }
                       PropertyChanges {
                            target:fun3color1
                            position: 1.00;
                            color: "#171818";
                        }
                    PropertyChanges{
                        target:function3text
                        color: "#af2c2c"
                    }

                }
            ]
            MouseArea{
                id:function3mousearea
                anchors.fill: parent
                onClicked: {
                    threeview.source="ThreeView/WeekView.qml"
                    datedisplay.state = ""

                }
            }
        }

        Button{
            id:fuction4;
            smooth: true
            Rectangle{
                id:fuction4a;width: parent.width;height:parent.height ;opacity:0.5
                gradient: Gradient {
                    GradientStop {
                        id:fun4color1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:fun4color2
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }
            Text{
                id:function4text
                anchors.centerIn: parent
                text:"更多"
                font.family: "Nokia Sans"
                color:"white"
                font.pointSize: 17
            }
            states: [
                State {
                    name:"pressed"
                    PropertyChanges {
                            target: fun4color2
                            position: 0.00;
                            color: "#5f6060";
                        }
                       PropertyChanges {
                            target:fun4color1
                            position: 1.00;
                            color: "#171818";
                        }
                    PropertyChanges{
                        target:function4text
                        color: "#af2c2c"
                    }
                    PropertyChanges {
                        target: function4mousearea
                        onClicked:{
                            fuction4.state=""
                            toprectangle.menudestroy()
                            toprectangle.fullrectangledestroy()
                            function1mousearea.enabled=true
                            function2mousearea.enabled=true
                            function3mousearea.enabled=true

                        }
                    }

                }

            ]
            MouseArea{
                id:function4mousearea
                anchors.fill: parent
                onClicked: {
                    console.log(fuction4.state)
                    if(fuction4.state=="")
                    {
                        fuction4.state="pressed"
                        var menuview=Qt.createComponent("ThreeView/MenuView.qml")
                        var menuObject=menuview.createObject(toprectangle)
                        var fullrectangle=Qt.createComponent("FullRectangle.qml")
                        var fullObject=fullrectangle.createObject(toprectangle)
                        toprectangle.menudestroy.connect(menuObject.menudisappear)
                        toprectangle.fullrectangledestroy.connect(fullObject.disappearfullrectangle)
                        toprectangle.menutofullrectangle.connect(fullObject.changingopacity)
                        toprectangle.menutofullrectangle2.connect(fullObject.changetonormal)
                        menuObject.backtonormalfullrectangle.connect(toprectangle.changefullrectangle2)
                        menuObject.themeokchoosed.connect(toprectangle.backtonormal)
                        menuObject.changeopacity.connect(toprectangle.changefullrectangle)
                        function1mousearea.enabled=false
                        function2mousearea.enabled=false
                        function3mousearea.enabled=false
                    }

                }
            }
        }
    }
    Loader{id: threeview; y:85 ;source: mainview}
    Loader{id: fullrectangle;source:""}
    Loader{id: menuview;source:""}
    Component.onCompleted: {
        mainview = "ThreeView/MonthView.qml"
        if(calendartheme.gettingstring()=="no" )
        {
        mainImage.source="2.png"
        calendartheme.savingstring(mainImage.source)
       }
        console.log(setting.gettinggooglestring())
        console.log(setting.gettingweatherstring())
        console.log(setting.gettingsaveflowstring())
        console.log(setting.gettingpureweathertring())
       // setting.savingpureweatherstring("wwww")
        if(setting.gettinggooglestring()=="no")
           setting.savinggooglestring("true")
        if(setting.gettingweatherstring()=="no")
            setting.savingweatherstring("accu")
        if(setting.gettingpureweathertring()=="no")
            setting.savingpureweatherstring("http://m.accuweather.com")
        if(setting.gettingsaveflowstring()=="no")
            setting.savingsaveflowstring("true")

    }
    Connections{
        target: threeview.item
        ignoreUnknownSignals: true
        onDateItemchoosed: {
            datedisplay.state = "showfulldate"
            threeview.source = "ThreeView/DayView.qml"
        }
        onTurnbig: {threeview.y = 0;console.log("IKLKL")}
        onTurnsmall: threeview.y = 85;
    }
}


