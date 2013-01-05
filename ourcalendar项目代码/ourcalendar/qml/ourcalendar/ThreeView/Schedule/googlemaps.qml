/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

// This example demonstrates how Web services such as Google Maps can be
// abstracted as QML types. Here we have a "Mapping" module with a "Map"
// type. The Map type has an address property. Setting that property moves
// the map. The underlying implementation uses WebView and the Google Maps
// API, but users from QML don't need to understand the implementation in
// order to create a Map.

import QtQuick 1.0
import QtWebKit 1.0
import "content/Mapping"
Rectangle {
    id:googlerectangle
    width: 480
    height: 854
    function getaddress(finalstring){
        map.address=finalstring
    }
    opacity: 0.8
    Rectangle{
      width: 480; height: 854

        Image {
            id: weatherbackground
            opacity: 0.3
            source: imagesource
            anchors.fill:parent
        }
    }
    Item{
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
        }
    }
    Item{
        id:googleback
        width:480
        height: 85
        anchors.top: parent.top

        Rectangle{width: 480;height: 85;anchors.centerIn: parent;opacity: 0.7;color:"black"}
        Item{
            id:backitem
            width: 119
            height:56
            anchors{left: parent.left;leftMargin: 10;top:parent.top;topMargin: 15}
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
                        id:color1
                        position: 0.00;
                        color: "#242525";
                    }
                    GradientStop {
                        id:color2
                        position: 1.00;
                        color: "#040505";
                    }
                }
            }
            Text {
                id: backtext
                text: "返回"
                anchors.centerIn: parent
                font.family: "Nokia Sans"
                color: "white"
                font.pointSize: 17
            }
            MouseArea{
                id:textmousearea
                anchors.fill: parent
                onClicked: {
                    googlerectangle.destroy()
                }

            }
            states:State {
                name: "backRctangle"
                when: textmousearea.pressed
                PropertyChanges {target:color1;color:"black" }
                PropertyChanges {target:color2;color:"black" }
                PropertyChanges {target:backtext;color:"#af2c2c" }

            }


        }

    }

    Map {
        id: map
        width: 480
        height: 769
        address: "ChongQing"
        anchors.top: googleback.bottom
        z:2
        Image {
            id: container
            property bool on: true
            source: "../weatherReport/pics/busy.png"; visible: container.on
            fillMode:Image.PreserveAspectFit
            anchors.centerIn: parent
            opacity: map.status == "Ready" ? 0 : 1
            NumberAnimation on rotation { running: container.on; from: 0; to: 360; loops: Animation.Infinite; duration: 1200 }
        }
    }
    Component.onCompleted: {
        console.log(googlerectangle.height)
    }
    Text {
        id: loading
        anchors.centerIn: parent
        text: map.status == "Error" ? "Error" : "Loading"
        opacity: map.status == "Ready" ? 0 : 1
        font.pixelSize: 30

        Behavior on opacity { NumberAnimation{} }
    }
}
