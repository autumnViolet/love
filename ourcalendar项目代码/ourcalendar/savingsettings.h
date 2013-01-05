#ifndef SAVINGSETTINGS_H
#define SAVINGSETTINGS_H

#include <QObject>
#include <QFile>
#include <QDebug>
#include <QStringList>
#include <QTextStream>
class savingsettings : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void savingweatherstring(QString tmpstring);
    Q_INVOKABLE QString gettingweatherstring();
    Q_INVOKABLE void savinggooglestring(QString tmpstring);
    Q_INVOKABLE QString gettinggooglestring();
    Q_INVOKABLE void savingsaveflowstring(QString tmpstring);
    Q_INVOKABLE QString gettingsaveflowstring();
    Q_INVOKABLE void savingpureweatherstring(QString tmpstring);
    Q_INVOKABLE QString gettingpureweathertring();
private:
    QString WeatherString;
    QString GoogleString;
    QString SaveFlowString;
    QString PureWeatherString;

};

#endif // SAVINGSETTINGS_H
