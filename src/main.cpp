#include <bb/cascades/Application>
#include <QLocale>
#include <QTranslator>
#include "applicationui.hpp"
#include "RegistrationHandler.hpp"
#include "ProfileEditor.hpp"
#include <Qt/qdeclarativedebug.h>

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);

    qmlRegisterType<ProfileEditor>();
    //qmlRegisterType<ApplicationUI>("PersistentObjectsLib", 1, 0, "App");
    const QUuid uuid(QLatin1String("f3bd54f0-4032-44da-93c8-4887b4949b20"));
    RegistrationHandler *registrationHandler = new RegistrationHandler(uuid, &app);
    ApplicationUI *theapp = new ApplicationUI(registrationHandler->context(), &app);

    return Application::exec();
}
