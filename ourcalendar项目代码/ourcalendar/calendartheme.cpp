#include "calendartheme.h"

void CalendarTheme::savingstring(QString tmpstring){
    themeString=tmpstring;
    QFile file("theme.txt");
    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
        qDebug()<<file.errorString();
    QTextStream out(&file);
    out<<themeString;
    file.close();
}

QString CalendarTheme::gettingstring(){
    QFile file("theme.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
      {  qDebug()<<file.errorString();
         return "no";
    }
    QTextStream in(&file);
    while(!in.atEnd()){
        themeString=in.readLine();
    }
    return themeString;
}
