#include "savingsettings.h"

void savingsettings::savingweatherstring(QString tmpstring)
{
     WeatherString=tmpstring;
     qDebug()<<WeatherString;
     QFile file("weather.txt");
     if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
         qDebug()<<file.errorString();
     QTextStream out(&file);
     out<<WeatherString;
     file.close();
}

QString savingsettings::gettingweatherstring()
{
    QFile file("weather.txt");
     if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
       {  qDebug()<<file.errorString();
          return "no";
     }
     QTextStream in(&file);
     while(!in.atEnd()){
         WeatherString=in.readLine();
     }
     return WeatherString;

}

void savingsettings::savinggooglestring(QString tmpstring)
{

    GoogleString=tmpstring;
    QFile file("google.txt");
    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
        qDebug()<<file.errorString();
    QTextStream out(&file);
    out<<GoogleString;
    file.close();
}

QString savingsettings::gettinggooglestring()
{
    QFile file("google.txt");
      if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
        {  qDebug()<<file.errorString();
           return "no";
      }
      QTextStream in(&file);
      while(!in.atEnd()){
          GoogleString=in.readLine();
      }
      return GoogleString;

}

void savingsettings::savingsaveflowstring(QString tmpstring)
{
    SaveFlowString=tmpstring;
    QFile file("saveflow.txt");
    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
        qDebug()<<file.errorString();
    QTextStream out(&file);
    out<<SaveFlowString;
    file.close();

}

QString savingsettings::gettingsaveflowstring()
{
    QFile file("saveflow.txt");
      if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
        {  qDebug()<<file.errorString();
           return "no";
      }
      QTextStream in(&file);
      while(!in.atEnd()){
          SaveFlowString=in.readLine();
          qDebug()<<SaveFlowString;
      }
      return SaveFlowString;
}

void savingsettings::savingpureweatherstring(QString tmpstring)
{
    PureWeatherString=tmpstring;
    QFile file("pureweather.txt");
    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
        qDebug()<<file.errorString();
    QTextStream out(&file);
    out<<PureWeatherString;
    qDebug()<<PureWeatherString;
    file.close();

}

QString savingsettings::gettingpureweathertring()
{
    QFile file("pureweather.txt");
        if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
          {  qDebug()<<file.errorString();
             return "no";
        }
        QTextStream in(&file);
        while(!in.atEnd()){
            PureWeatherString=in.readLine();
            qDebug()<<PureWeatherString;
        }
        return PureWeatherString;

}

