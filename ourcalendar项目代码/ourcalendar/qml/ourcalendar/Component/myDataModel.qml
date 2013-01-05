// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: datarectangle
    width: 150
    height: 20


//    property int i: 1

//    XmlListModel {
//        id: feedModel
//        source: "feed.xml"
//        query: "/rss/channel"

//        XmlRole { name: "name"; query: "item["+i+"]/name/string()" }
//        XmlRole { name: "shortt";  query: "item["+i+"]/shortt/string()"}
//        XmlRole { name: "longg"; query: "item["+i+"]/longg/string()" }

//    }
//    Component{
//        id:w
//        Column {
//            Text { text: "title:" + name }
//            Text { text: "link: $" + shortt}
//            //            Text { text: "pubDate: $" + longg }
//        }
//        //        MouseArea{

//        //        }
//    }
//    ListView {
//        id:q
//        width:150
//        height:20
//        anchors.centerIn: parent
//        model: feedModel
//        delegate:w
//        snapMode: ListView.SnapOneItem
//        highlightRangeMode: ListView.StrictlyEnforceRange
//        boundsBehavior:Flickable.DragAndOvershootBounds
//        preferredHighlightBegin: q.height-20
//        preferredHighlightEnd: q.height+20
//    }
}
