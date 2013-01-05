// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
Item{
    id: menutoprectangle
    width: 130
    height:320
    z:2
    NumberAnimation on x { easing.type: Easing.InOutQuart;from:480;to:360;duration:600}
    NumberAnimation on y { easing.type: Easing.InOutQuart;from:447;to:447;duration:600}
    NumberAnimation on opacity {easing.type: Easing.InOutQuart;from:0;to:0.8;duration:900}
    signal fullRectangleClicked2
    onFullRectangleClicked2: fullrectangle.destroy()
    signal menuclicked
    signal themeholded
    signal themeokchoosed
    signal changeopacity
    signal backtonormalfullrectangle
    function menudisappear()
    {
        menutoprectangle.destroy()
    }
    function menuback()
    {
        menutoprectangle.y=447
        menutoprectangle.backtonormalfullrectangle()
    }
    onThemeholded: {menutoprectangle.y=854;console.log(1);menutoprectangle.changeopacity()}
    ListModel{
        id:menumodel
        ListElement{
            menu:"节日详情"
            icon: "fest.ico"
        }
        ListElement{
            menu:"天气预报"
            icon: "weather.ico"
        }
        ListElement{
            menu:"系统设置"
            icon: "shezhi.ico"
        }
        ListElement{
            menu:"检查更新"
            icon: "update.ico"
        }
        ListElement{
            menu:"关于我们"
            icon: "About_us.ico"
        }
        ListElement{
            menu:"退出"
            icon: "exit.ico"
        }
    }
    Component{
        id:menudelegate
//        Item {
//            //color: "#c6cdcf"
//            opacity: 0
//            width: 130
//            height:320
//            //radius: 1
//            Image{
//                width: parent.width
//                height: parent.height
//                source: imagesource
//            }


            Item{
                id:menurectangle
                width: 120
                height: 80
                Rectangle{
                    opacity: 0.8
                    color: "#9fb3c6"
                    smooth: true
                    width: 120
                    height: 80
                    border.width: 1
                    border.color: "black"
                    radius: 5
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
                Row{
                    anchors{left:parent.left;leftMargin: 4;top:parent.top;topMargin: 28}
                    spacing: 7
                    Image{
                        y:-3
                        width: 30
                        height: 30
                        source: icon
                        smooth: true
                    }

                    Text {
                        id: menutext
                        text: menu
                        y:3
                        font.pointSize: 15
                        color: "#ffffff"
                        font.family: "Nokia Sans"
                    }

                }
                states: [
                    State {
                        name: "exit"
                        PropertyChanges {
                            target: menutoprectangle
                            x:480
                        }
                    },
                    State{
                        name:"color"
                        when:menumousearea.pressed
                        PropertyChanges{
                            target:menutext
                            color:"#af2c2c"
                        }
                    }
                ]
                MouseArea{
                    id:menumousearea
                    anchors.fill: parent
                    onClicked: {
                        if(index==0)
                        {   console.log(11111)
                            var festival=Qt.createComponent("FestivalMonthView.qml")
                            var Festivalmonth=festival.createObject(menutoprectangle)
                            Festivalmonth.x=-360
                            Festivalmonth.y=-447
                            menutoprectangle.opacity=1
                        }
                        else if(index==1)
                        {
                            var weatherReport=Qt.createComponent("WeatherReportView.qml")
                            var weatherObject=weatherReport.createObject(menutoprectangle)
                            weatherObject.x=-360
                            weatherObject.y=-447
                            menutoprectangle.opacity=1
                        }
                        else if(index==2)
                        {
                            var Settings=Qt.createComponent("SettingView.qml")
                            var SettingsObject=Settings.createObject(menutoprectangle)
                            SettingsObject.x=-360
                            SettingsObject.y=-447
                            SettingsObject.menudisappear.connect(menutoprectangle.themeholded)
                            SettingsObject.okchoose.connect(menutoprectangle.themeokchoosed)
                            SettingsObject.canclechoose.connect(menutoprectangle.menuback)
                            menutoprectangle.opacity=1

                        }
                        else if(index==3)
                        {
                            var Update=Qt.createComponent("UpdateView.qml")
                            var UpdateObject=Update.createObject(menutoprectangle)
                            UpdateObject.x=-360
                            UpdateObject.y=-447
                            //                        UpdateObject.menudisappear.connect(menutoprectangle.themeholded)
                            //                        UpdateObject.okchoose.connect(menutoprectangle.themeokchoosed)
                            //                        UpdateObject.canclechoose.connect(menutoprectangle.menuback)
                            menutoprectangle.opacity=1

                        }
                        else if(index==4)
                        {
                            var AboutUs=Qt.createComponent("AboutUsView.qml")
                            var AboutUSObject=AboutUs.createObject(menutoprectangle)
                            AboutUSObject.x=-360
                            AboutUSObject.y=-447
                            menutoprectangle.opacity=1

                        }
                        else if(index==5){
                            var Quitrectangle=Qt.createComponent("../MenuFullRectangle.qml")
                            var QuitrectangleObject=Quitrectangle.createObject(menutoprectangle)
                            QuitrectangleObject.x=-360
                            QuitrectangleObject.y=-447
                            var Quit=Qt.createComponent("QuitView.qml")
                            var QuitObject=Quit.createObject(menutoprectangle)
                            menutoprectangle.opacity=1
                            QuitObject.x=-300
                            QuitObject.y=-300
                            QuitObject.cancelclicked.connect(QuitrectangleObject. menufullRectangleClicked2)
                        }

                    }
                }
            }
        //}
    }
    ListView{
        id:menuview
        anchors.fill: parent
        clip:true
        model: menumodel
        delegate: menudelegate
        // interactive: false
    }


}
