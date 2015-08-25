APP_NAME = Epicue

CONFIG += qt warn_on cascades10

QT += network
LIBS += -lbbcascadesplaces
LIBS += -lQtLocationSubset
LIBS += -lbbcascadesmaps
LIBS += -lGLESv1_CM
LIBS += -lbb
LIBS += -lbbdata
LIBS += -lbbsystem
LIBS += -lbbplatform
LIBS += -lbbplatformbbm
LIBS += -lscoreloopcore
LIBS += -lbbmultimedia
LIBS += -lQtNfcSubset

device {
    CONFIG(debug, debug|release) {
        # Device-Debug custom configuration
    }

    CONFIG(release, debug|release) {
        # Device-Release custom configuration
    }
}

include(config.pri)
