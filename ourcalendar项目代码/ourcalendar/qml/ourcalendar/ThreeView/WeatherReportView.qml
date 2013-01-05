
import QtQuick 1.0
import QtWebKit 1.0

import "weatherReport"

Rectangle{
    id: webBrowser/*
    //property string urlString : "http://www.weather.yahoo.com/"*/
    property string urlString : setting.gettingpureweathertring()
    property alias weatherstring: header.editUrl
    width: 480; height: 854
    //color: "#343434"
    opacity: 0.8
    Rectangle{
      width: 480; height: 854

        Image {
            id: weatherbackground
            opacity: 0.5
            source: imagesource
            anchors.fill:parent
        }
    }

    signal  deletewebbrowser()
    onDeletewebbrowser:
    {
        webBrowser.destroy()
    }
    FlickableWebView {
        id: webView
        url: webBrowser.urlString
        onProgressChanged: header.urlChanged = false
        anchors { top: headerSpace.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
    }

    Item { id: headerSpace; width: parent.width; height: 85;opacity: 0 }

    Header {
        id: header
        editUrl: webBrowser.urlString
        width: headerSpace.width; height: headerSpace.height
        Component.onCompleted: {
            header. backclicked.connect(webBrowser.deletewebbrowser)
            console.log(weatherstring)
        }

    }

    ScrollBar {
        scrollArea: webView; width: 8
        anchors { right: parent.right; top: header.bottom; bottom: parent.bottom }
    }

    ScrollBar {
        scrollArea: webView; height: 8; orientation: Qt.Horizontal
        anchors { right: parent.right; rightMargin: 8; left: parent.left; bottom: parent.bottom }
    }

    Image {
        id: container
        property bool on: true
        source: "./weatherReport/pics/busy.png"; visible: container.on
        fillMode:Image.PreserveAspectFit
        anchors.centerIn: parent
        NumberAnimation on rotation { running: container.on; from: 0; to: 360; loops: Animation.Infinite; duration: 1200 }
    }
    Text{
           id:errortext
           text: "网络错误或信号弱..."
           anchors.centerIn: parent
           visible: false
           font.pointSize: 20
    }
}
