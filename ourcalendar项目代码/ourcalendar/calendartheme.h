#ifndef CALENDARTHEME_H
#define CALENDARTHEME_H

#include <QObject>
#include <QFile>
#include <QDebug>
#include <QStringList>
#include <QTextStream>
class CalendarTheme : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void savingstring(QString tmpstring);
    Q_INVOKABLE QString gettingstring();
private:
    QString themeString;

};

#endif // CALENDARTHEME_H
