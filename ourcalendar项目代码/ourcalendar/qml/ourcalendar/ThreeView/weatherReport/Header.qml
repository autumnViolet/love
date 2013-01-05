
import QtQuick 1.0

Image {
    id: header

    property alias editUrl: urlInput.url
    property bool urlChanged: false

    source: "pics/titlebar-bg.png"; fillMode: Image.TileHorizontally

    x: webView.contentX < 0 ? -webView.contentX : webView.contentX > webView.contentWidth-webView.width
                              ? -webView.contentX+webView.contentWidth-webView.width : 0
    y: 0/*{
        if (webView.progress < 1.0)
            return 0;
        else {
            webView.contentY < 0 ? -webView.contentY : webView.contentY > height ? -height : -webView.contentY
        }
    }*/
    signal backclicked()
    Column {
        width: parent.width

        Item {
            width: parent.width; height: 85
            Rectangle{
                width: parent.width; height: 85
                anchors.centerIn: parent
                color: "#ffffff"
                gradient: Gradient {
                    GradientStop {
                        position: 0.00;
                        color: "#303033";
                    }
                    GradientStop {
                        position: 0.11;
                        color: "#e8eaf1";
                    }
                    GradientStop {
                        position: 0.91;
                        color: "#ffffff";
                    }
                    GradientStop {
                        position: 1.00;
                        color: "#06063c";
                    }
                }
                opacity: 0.2
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
                    id:backButtonText
                    anchors.centerIn: parent
//                    anchors.left: parent.left
//                    anchors.leftMargin: 5
//                    anchors.verticalCenter: parent.verticalCenter
//                    anchors.verticalCenterOffset: 5
                    text: "返回"; font.pointSize: 17; font.bold: false
                    color: "white";
                    font.family: "Nokia Sans"
                }
                MouseArea{
                    id:backmousearea
                    anchors.fill: parent
                    onClicked: {
                        console.log("1111")
                        header.backclicked()
                    }
                }


        states: [
            State {
                when: backmousearea.pressed
                PropertyChanges {
                    target: backButtonText
                    color: "#af2c2c"
                }
                PropertyChanges {target:backcolor1;color:"black" }
                PropertyChanges {target:backcolor2;color:"black" }

            }
        ]
        }

    }

    Item {
        width: parent.width; height: 40

        Button {
            id: backButton
            action: webView.back; image: "pics/go-previous-view.png"
            anchors { left: parent.left; bottom: parent.bottom }
            opacity: 0
        }

        Button {
            id: nextButton
            anchors.left: backButton.right
            action: webView.forward; image: "pics/go-next-view.png"
            opacity: 0
        }

        UrlInput {
            id: urlInput
            anchors { left: nextButton.right; right: reloadButton.left }
            image: "pics/display.png"
            onUrlEntered: {
                webBrowser.urlString = url
                webBrowser.focus = true
                header.urlChanged = false
            }
            onUrlChanged: header.urlChanged = true
            opacity: 0
        }

        Button {
            id: reloadButton
            anchors { right: quitButton.left; rightMargin: 10 }
            action: webView.reload; image: "pics/view-refresh.png"
            visible: webView.progress == 1.0 && !header.urlChanged
            opacity: 0
        }
        Text {
            id: quitButton
            color: "white"
            style: Text.Sunken
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: 0
            font.pixelSize: 18
            width: 60
            text: "Quit"
            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }
            Rectangle {
                width: 1
                y: 5
                height: parent.height-10
                anchors.right: parent.left
                color: "darkgray"
            }
        }

        Button {
            id: stopButton
            anchors { right: quitButton.left; rightMargin: 10 }
            action: webView.stop; image: "pics/edit-delete.png"
            visible: webView.progress < 1.0 && !header.urlChanged
            opacity: 0
        }

        Button {
            id: goButton
            opacity: 0
            anchors { right: parent.right; rightMargin: 4 }
            onClicked: {
                webBrowser.urlString = urlInput.url
                webBrowser.focus = true
                header.urlChanged = false
            }
            image: "pics/go-jump-locationbar.png"; visible: header.urlChanged
        }
    }
}
}
