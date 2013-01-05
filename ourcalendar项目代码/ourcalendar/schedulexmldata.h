#ifndef SCHEDULEXMLDATA_H
#define SCHEDULEXMLDATA_H
#include <QFile>
#include <QFileInfo>
#include <QDomDocument>
#include <QDomProcessingInstruction>
#include <QTextStream>
#include <QDebug>
#include <QDomNodeList>
#include <QObject>

class schedulexmldata : public QObject
{
    Q_OBJECT
public slots:
    void initschedulexmldata();

    void addschedulexmldata(QString, QString, QString, QString, QString, QString, QString/*, QString, QString, QString*/);
    void updateschedulexmldata(QString, QString, QString, QString, QString, QString, QString/*, QString, QString, QString*/);

    void deleteonescheduledata(QString, QString);
    void deleteschedulexmldata(QString, QString);
public:
    schedulexmldata(QObject *parent = 0);
};

#endif // SCHEDULEXMLDATA_H
