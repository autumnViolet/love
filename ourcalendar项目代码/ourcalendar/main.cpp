#include <QtGui/QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "schedulexmldata.h"
#include "calendartheme.h"
#include "savingsettings.h"
Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    CalendarTheme theme;
    savingsettings settings;
    QmlApplicationViewer viewer;
    schedulexmldata scheduledata;
    scheduledata.initschedulexmldata();
    viewer.rootContext()->setContextProperty("scheduledatacpp", &scheduledata);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.rootContext()->setContextProperty("calendartheme",&theme);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.rootContext()->setContextProperty("setting",&settings);
   // viewer.setMainQmlFile(QLatin1String("qml/ourcalendar/ThreeView/Schedule/content/Mapping/Map.qml"));
    viewer.setMainQmlFile(QLatin1String("qml/ourcalendar/LoadingPage.qml"));
    viewer.showExpanded();
    // viewer.rootContext()->setContextProperty("calendartheme",&theme);
    return app->exec();
}
