// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

XmlListModel{
    source: "/home/user/.scheduledata.xml"
    query: "/scheduledata/scheduledate[@scheduledateattr=\"00000000\"]/schedule"
    XmlRole{name: "theme"; query: "theme/string()"}
    XmlRole{name: "occurtime"; query: "occurtime/string()"}
    XmlRole{name: "occuraddress"; query: "occuraddress/string()"}
    XmlRole{name: "remindtime"; query: "remindtime/string()"}
    XmlRole{name: "remindway"; query: "remindway/string()"}
    XmlRole{name: "remindsequence"; query: "remindsequence/string()"}
    XmlRole{name: "eventrepeat"; query: "eventrepeat/string()"}
    XmlRole{name: "detail"; query: "detail/string()"}
}
