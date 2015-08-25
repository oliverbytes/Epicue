// Tabbed pane project template
#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <bb/cascades/Application>
#include <QtCore/QObject>
#include <QtCore/QMetaType>
#include <QObject>
#include <bb/cascades/QListDataModel>
#include <bb/cascades/ListView>
#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/maps/MapView>
#include <bb/platform/geo/GeoLocation>
#include <scoreloop/scoreloopcore.h>
#include <bb/cascades/Image>
#include <bb/platform/bbm/UserProfile>
#include <bb/system/SystemProgressDialog>

#include <bb/cascades/GroupDataModel>
#include <bb/system/InvokeManager>
#include <bb/system/CardDoneMessage.hpp>
#include <QtLocationSubset/QGeoPositionInfoSource>

using namespace bb::cascades;
using bb::system::SystemProgressDialog;
using QtMobilitySubset::QGeoPositionInfo;
using bb::system::InvokeManager;

class ScoreloopBpsEventHandler;
class Storage;
class ProfileEditor;
class EpicueAPI;

namespace bb {
namespace cascades {
class Application;

namespace maps {
class MapView;
}
}
namespace platform {
namespace geo {
class GeoLocation;
}

namespace bbm {
class Context;
}
}
namespace system {
class InvokeManager;
}
}

class ApplicationUI: public QObject {
	Q_OBJECT
	Q_PROPERTY(bb::cascades::DataModel* modelStores READ modelStores CONSTANT)
	Q_PROPERTY(bb::cascades::DataModel* modelProducts READ modelProducts CONSTANT)
	Q_PROPERTY(bb::cascades::DataModel* modelFeaturedItems READ modelFeaturedItems CONSTANT)
	Q_PROPERTY(bb::cascades::DataModel* modelTraffics READ modelTraffics CONSTANT)
	Q_PROPERTY(bb::cascades::DataModel* modelReviews READ modelReviews CONSTANT)
	Q_PROPERTY(bb::cascades::DataModel* modelReviewsMe READ modelReviewsMe CONSTANT)
	Q_PROPERTY(bb::cascades::DataModel* modelItemPics READ modelItemPics CONSTANT)
	Q_PROPERTY(bb::cascades::DataModel* modelSearch READ modelSearch CONSTANT)

	///////////////////BBM

	Q_PROPERTY(bool busy READ busy NOTIFY profileChanged)
	Q_PROPERTY(QString displayName READ displayName NOTIFY profileChanged)
	Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY profileChanged)
	Q_PROPERTY(QString personalMessage READ personalMessage NOTIFY profileChanged)
	Q_PROPERTY(QString ppid READ ppid NOTIFY profileChanged)
	Q_PROPERTY(QString appVersion READ appVersion NOTIFY profileChanged)
	Q_PROPERTY(QString handle READ handle NOTIFY profileChanged)
	Q_PROPERTY(QString platformVersion READ platformVersion NOTIFY profileChanged)
	Q_PROPERTY(QVariant displayPicture READ displayPicture NOTIFY profileChanged)

	Q_PROPERTY(ProfileEditor* editor READ editor CONSTANT)
	Q_PROPERTY(EpicueAPI* api READ api CONSTANT)

public:
	ApplicationUI(bb::platform::bbm::Context &context, bb::cascades::Application *app);
	~ApplicationUI();

	Q_INVOKABLE
	void loadImagesStores();Q_INVOKABLE
	void loadImagesStoresSearch();Q_INVOKABLE
	void loadImagesFeaturedItems();Q_INVOKABLE
	void loadImagesProducts();Q_INVOKABLE
	void loadImagesTraffics();Q_INVOKABLE
	void loadImagesReviews();Q_INVOKABLE
	void loadImagesReviewsMe();Q_INVOKABLE
	void loadImagesItemPics();

	Q_INVOKABLE
	void parseJSONStores(const QString &jsonString, const QString &type);Q_INVOKABLE
	void parseJSONFeaturedItems(const QString &jsonString);Q_INVOKABLE
	void parseJSONProducts(const QString &jsonString);Q_INVOKABLE
	void parseJSONTraffics(const QString &jsonString);Q_INVOKABLE
	void parseJSONReviews(const QString &jsonString, const QString &type);Q_INVOKABLE
	void parseJSONItemPics(const QString &jsonString);Q_INVOKABLE
	void parseJSONUser(const QString &jsonString);Q_INVOKABLE


	Q_INVOKABLE
	void showToast(const QString &text);Q_INVOKABLE
	void showProgressToast(const QString &title, const QString &text);Q_INVOKABLE
	void showDialog(const QString &title, const QString &text);Q_INVOKABLE
	void showProgressDialog(const QString &title, const QString &body);Q_INVOKABLE
	void hideProgressDialog();Q_INVOKABLE
	QString getSetting(const QString &objectName, const QString &defaultValue);Q_INVOKABLE
	void setSetting(const QString &objectName, const QString &inputValue);Q_INVOKABLE
	void login(const int id);Q_INVOKABLE
	void logoutEpicue();Q_INVOKABLE
	void logoutFacebook();Q_INVOKABLE
	void logoutTwitter();Q_INVOKABLE
	void getLocation();Q_INVOKABLE
	void positionUpdated(const QGeoPositionInfo & pos);Q_INVOKABLE
	void positionUpdateTimeout();Q_INVOKABLE
	bool isEpicueConnected();Q_INVOKABLE
	bool isFacebookConnected();Q_INVOKABLE
	bool isTwitterConnected();Q_INVOKABLE
	bool isNetworkAvailable();Q_INVOKABLE
	int userid();Q_INVOKABLE
	QString getEpicueDisplayName();Q_INVOKABLE
	void saveEpicueDisplayName(const QString &displaynName);
	Q_INVOKABLE QString getModelUserName();

	Q_INVOKABLE
	void invokeEmail(QString email, QString subject, QString body);Q_INVOKABLE
	void invokeSMS(QString number);Q_INVOKABLE
	void invokeCall(QString number);Q_INVOKABLE
	void invokeBBWorld(QString appurl);Q_INVOKABLE
	void invokeBrowser(QString url);Q_INVOKABLE
	void invokeAddContact(QString number);Q_INVOKABLE
	void invokeOpenWithFacebook(QString accountid);Q_INVOKABLE
	void invokeOpenWithTwitter(QString accountid);Q_INVOKABLE
	void invokeMap(double latitude, double longitude);

	Q_INVOKABLE
	double userlatitude();Q_INVOKABLE
	double userlongitude();

	Q_INVOKABLE
	void addNotification(QString title, QString body);

public slots:
	void refresh();
	void showMain();

public Q_SLOTS:
	void initBBM();
	void requestDisplayPicture();
	void receivedInvokeTarget(const bb::system::InvokeRequest& request);

	Q_SIGNALS:
	void profileChanged();
	void gotLocation();
	void nfcInvoked();

private:
	bb::cascades::maps::MapView* mapView;
	bb::cascades::ListView * listRecommendedRestos;
	bb::cascades::ListView * listFeaturedItems;
	bb::cascades::ListView * listReviewsMe;
	bb::cascades::ListView * listCuesMe;

	InvokeManager* invokeManager;

	bb::cascades::DataModel* modelStores() const;
	bb::cascades::QListDataModel<QObject*>* m_modelStores;

	bb::cascades::DataModel* modelFeaturedItems() const;
	bb::cascades::QListDataModel<QObject*>* m_modelFeaturedItems;

	bb::cascades::DataModel* modelProducts() const;
	bb::cascades::QListDataModel<QObject*>* m_modelProducts;

	bb::cascades::DataModel* modelTraffics() const;
	bb::cascades::QListDataModel<QObject*>* m_modelTraffics;

	bb::cascades::DataModel* modelReviews() const;
	bb::cascades::QListDataModel<QObject*>* m_modelReviews;

	bb::cascades::DataModel* modelReviewsMe() const;
	bb::cascades::QListDataModel<QObject*>* m_modelReviewsMe;

	bb::cascades::DataModel* modelItemPics() const;
	bb::cascades::QListDataModel<QObject*>* m_modelItemPics;

	bb::cascades::DataModel* modelSearch() const;
	bb::cascades::QListDataModel<QObject*>* m_modelSearch;

	bb::cascades::QListDataModel<QObject*>* m_modelTemp;

	bb::cascades::DataModel* modelUser() const;
	bb::cascades::QListDataModel<QObject*>* m_modelUser;

	QVariantList objects;
	QVariantList objectsCopy;

	SC_InitData_t m_initData;
	SC_Client_h m_client;

	ScoreloopBpsEventHandler* m_eventHandler;

	///////////////// BBM

	bool busy() const;
	QString displayName() const;
	QString statusMessage() const;
	QString personalMessage() const;
	QString ppid() const;
	QString appVersion() const;
	QString handle() const;
	QString platformVersion() const;
	QVariant displayPicture() const;
	ProfileEditor* editor() const;

	double m_userlatitude;
	double m_userlongitude;

	bb::platform::bbm::UserProfile* m_userProfile;
	bb::cascades::Image m_displayPicture;
	ProfileEditor* m_profileEditor;
	bb::platform::bbm::Context* m_context;

	SystemProgressDialog* progressdialog;

	EpicueAPI* api() const;
	EpicueAPI* m_api;
};

#endif /* ApplicationUI_HPP_ */

