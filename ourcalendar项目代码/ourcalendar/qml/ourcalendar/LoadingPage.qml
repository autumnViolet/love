// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
PageStackWindow {
    id: appWindow
    initialPage: loadingpage
    showStatusBar: false
    showToolBar:false
    NumberAnimation on opacity{from:0;to:1;duration: 1500}
    Timer{
        id:loadingTimer
        running:true
        interval: 3000
        onTriggered: {
            loadingpage.state="disappear"
            loadingpagedestroy.running=true
            loading.source="main.qml"
        }
    }
    Loader{id:loading;source: ""}
    Page{
        id:mainpage
        orientationLock: PageOrientation.LockPortrait
        AnimatedImage{
            id:loadingpage
            source: "e.gif"
            fillMode: Image.Stretch
            states: [
                State {
                    name: "disappear"
                    PropertyChanges {
                        target:loadingpage
                        opacity:0
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation{target: loadingpage;property: "opacity"; easing.type: Easing.InOutQuad;duration: 100;}
                }
            ]
            Timer{
                id:loadingpagedestroy
                running: false
                interval: 3000
                onTriggered: {
                    loadingpage.destroy()
                }
            }
        }
    }

}





//import QtQuick 1.1

//Rectangle {
//    id:loadingrectangle
//    width: 480
//    height: 854
//    y:-50
//    scale: 0.6
//    NumberAnimation on opacity{from:0;to:1;duration: 1500}
//    Timer{
//        id:loadingTimer
//        running:true
//        interval: 3000
//        onTriggered: {
//            loadingpage.state="disappear"
//            loadingpagedestroy.running=true
//            loading.source="main.qml"

//        }
//    }
//    Loader{id:loading;source: ""}
//    Image{
//        id:loadingpage
//        source: "kaiji.jpg"
//        fillMode: Image.Stretch
//        sourceSize.width: 480
//        sourceSize.height: 854

//        states: [
//            State {
//                name: "disappear"
//                PropertyChanges {
//                    target:loadingpage
//                    opacity:0
//                }
//            }
//        ]
//        transitions: [
//            Transition {
//                PropertyAnimation{target: loadingpage;property: "opacity"; easing.type: Easing.InOutQuad;duration: 100;}
//            }
//        ]
//        Timer{
//            id:loadingpagedestroy
//            running: false
//            interval: 3000
//            onTriggered: {
//                loadingpage.destroy()
//            }
//        }
//    }
//}

