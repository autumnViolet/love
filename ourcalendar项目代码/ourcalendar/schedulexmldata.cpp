#include "schedulexmldata.h"

schedulexmldata::schedulexmldata(QObject *parent):QObject(parent)
{
    initschedulexmldata();
}

void schedulexmldata::initschedulexmldata()
{
    QFile file("/home/user/.scheduledata.xml");
    if( !file.open(QIODevice::ReadWrite))
        return;
    QFileInfo fileinfo(file);
    if(fileinfo.size() == 0){
        file.close();
        QDomDocument doc;
        QDomProcessingInstruction instruction;
        instruction = doc.createProcessingInstruction("xml","version=\"1.0\" encoding=\"UTF-8\"");
        doc.appendChild(instruction);

        QDomElement root = doc.createElement(QString("scheduledata"));
        doc.appendChild(root);
        QDomText text;

        QDomElement scheduledate = doc.createElement(QString("scheduledate"));
        root.appendChild(scheduledate);
        QDomAttr scheduledateattr = doc.createAttribute(QString("scheduledateattr"));
        scheduledateattr.setValue(QString("00000000"));
        scheduledate.setAttributeNode(scheduledateattr);

        QDomElement schedule = doc.createElement(QString("schedule"));
        scheduledate.appendChild(schedule);
        QDomAttr scheduleid = doc.createAttribute(QString("id"));
        scheduleid.setValue(QString("0"));
        schedule.setAttributeNode(scheduleid);

        QDomElement theme = doc.createElement(QString("theme"));
        text = doc.createTextNode(QString(""));
        theme.appendChild(text);
        schedule.appendChild(theme);
        QDomElement occurtime = doc.createElement(QString("occurtime"));
        text = doc.createTextNode(QString(""));
        occurtime.appendChild(text);
        schedule.appendChild(occurtime);
        QDomElement occuraddress = doc.createElement(QString("occuraddress"));
        text = doc.createTextNode(QString(""));
        schedule.appendChild(occuraddress);
//        QDomElement remindtime = doc.createElement(QString("remindtime"));
//        text = doc.createTextNode(QString(""));
//        remindtime.appendChild(text);
//        schedule.appendChild(remindtime);
//        QDomElement remindway = doc.createElement(QString("remindway"));
//        text = doc.createTextNode(QString(""));
//        remindway.appendChild(text);
//        schedule.appendChild(remindway);
//        QDomElement remindsequence = doc.createElement(QString("remindsequence"));
//        text = doc.createTextNode(QString(""));
//        remindsequence.appendChild(text);
//        schedule.appendChild(remindsequence);
        QDomElement eventrepeat = doc.createElement(QString("eventrepeat"));
        text = doc.createTextNode(QString(""));
        eventrepeat.appendChild(text);
        schedule.appendChild(eventrepeat);
        QDomElement detail = doc.createElement(QString("detail"));
        text = doc.createTextNode(QString(""));
        detail.appendChild(text);
        schedule.appendChild(detail);

        if( !file.open(QIODevice::WriteOnly | QIODevice::Truncate)) return;
        QTextStream out(&file);
        doc.save(out, 4);
        file.close();
    }else{
        file.close();
    }
}

void schedulexmldata::addschedulexmldata(QString tmpscheduledate, QString tmpid, QString tmptheme, QString tmpoccurtime, QString tmpoccuraddress,
                                         /*QString tmpremindtime, QString tmpremindway, QString tmpremindsequence,*/ QString tmpeventrepeat, QString tmpdetail)
{
    QFile file("/home/user/.scheduledata.xml");
    if(!file.open(QIODevice::ReadOnly))  return;
    QDomDocument doc;
    if(!doc.setContent(&file)){
        file.close();
        return;
    }
    file.close();

    QDomText text;

    QDomElement root = doc.documentElement();
    QDomElement scheduledate = doc.createElement(QString("scheduledate"));
    QDomAttr scheduledateattr = doc.createAttribute(QString("scheduledateattr"));
    scheduledate.setAttributeNode(scheduledateattr);
    QDomElement schedule = doc.createElement(QString("schedule"));

    QDomNode n = root.firstChild();
    if(n.toElement().attribute(QString("scheduledateattr")) == "00000000"){
        root.removeChild(n);
        root.appendChild(scheduledate);
        scheduledateattr.setValue(tmpscheduledate);
        scheduledate.appendChild(schedule);
    }else{
        bool scheduledateisexistence = false;
        while(!n.isNull()){
            if((n.previousSibling().toElement().attribute(QString("scheduledateattr")) <  tmpscheduledate) &&( tmpscheduledate < n.toElement().attribute(QString("scheduledateattr")))){
                root.insertBefore(scheduledate, n);
                scheduledateattr.setValue(tmpscheduledate);
                scheduledate.appendChild(schedule);
                scheduledateisexistence = true;
            }else if(tmpscheduledate == n.toElement().attribute(QString("scheduledateattr"))){
                n.toElement().appendChild(schedule);
                scheduledateisexistence = true;
            }
            n = n.nextSibling();
        }
        if(!scheduledateisexistence){
            root.appendChild(scheduledate);
            scheduledateattr.setValue(tmpscheduledate);
            scheduledate.appendChild(schedule);
        }
    }


    if(tmpid == "-10"){
        QDomNode nn = root.firstChild();
        while(!nn.isNull()){
            if(tmpscheduledate == nn.toElement().attribute(QString("scheduledateattr"))){
                QDomNodeList schedulelist = nn.toElement().elementsByTagName(QString("schedule"));
                tmpid.setNum(schedulelist.count() - 1);
                qDebug() << tmpid;
            }
            nn = nn.nextSibling();
        }
    }

    QDomAttr scheduleid = doc.createAttribute(QString("id"));
    scheduleid.setValue(QString(tmpid));
    schedule.setAttributeNode(scheduleid);
    QDomElement theme = doc.createElement(QString("theme"));
    text = doc.createTextNode(QString(tmptheme));
    theme.appendChild(text);
    schedule.appendChild(theme);
    QDomElement occurtime = doc.createElement(QString("occurtime"));
    text = doc.createTextNode(QString(tmpoccurtime));
    occurtime.appendChild(text);
    schedule.appendChild(occurtime);
    QDomElement occuraddress = doc.createElement(QString("occuraddress"));
    text = doc.createTextNode(QString(tmpoccuraddress));
    occuraddress.appendChild(text);
    schedule.appendChild(occuraddress);
//    QDomElement remindtime = doc.createElement(QString("remindtime"));
//    text = doc.createTextNode(QString(tmpremindtime));
//    remindtime.appendChild(text);
//    schedule.appendChild(remindtime);
//    QDomElement remindway = doc.createElement(QString("remindway"));
//    text = doc.createTextNode(QString(tmpremindway));
//    remindway.appendChild(text);
//    schedule.appendChild(remindway);
//    QDomElement remindsequence = doc.createElement(QString("remindsequence"));
//    text = doc.createTextNode(QString(tmpremindsequence));
//    remindsequence.appendChild(text);
//    schedule.appendChild(remindsequence);
    QDomElement eventrepeat = doc.createElement(QString("eventrepeat"));
    text = doc.createTextNode(QString(tmpeventrepeat));
    eventrepeat.appendChild(text);
    schedule.appendChild(eventrepeat);
    QDomElement detail = doc.createElement(QString("detail"));
    text = doc.createTextNode(QString(tmpdetail));
    detail.appendChild(text);
    schedule.appendChild(detail);

    if( !file.open(QIODevice::WriteOnly | QIODevice::Truncate)) return;
    QTextStream out(&file);
    doc.save(out, 4);
    file.close();
}

void schedulexmldata::updateschedulexmldata(QString tmpscheduledate, QString tmpid, QString tmptheme, QString tmpoccurtime, QString tmpoccuraddress,
                                            /*QString tmpremindtime, QString tmpremindway, QString tmpremindsequence,*/ QString tmpeventrepeat, QString tmpdetail)
{
    deleteonescheduledata(tmpscheduledate, tmpid);
    addschedulexmldata(tmpscheduledate, tmpid, tmptheme, tmpoccurtime, tmpoccuraddress, /*tmpremindtime, tmpremindway, tmpremindsequence, */tmpeventrepeat, tmpdetail);
}

void schedulexmldata::deleteonescheduledata(QString tmpscheduledate, QString tmpid)
{
    QFile file("/home/user/.scheduledata.xml");
    if(!file.open(QIODevice::ReadOnly))  return;
    QDomDocument doc;
    if(!doc.setContent(&file)){
        file.close();
        return;
    }
    file.close();

    QDomElement root = doc.documentElement();
    QDomNode n = root.firstChild();
    while(!n.isNull()){
        if(tmpscheduledate == n.toElement().attribute(QString("scheduledateattr"))){
            QDomNodeList schedulelist = n.toElement().elementsByTagName(QString("schedule"));
            for(int m=0; m<schedulelist.count(); m++){
                if(schedulelist.at(m).toElement().attribute(QString("id")) == tmpid){
                    qDebug() << n.toElement().tagName();
                    n.toElement().removeChild(schedulelist.at(m));
                }
            }
        }
        n = n.nextSibling();
    }

    if( !file.open(QIODevice::WriteOnly | QIODevice::Truncate)) return;
    QTextStream out(&file);
    doc.save(out, 4);
    file.close();
}

void schedulexmldata::deleteschedulexmldata(QString tmpscheduledate, QString tmpid)
{
    deleteonescheduledata(tmpscheduledate, tmpid);
    QFile file("/home/user/.scheduledata.xml");
    if(!file.open(QIODevice::ReadOnly))  return;
    QDomDocument doc;
    if(!doc.setContent(&file)){
        file.close();
        return;
    }
    file.close();

    QDomElement root = doc.documentElement();
    QDomNode n = root.firstChild();
    while(!n.isNull()){
        if(tmpscheduledate == n.toElement().attribute(QString("scheduledateattr"))){
            QDomNodeList schedulelist = n.toElement().elementsByTagName(QString("schedule"));
            for(int m=0; m<schedulelist.count(); m++){
                if((schedulelist.at(m).toElement().attribute(QString("id")) < tmpid) && (tmpid < schedulelist.at(m+1).toElement().attribute(QString("id")))){
                    for(int i=m+1; i<schedulelist.count(); i++){
                        bool ok;
                        int newid = schedulelist.at(i).toElement().attribute(QString("id")).toInt(&ok,16) - 1;
                        QString newidstring;
                        newidstring.setNum(newid);
                        schedulelist.at(i).toElement().setAttribute(QString("id"), QString(newidstring));
                    }
                }
            }
        }
        n = n.nextSibling();
    }



    if( !file.open(QIODevice::WriteOnly | QIODevice::Truncate)) return;
    QTextStream out(&file);
    doc.save(out, 4);
    file.close();
}
