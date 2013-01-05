// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id:settingrectangle
    property string mystring: ""
    width: 480
    height: 854
    color: "lightgrey"
    Item{
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
        }
    }

    Image {
        id:themeImage
        width:480;height:854
        smooth: true
        source: imagesource
    }
    Rectangle{
        anchors{top:parent.top ;topMargin: 85}
        width:480
        height: 685
        opacity: 0.5
        color: "#535252"
    }


    Item{
        width:460
        height: 141
        anchors{top:parent.top;topMargin: 145}
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            opacity: 0.4
            width:460
            height: 121
           // color:"black"
            border.color: "black"
            border.width: 1
            anchors.centerIn: parent
            radius: 10
        }
        Text {
            id: weatherwebsiteText
            text: "设置天气预报更新源"
            color:"black"
            font.pointSize: 17
            font.family: "Nokia Sans"
            anchors{left: parent.left;top:parent.top;topMargin: -35}
        }
        Text {
            id: weatherwebText2
            text: "Accuweather"
            color:"black"
            font.pointSize: 16
            font.family: "Nokia Sans"
            anchors{left: parent.left;leftMargin: 30;top:parent.top;topMargin: 25}
        }
        Rectangle{
            id:wearec1;width: 20;height: 20;
            anchors{left: parent.left;leftMargin: 410;top:parent.top;topMargin: 31}
            border.color: "black";border.width: 1;opacity: 0.77
            Image {
                id: xuanzhongimage
                source: "choose.ico"
                anchors.fill: parent
                smooth: true
                visible: setting.gettingweatherstring()=="accu" ? true : false
            }
        }
            MouseArea{
                id:accumousearea
                anchors.fill: parent
                enabled: xuanzhongimage.visible==true?false:true
                onClicked: {
                    console.log(1)
                    xuanzhongimage2.visible=false
                    xuanzhongimage.visible=true
                    accumousearea.enabled=false
                    yahoomousearea.enabled=true
                    setting.savingweatherstring("accu")
                    console.log(setting.gettingweatherstring())
                    setting.savingpureweatherstring("http://m.accuweather.com/")
                }
            }

        Text {
            id: weatherwebText3
            text: "Yahooweather"
            color:"black"
            font.pointSize: 16
            font.family: "Nokia Sans"
            anchors{left: parent.left;top:parent.top;leftMargin: 30;topMargin: 85}
        }
        Rectangle{
            id:wearec2;width: 20;height: 20;
            anchors{left: parent.left;leftMargin: 410;top:parent.top;topMargin: 91}
            border.color: "black";border.width: 1;opacity: 0.7
            Image {
                id: xuanzhongimage2
                source: "choose.ico"
                anchors.fill: parent
                visible:setting.gettingweatherstring()=="yahoo" ? true : false
                smooth: true
            }
        }
            MouseArea{
                id:yahoomousearea
                anchors.fill: parent
                enabled: xuanzhongimage2.visible==true?false:true
                onClicked: {
                    console.log(2)
                    xuanzhongimage2.visible=true
                    xuanzhongimage.visible=false
                    accumousearea.enabled=true
                    yahoomousearea.enabled=false
                    setting.savingweatherstring("yahoo")
                    console.log(setting.gettingweatherstring())
                    setting.savingpureweatherstring("http://www.weather.yahoo.com/")
                }
            }



        Rectangle{
            width: 460
            height: 1
            color: "black"
            anchors.top: parent.top
            anchors.topMargin:70

        }
    }
    Item{
        width:460
        height: 283
        anchors{top:parent.top;topMargin: 376}
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            width:460
            height:283
            border.color: "black"
            border.width: 1
            anchors.centerIn: parent
            radius: 10
            opacity: 0.4

        }

        Text {
            id: settingtext
            text: "基本设置"
            color:"black"
            font.pointSize: 17
            anchors{left: parent.left;top:parent.top;topMargin: -45}
        }
        Item{
            id:themeitem
            width: 460; height: 70 ;
            anchors{left: parent.left;top:parent.top}
            Rectangle{
                id:clickrectangle
                width:460
                height:70
                border.color: "black"
                border.width: 1
                anchors.centerIn: parent
                radius: 10
                color:"black"
                opacity: 0.4
                visible: false

            }
            Text {
                id: themeText
                text: "主题设置"
                color:"black"
                font.pointSize: 16
                font.family: "Nokia Sans"
                anchors{left: parent.left;leftMargin: 30;top:parent.top;topMargin: 18}
            }
            MouseArea{
                id:thememouserarea
                anchors.fill: parent
                onClicked: {
                    settingrectangle.state="themechoosed"
                    savetheme()
                    settingrectangle.menudisappear()
                    var themesetting=Qt.createComponent("ThemeView.qml")
                    var themeObject=themesetting.createObject(settingrectangle)
                    settingrectangle.destroythemeview.connect(themeObject.themeviewdisappear)
                    themeObject.y=1055
                }
            }
            states:State {
                name: "themesetting"
                when: thememouserarea.pressed
                PropertyChanges {target:themeText;color:"#af2c2c" }
                PropertyChanges {target:clickrectangle;visible:true}

            }
        }
        Item{
            id:googlemap
            width: 430; height: 70 ;
            anchors{left: parent.left;leftMargin: 30;top:parent.top;topMargin: 88}
            Text {
                id: googlemaptext
                text: "启用谷歌地图服务"
                color:"black"
                font.pointSize: 16
                font.family: "Nokia Sans"
                anchors{left: parent.left;top:parent.top}
            }
            Rectangle{
                id:googlerectangle;width: 20;height: 20;
                anchors{left: parent.left;leftMargin: 380;top:parent.top;topMargin: 6}
                border.color: "black";border.width: 1;opacity: 0.7
                Image {
                    id: xuanzhongimage3
                    source: "choose.ico"
                    anchors.fill: parent
                    smooth: true
                    visible: setting.gettinggooglestring()=="true" ? true : false
                }
               }
                MouseArea{
                    id:googlemousearea
                    anchors.fill: parent
                    onClicked: {
                        if(xuanzhongimage3.visible==false){
                            console.log("hello")
                            xuanzhongimage3.visible=true
                            setting.savinggooglestring("true")
                        }
                        else{
                            console.log("iiiiii")
                            xuanzhongimage3.visible=false
                            setting.savinggooglestring("false")

                        }
                    }
                }


        }
        Item{
            id:saveflow
            width: 430; height: 70 ;
            anchors{left: parent.left;leftMargin: 30;top:parent.top;topMargin: 160}
            Text {
                id: saveflowtext
                text: "启用节约流量模式"
                color:"black"
                font.pointSize: 16
                font.family: "Nokia Sans"
                anchors{left: parent.left;top:parent.top}
            }
            Rectangle{
                id:saveflowrectangle;width: 20;height: 20;
                anchors{left: parent.left;leftMargin: 380;top:parent.top;topMargin: 6}
                border.color: "black";border.width: 1;opacity: 0.7
                Image {
                    id: xuanzhongimage4
                    source: "choose.ico"
                    anchors.fill: parent
                    smooth: true
                    visible: setting.gettingsaveflowstring() == "true" ? true : false

                }
            }
            MouseArea{
                id:flowmousearea
                anchors.fill: parent
                onClicked: {
                    if(xuanzhongimage4.visible==false){
                        console.log("hello")
                        xuanzhongimage4.visible=true
                        setting.savingsaveflowstring("true")

                    }
                    else{
                        console.log("iiiiii")
                        xuanzhongimage4.visible=false
                        setting.savingsaveflowstring("false")

                    }

                }
            }
        }
        Item{
            id:opinionitem
            width: 460; height: 70 ;
            anchors{left: parent.left;top:parent.top;topMargin: 214}
            Rectangle{
                id:opinionclick
                width:460
                height:70
                border.color: "black"
                border.width: 1
                anchors.centerIn: parent
                radius: 10
                color:"black"
                opacity: 0.4
                visible: false

            }
            Text {
                id: opinionText
                text: "意见反馈"
                color:"black"
                font.pointSize: 16
                font.family: "Nokia Sans"
                anchors{left: parent.left;leftMargin: 30;top:parent.top;topMargin: 18}
            }
            MouseArea{
                id:opinionmousearea
                anchors.fill: parent
                onClicked: {
                    var Opinionview=Qt.createComponent("OpinionView.qml")
                    var OpinionObject=Opinionview.createObject(settingrectangle)
                }
            }
            states:State {
                name: "opinion"
                when: opinionmousearea.pressed
                PropertyChanges {target:opinionText;color:"#af2c2c" }
                PropertyChanges {target:opinionclick;visible:true}

            }
        }


        Rectangle{
            width: 460
            height: 1
            color: "black"
            anchors.top: parent.top
            anchors.topMargin:70
        }
        Rectangle{
            width: 460
            height: 1
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 141
        }
        Rectangle{
            width: 460
            height: 1
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 212
        }
    }
    Item{
        anchors.horizontalCenter: parent.horizontalCenter
        id:topitem
        width: 480
        height: 85
        anchors.top: parent.top
        Rectangle{
            width: 480
            height: 85
            color: "black"
            opacity: 0.7
            anchors.centerIn: parent

        } Text{
            id:settingText
            text:"系统设置"
            font.pointSize: 20
            color:"white"
            anchors.centerIn: parent
            font.family: "Nokia Sans"
        }
        Item{
            id:backitem
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
                color:"white"
                font.pointSize: 17
                anchors.centerIn: parent
                font.family: "Nokia Sans"
            }
            MouseArea{
                id:backmousearea
                anchors.fill: parent
                onClicked: {
                    settingrectangle.destroy()
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

    }
    Item{
        id:bottomitem
        width: 480
        height: 85
        anchors.bottom: parent.bottom
        Rectangle{
            width: 480
            height: 85
            color: "black"
            opacity: 0.7
            anchors.centerIn: parent
        }
        Item{
            id:backitembottom
            width: 119
            height:56
            visible: false
            anchors{left: parent.left;leftMargin: 10;top:parent.top;topMargin: 17}
            Rectangle{
                id:backrectanglebottom
                opacity: 0.3
                width: 119
                height:56
                border.width: 1
                border.color: "black"
                anchors.centerIn: parent
                gradient: Gradient {
                    GradientStop {
                        id:backcolor1bottom
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:backcolor2bottom
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }
            Text {
                id: backtextbottom
                text: "返回"
                color:"white"
                font.pointSize: 17
                anchors.centerIn: parent
                font.family: "Nokia Sans"
            }
            MouseArea{
                id:backmouseareabottom
                anchors.fill: parent
                onClicked: {
                    settingrectangle.destroy()
                }
            }
            states:State {
                name: "backrctanglebottom"
                when: backmouseareabottom.pressed
                PropertyChanges {target:backcolor1bottom;color:"black" }
                PropertyChanges {target:backcolor2bottom;color:"black" }
                PropertyChanges {target:backtextbottom; color:"#af2c2c"}

            }
        }



        Item{
            id:okitem
            width: 119
            height:56
            visible: false
            anchors{right: parent.right;rightMargin: 10;top:parent.top;topMargin: 17}
            Rectangle{
                id:okrectangle
                opacity: 0.3
                width: 119
                height:56
                border.width: 1
                border.color: "black"
                anchors.centerIn: parent
                gradient: Gradient {
                    GradientStop {
                        id:okcolor1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:okcolor2
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }
            Text {
                id: oktext
                text: "确定"
                color:"white"
                font.pointSize: 17
                anchors.centerIn: parent
                font.family: "Nokia Sans"

            }
            MouseArea{
                id:okmousearea
                anchors.fill: parent
                onClicked: {
                    settingsource()
                    settingrectangle.okchoose()
                    settingrectangle.destroy()
                }
            }
            states:State {
                name: "okrctangle"
                when: okmousearea.pressed
                PropertyChanges {target:okcolor1;color:"black" }
                PropertyChanges {target:okcolor2;color:"black" }
                PropertyChanges {target:oktext; color:"#af2c2c"}

            }

        }
    }
    signal destroythemeview()
    signal okchoose()
    signal canclechoose()
    function settingsource(){
        console.log(555555555)
        calendartheme.savingstring(imagesource)
    }
    function savetheme(){
        mystring=imagesource
        console.log(mystring)
    }
    signal menudisappear()



    states: [
        State {
            name: "themechoosed"
            PropertyChanges {
                target: settingrectangle
                y:-1623
            }
            PropertyChanges {
                target: backitembottom
                visible: true

            }
            PropertyChanges{
                target: backmouseareabottom
                onClicked:{
                    settingrectangle.state=""
                    imagesource=mystring
                    settingrectangle.destroythemeview()
                    settingrectangle.canclechoose()
                }
            }
            PropertyChanges{
                target: okitem
                visible:true
            }
            PropertyChanges{
                target:themeImage
                fillMode:Image.TileVertically

            }
        }
    ]
    transitions: [
        Transition {
            PropertyAnimation{target:settingrectangle; property: "y"; easing.type: Easing.InOutExpo;duration: 0}
        }
    ]


}
