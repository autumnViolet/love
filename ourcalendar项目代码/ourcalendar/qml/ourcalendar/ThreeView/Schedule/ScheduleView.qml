// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id:schedulerectangle

    property int schedulefrom: 0
    signal backweekview()
    signal dayschedule()
    signal fromweekview()
    onFromweekview: {
        schedulefrom = 0;
    }

    onDayschedule: {
        schedulefrom = 1;
    }
    function changetime(scheduletime){
        var currentweeker = scheduletime.getDay()
        var currentday = scheduletime.getDate()
        for(var i=0; i<7; i++)
            schedulemodel.set(i, {"time": new Date(scheduletime.getFullYear(), scheduletime.getMonth(), currentday-currentweeker+i).getFullYear()+"年" +(new Date(scheduletime.getFullYear(), scheduletime.getMonth(), currentday-currentweeker+i).getMonth()+1)+"月"+new Date(scheduletime.getFullYear(), scheduletime.getMonth(), currentday-currentweeker+i).getDate()+"日"})
    }
    function changetointeractive(){
        scheduleview.interactive = false;
    }
    function changetonotinteractive(){
        scheduleview.interactive = true;
    }


    width: 480; height: 854;
    ScheduleModel{id: schedulemodel}
    ListView{
        id: scheduleview
        anchors.fill: parent
        model: schedulemodel
        highlightRangeMode: ListView.StrictlyEnforceRange
        delegate: ScheduleDelegate{}
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        spacing: 40
        currentIndex: externdate.getDay()
        Component.onCompleted: {
            changetime(new Date(externdate.getFullYear(), externdate.getMonth(), externdate.getDate()-externdate.getDay()));
        }
    }
}
