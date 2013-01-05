import QtQuick 1.1
import "../lunardata.js" as LunarData
Item{
    id:toprectangle
    width: 480
    height: 367
    function themeviewdisappear()
    {
        toprectangle.destroy()
    }

    ListModel{
        id:imagemodel
        ListElement{
            sourceimage:"../1.png"
        }
        ListElement{
            sourceimage:"../2.png"
        }
        ListElement{
            sourceimage:"../3.png"
        }
        ListElement{
            sourceimage:"../4.png"
        }
        ListElement{
            sourceimage:"../5.png"
        }
        ListElement{
            sourceimage:"../6.png"
        }
        ListElement{
            sourceimage:"../7.png"
        }
//        ListElement{
//            sourceimage:"../8.png"
//        }
//        ListElement{
//            sourceimage:"../9.png"
//        }
//        ListElement{
//            sourceimage:"../10.png"
//        }
//        ListElement{
//            sourceimage:"../33.png"
//        }

    }
    Component{
        id:imagedelegate
        Image{
            id:themeimage
            source: sourceimage
            width: 125
            height: 120
            scale: ListView.isCurrentItem?1.2:1
        }

    }

    ListView{

        id:imageview
        y:367
        x:10
        width: parent.width-10
        height: 120
        spacing: 30
        model:imagemodel
        delegate: imagedelegate
        orientation: ListView.Horizontal
        highlightRangeMode: ListView.StrictlyEnforceRange
        //highlightFollowsCurrentItem:true
        currentIndex:(calendartheme.gettingstring().substr(LunarData.getLen(calendartheme.gettingstring())-5,1))-1
        onCurrentIndexChanged: {
//            console.log("AAAA"+imageview.currentItem.source)'[
                imagesource=imageview.currentItem.source
        }
        preferredHighlightBegin:165
        preferredHighlightEnd:165
        //        highlightMoveDuration: 500
        //        flickDeceleration: 5000
    }
    Rectangle{
        id:highlightrectangle
        width: parent.width
        height: 160
        y:347
        //color:"#84a09e"
        color: "black"
        opacity: 0.2
        MouseArea{
            width: 480
            height: 40
            anchors.bottom: parent.bottom
            onClicked: {
                console.log("clicked")
            }
        }
    }

}
