#include "applicationui.hpp"

//----------------------------- OLIVER ----------------------------------------//

#include "imageloader.hpp"
#include "EpicueAPI.hpp"

#include "ScoreloopBpsEventHandler.hpp"
#include "ScoreloopData.hpp"
#include "ScoreloopDefines.hpp"
#include <scoreloop/scoreloopcore.h>
#include "ScoreloopDefines.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/MapData>
#include <bb/cascades/maps/DataProvider>

#include <bb/platform/geo/Point>
#include <bb/platform/geo/GeoLocation>
#include <bb/platform/geo/Marker>
#include <bb/UIToolkitSupport>
#include <bb/cascades/QListDataModel>
#include <bb/data/JsonDataAccess>
#include <bb/data/DataAccessError>
#include <bb/data/DataSource>
#include <qt4/QtCore/QtCore>
#include <qt4/QtCore/QVariant>
#include <qt4/QtCore/QByteArray>
#include <bb/cascades/Invocation>
#include <bb/cascades/places/PlacePicker>
#include <bb/system/SystemDialog>
#include <bb/system/SystemToast>
#include <bb/system/SystemProgressToast>
#include <bb/system/SystemProgressDialog>
#include <QtNetwork/QtNetwork>
#include <bb/cascades/Window>
#include "APIController.hpp"
#include <QtCore/QtCore>
#include <bb/platform/bbm/Context>
#include "RegistrationHandler.hpp"
#include <bb/ImageData>
#include "ProfileEditor.hpp"
#include <bb/PpsObject>
#include <bb/cascades/Page>
#include <bb/system/InvokeRequest>
#include <bb/system/CardDoneMessage>
#include <bb/cascades/Invocation>
#include <QDebug>
#include "APIController.hpp"
#include "PostHttp.hpp"
#include <QtLocationSubset/QGeoPositionInfoSource>
#include <bb/platform/Notification>
#include <bb/platform/NotificationDialog>
#include <bb/platform/NotificationResult>
#include <bb/platform/NotificationError>
#include <QtNfcSubset/qndefmessage.h>

using namespace bb;
using namespace bb::data;
using namespace bb::system;
using namespace bb::cascades;
using namespace bb::cascades::maps;
using namespace bb::platform;
using namespace bb::platform::geo;
using bb::data::JsonDataAccess;
using bb::data::DataAccessError;
using QtMobilitySubset::QGeoPositionInfoSource;

ApplicationUI::ApplicationUI(bb::platform::bbm::Context &context,
		bb::cascades::Application *app) :
		QObject(app), m_userProfile(0), m_context(&context), m_profileEditor(0) {
	//----------------------------- OLIVER ----------------------------------------//

	m_api = new EpicueAPI();
	invokeManager = new InvokeManager();

	bool ok = connect(invokeManager,
			SIGNAL(invoked(const bb::system::InvokeRequest&)), this,
			SLOT(receivedInvokeTarget(const bb::system::InvokeRequest&)));
	Q_ASSERT(ok);
	Q_UNUSED(ok);

	bb::data::DataSource::registerQmlTypes();
	qmlRegisterType<bb::platform::Notification>("bb.platform", 1, 0,
			"Notification");
	qmlRegisterType<bb::platform::NotificationDialog>("bb.platform", 1, 0,
			"NotificationDialog");
	qmlRegisterUncreatableType<bb::platform::NotificationError>("bb.platform",
			1, 0, "NotificationError", "");
	qmlRegisterUncreatableType<bb::platform::NotificationResult>("bb.platform",
			1, 0, "NotificationResult", "");
	qmlRegisterType<ImageLoader>();
	qmlRegisterType<EpicueAPI>("Network.EpicueAPI", 1, 0, "EpicueAPI");
	qmlRegisterType<APIController>("Network.APIController", 1, 0,
			"APIController");
	qmlRegisterType<APIController>("Network.PostHttp", 1, 0, "PostHttp");
	qmlRegisterType<bb::cascades::maps::MapView>("bb.cascades.maps", 1, 0,
			"MapView");

	bool connected = connect(app->mainWindow(), SIGNAL(posted()), this,
			SLOT(showMain()));
	Q_ASSERT(connected);
	Q_UNUSED(connected);

	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
	qml->setContextProperty("myapp", this);
	AbstractPane *root = qml->createRootObject<AbstractPane>();

	listRecommendedRestos = root->findChild<ListView*>("listRecommendedRestos");
	m_modelStores = new QListDataModel<QObject*>();
	m_modelStores->setParent(this);
	listRecommendedRestos->setDataModel(m_modelStores);

	listFeaturedItems = root->findChild<ListView*>("listFeaturedItems");
	m_modelFeaturedItems = new QListDataModel<QObject*>();
	m_modelFeaturedItems->setParent(this);
	listFeaturedItems->setDataModel(m_modelFeaturedItems);

	listReviewsMe = root->findChild<ListView*>("listReviewsMe");
	m_modelReviewsMe = new QListDataModel<QObject*>();
	m_modelReviewsMe->setParent(this);
	listReviewsMe->setDataModel(m_modelReviewsMe);

	listCuesMe = root->findChild<ListView*>("listCuesMe");
	m_modelTraffics = new QListDataModel<QObject*>();
	m_modelTraffics->setParent(this);
	listCuesMe->setDataModel(m_modelTraffics);

	m_modelSearch = new QListDataModel<QObject*>();
	m_modelSearch->setParent(this);

	m_modelReviews = new QListDataModel<QObject*>();
	m_modelReviews->setParent(this);

	m_modelItemPics = new QListDataModel<QObject*>();
	m_modelItemPics->setParent(this);

	m_modelProducts = new QListDataModel<QObject*>();
	m_modelProducts->setParent(this);

	QTimer::singleShot(2000, this, SLOT(initBBM()));

	bb::cascades::Application::instance()->setScene(root);
}

void ApplicationUI::receivedInvokeTarget(
		const bb::system::InvokeRequest& request) {
	const QByteArray data = request.data();
	const QtMobilitySubset::QNdefMessage ndefMessage =
			QtMobilitySubset::QNdefMessage::fromByteArray(data);

	QString message = "";

	for (int i = 0; i < ndefMessage.size(); ++i) {
		const QtMobilitySubset::QNdefRecord record = ndefMessage.at(i);

		QVariantMap entry;
		//entry["tnfType"] = record.typeNameFormat();
		//entry["recordType"] = QString::fromLatin1(record.type());
		entry["payload"] = QString::fromLatin1(record.payload());
		//entry["hexPayload"] = QString::fromLatin1(record.payload().toHex());

		message = entry["payload"].toString();
	}

	int colonIndex = message.indexOf(":") + 1;
	int lastIndex = message.length();

	int storeid = message.mid(colonIndex, lastIndex).toInt();
	// Epicue.NFC.StoreID:1
	// Epicue.NFC.ProductID:1
}

void ApplicationUI::addNotification(QString title, QString body)
{
	Notification *notification = new Notification("Test", this);
	notification->setTitle("Epicue");
	notification->setBody(QString("Found 3 New Nearby Restos"));
	InvokeRequest invokeRequest;
	invokeRequest.setTarget(" bb.action.OPEN");
	invokeRequest.setAction("com.pinoybbdev.epicue.invoke.open");
	invokeRequest.setMimeType("text/plain");
	invokeRequest.setData("2");
	notification->setInvokeRequest(invokeRequest);
	notification->notify();
}

// PARSES JSON STRINGS
void ApplicationUI::parseJSONStores(const QString &jsonString,
		const QString &type) {
	if (type == "store") {
		m_modelStores->clear();
	} else if (type == "search") {
		m_modelSearch->clear();
	} else if (type == "featured") {
		m_modelFeaturedItems->clear();
	}

	JsonDataAccess jda;
	objects = jda.loadFromBuffer(jsonString).toList();

	for (int i = 0; i < objects.length(); i++)
	{
		// STORES
		QString branchname(
				objects.at(i).toMap().value("branchname").toString());
		QString address(objects.at(i).toMap().value("address").toString());
		QString longitude(objects.at(i).toMap().value("longitude").toString());
		QString latitude(objects.at(i).toMap().value("latitude").toString());
		QString telnum(objects.at(i).toMap().value("telnum").toString());
		QString deliverynum(
				objects.at(i).toMap().value("deliverynum").toString());
		QString email(objects.at(i).toMap().value("email").toString());
		QString storetypeid(
				objects.at(i).toMap().value("storetypeid").toString());
		QString distance(objects.at(i).toMap().value("distance").toString());
		QString ratings(objects.at(i).toMap().value("ratings").toString());
		QString trafficlevel(
				objects.at(i).toMap().value("trafficlevel").toString());
		QString averagestatus(
				objects.at(i).toMap().value("averagestatus").toString());
		QString trafficcount(
				objects.at(i).toMap().value("trafficcount").toString());
		QString lasttrafficdatetime(
				objects.at(i).toMap().value("lasttrafficdatetime").toString());
		QString facebookid(
				objects.at(i).toMap().value("facebookid").toString());
		QString twitterid(objects.at(i).toMap().value("twitterid").toString());

		// COMMON PROPERTIES
		QString id(objects.at(i).toMap().value("id").toString());
		QString name(objects.at(i).toMap().value("name").toString());
		QString picture(objects.at(i).toMap().value("picture").toString());
		QString pending(objects.at(i).toMap().value("pending").toString());
		QString enabled(objects.at(i).toMap().value("enabled").toString());
		QString datetime(objects.at(i).toMap().value("datetime").toString());

		ImageLoader* loader = new ImageLoader(id, pending, enabled, datetime,
				picture, name, branchname, address, longitude, latitude, telnum,
				deliverynum, email, storetypeid, distance, ratings,
				trafficlevel, averagestatus, trafficcount, lasttrafficdatetime,
				facebookid, twitterid, this);

		if (type == "store") {
			m_modelStores->append(loader);
		} else if (type == "search") {
			m_modelSearch->append(loader);
		} else if (type == "featured") {
			m_modelFeaturedItems->append(loader);
		}
	}

	hideProgressDialog();

	if (type == "store") {
		loadImagesStores();
	} else if (type == "search") {
		loadImagesStoresSearch();
	} else if (type == "featured") {
		loadImagesFeaturedItems();
	}
}

// PARSES JSON STRINGS
void ApplicationUI::parseJSONFeaturedItems(const QString &jsonString) {
	m_modelFeaturedItems->clear();

	JsonDataAccess jda;
	objects = jda.loadFromBuffer(jsonString).toList();

	for (int i = 0; i < objects.length(); i++) {
		// FEATURED ITEMS
		QString itemid(objects.at(i).toMap().value("itemid").toString());
		QString itemtype(objects.at(i).toMap().value("itemtype").toString());

		// COMMON PROPERTIES
		QString id(objects.at(i).toMap().value("id").toString());
		QString picture(objects.at(i).toMap().value("picture").toString());
		QString pending(objects.at(i).toMap().value("pending").toString());
		QString enabled(objects.at(i).toMap().value("enabled").toString());
		QString datetime(objects.at(i).toMap().value("datetime").toString());

		m_modelFeaturedItems->append(
				new ImageLoader(id, pending, enabled, datetime, picture, itemid,
						itemtype, "", "", "", "", "", "", "", "", "", "", "",
						"", "", "", "", this));
	}

	hideProgressDialog();
	loadImagesFeaturedItems();
}

// PARSES JSON STRINGS
void ApplicationUI::parseJSONProducts(const QString &jsonString) {
	m_modelProducts->clear();

	JsonDataAccess jda;
	objects = jda.loadFromBuffer(jsonString).toList();

	for (int i = 0; i < objects.length(); i++) {
		// PRODUCTS
		QString storeid(objects.at(i).toMap().value("storeid").toString());
		QString description(
				objects.at(i).toMap().value("description").toString());
		QString price(objects.at(i).toMap().value("price").toString());
		QString producttypeid(
				objects.at(i).toMap().value("producttypeid").toString());

		// COMMON PROPERTIES
		QString id(objects.at(i).toMap().value("id").toString());
		QString name(objects.at(i).toMap().value("name").toString());
		QString picture(objects.at(i).toMap().value("picture").toString());
		QString pending(objects.at(i).toMap().value("pending").toString());
		QString enabled(objects.at(i).toMap().value("enabled").toString());
		QString datetime(objects.at(i).toMap().value("datetime").toString());

		m_modelProducts->append(
				new ImageLoader(id, pending, enabled, datetime, picture, name,
						storeid, description, price, producttypeid, "", "", "",
						"", "", "", "", "", "", "", "", "", this));
	}

	hideProgressDialog();
	loadImagesProducts();
}

// PARSES JSON STRINGS
void ApplicationUI::parseJSONReviews(const QString &jsonString, const QString &type)
{
	if(type == "reviewsstore")
	{
		m_modelReviews->clear();
	}
	else if(type == "reviewsuser")
	{
		m_modelReviewsMe->clear();
	}

	JsonDataAccess jda;
	objects = jda.loadFromBuffer(jsonString).toList();

	if (objects.length() == 0)
	{
		m_modelReviews->append(
				new ImageLoader("", "", "", "", "", "", "", "", "",
						"no reviews", "", "", "", "", "", "", "", "", "", "",
						"", "", this));
	}

	for (int i = 0; i < objects.length(); i++) {
		// REVIEWS
		QString review(objects.at(i).toMap().value("review").toString());
		QString rating(objects.at(i).toMap().value("rating").toString());
		QString itemid(objects.at(i).toMap().value("itemid").toString());
		QString itemtype(objects.at(i).toMap().value("itemtype").toString());
		QString userid(objects.at(i).toMap().value("userid").toString());
		QString username(objects.at(i).toMap().value("username").toString());

		// COMMON PROPERTIES
		QString id(objects.at(i).toMap().value("id").toString());
		QString picture(objects.at(i).toMap().value("picture").toString());
		QString pending(objects.at(i).toMap().value("pending").toString());
		QString enabled(objects.at(i).toMap().value("enabled").toString());
		QString datetime(objects.at(i).toMap().value("datetime").toString());

		ImageLoader* loader = new ImageLoader(id, pending, enabled, datetime, picture, itemid,
				itemtype, userid, username, review, "", "", "", "", "",
				rating, "", "", "", "", "", "", this);

		if(type == "reviewsstore")
		{
			m_modelReviews->append(loader);
		}
		else if(type == "reviewsuser")
		{
			m_modelReviewsMe->append(loader);
		}
	}

	hideProgressDialog();

	if(type == "reviewsstore")
	{
		loadImagesReviews();
	}
	else if(type == "reviewsuser")
	{
		loadImagesReviewsMe();
	}
}

void ApplicationUI::parseJSONTraffics(const QString &jsonString)
{
	m_modelTraffics->clear();

	JsonDataAccess jda;
	objects = jda.loadFromBuffer(jsonString).toList();

	for (int i = 0; i < objects.length(); i++) {
		QString userid(objects.at(i).toMap().value("userid").toString());
		QString storeid(objects.at(i).toMap().value("storeid").toString());
		QString status(objects.at(i).toMap().value("status").toString());
		QString comment(objects.at(i).toMap().value("comment").toString());
		QString longitude(objects.at(i).toMap().value("longitude").toString());
		QString latitude(objects.at(i).toMap().value("latitude").toString());

		// COMMON PROPERTIES
		QString id(objects.at(i).toMap().value("id").toString());
		QString picture(objects.at(i).toMap().value("picture").toString());
		QString pending(objects.at(i).toMap().value("pending").toString());
		QString enabled(objects.at(i).toMap().value("enabled").toString());
		QString datetime(objects.at(i).toMap().value("datetime").toString());

		m_modelTraffics->append(
				new ImageLoader(id, pending, enabled, datetime, picture, status,
						storeid, userid, longitude, latitude, comment, "", "",
						"", "", "", "", "", "", "", "", "", this));
	}

	hideProgressDialog();
	loadImagesTraffics();
}

// PARSES JSON STRINGS
void ApplicationUI::parseJSONItemPics(const QString &jsonString) {
	m_modelItemPics->clear();

	JsonDataAccess jda;
	objects = jda.loadFromBuffer(jsonString).toList();

	for (int i = 0; i < objects.length(); i++) {
		QString itemid(objects.at(i).toMap().value("itemid").toString());
		QString itemtype(objects.at(i).toMap().value("itemtype").toString());

		// COMMON PROPERTIES
		QString id(objects.at(i).toMap().value("id").toString());
		QString picture(objects.at(i).toMap().value("picture").toString());
		QString pending(objects.at(i).toMap().value("pending").toString());
		QString enabled(objects.at(i).toMap().value("enabled").toString());
		QString datetime(objects.at(i).toMap().value("datetime").toString());

		m_modelItemPics->append(
				new ImageLoader(id, pending, enabled, datetime, picture, itemid,
						itemtype, "", "", "", "", "", "", "", "", "", "", "",
						"", "", "", "", this));
	}

	hideProgressDialog();
	loadImagesItemPics();
}

//PARSE JSON USER
void ApplicationUI::parseJSONUser(const QString &jsonString)
{
	JsonDataAccess jda;
	objects = jda.loadFromBuffer(jsonString).toList();

	if(objects.length() > 0)
	{
		QString id(objects.at(0).toMap().value("id").toString());
		QString picture(objects.at(0).toMap().value("picture").toString());
		QString username(objects.at(0).toMap().value("username").toString());
		QString password(objects.at(0).toMap().value("password").toString());
		QString email(objects.at(0).toMap().value("email").toString());
		QString firstname(objects.at(0).toMap().value("firstname").toString());
		QString lastname(objects.at(0).toMap().value("lastname").toString());
		QString middlename(objects.at(0).toMap().value("middlename").toString());
		QString birthdate(objects.at(0).toMap().value("birthdate").toString());
		QString gender(objects.at(0).toMap().value("gender").toString());
		QString twitterid(objects.at(0).toMap().value("twitterid").toString());
		QString facebookid(objects.at(0).toMap().value("facebookid").toString());
		QString foursquareid(objects.at(0).toMap().value("foursquareid").toString());
		QString scoreloopid(objects.at(0).toMap().value("scoreloopid").toString());
		QString pending(objects.at(0).toMap().value("pending").toString());
		QString enabled(objects.at(0).toMap().value("enabled").toString());
		QString datetime(objects.at(0).toMap().value("datetime").toString());

		setSetting("user_id", id);
		setSetting("user_username", username);
		setSetting("user_password", password);
		setSetting("user_email", email);
		setSetting("user_firstname", firstname);
		setSetting("user_lastname", lastname);
		setSetting("user_middlename", middlename);
		setSetting("user_birthdate", birthdate);
		setSetting("user_gender", gender);
		setSetting("user_twitterid", twitterid);
		setSetting("user_facebookid", facebookid);
		setSetting("user_foursquareid", foursquareid);
		setSetting("user_scoreloopid", scoreloopid);
	}
	else
	{
		qDebug() << "USER NOT FOUND ";
	}

	hideProgressDialog();
}


// LOADS IMAGE ASYNCHRONOUSLY
void ApplicationUI::loadImagesStores() {
	for (int row = 0; row < m_modelStores->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelStores->value(row))->load();
	}
}

void ApplicationUI::loadImagesStoresSearch() {
	for (int row = 0; row < m_modelSearch->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelSearch->value(row))->load();
	}
}

void ApplicationUI::loadImagesProducts() {
	for (int row = 0; row < m_modelProducts->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelProducts->value(row))->load();
	}
}

void ApplicationUI::loadImagesFeaturedItems() {
	for (int row = 0; row < m_modelFeaturedItems->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelFeaturedItems->value(row))->load();
	}
}

void ApplicationUI::loadImagesReviews() {
	for (int row = 0; row < m_modelReviews->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelReviews->value(row))->load();
	}
}

void ApplicationUI::loadImagesReviewsMe() {
	for (int row = 0; row < m_modelReviewsMe->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelReviewsMe->value(row))->load();
	}
}

void ApplicationUI::loadImagesTraffics() {
	for (int row = 0; row < m_modelTraffics->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelTraffics->value(row))->load();
	}
}

void ApplicationUI::loadImagesItemPics() {
	for (int row = 0; row < m_modelItemPics->size(); ++row) {
		qobject_cast<ImageLoader*>(m_modelItemPics->value(row))->load();
	}
}

// GETS THE DATA MODEL
bb::cascades::DataModel* ApplicationUI::modelSearch() const {
	return m_modelSearch;
}

bb::cascades::DataModel* ApplicationUI::modelStores() const {
	return m_modelStores;
}

bb::cascades::DataModel* ApplicationUI::modelFeaturedItems() const {
	return m_modelFeaturedItems;
}

bb::cascades::DataModel* ApplicationUI::modelProducts() const {
	return m_modelProducts;
}

bb::cascades::DataModel* ApplicationUI::modelTraffics() const {
	return m_modelTraffics;
}

bb::cascades::DataModel* ApplicationUI::modelReviews() const {
	return m_modelReviews;
}

bb::cascades::DataModel* ApplicationUI::modelReviewsMe() const {
	return m_modelReviewsMe;
}

bb::cascades::DataModel* ApplicationUI::modelItemPics() const {
	return m_modelItemPics;
}

void ApplicationUI::logoutFacebook() {
	setSetting("fbuserid", "");
	setSetting("fbaccess_token", "");
}

void ApplicationUI::logoutTwitter()
{
	setSetting("twaccesstoken", "");
	setSetting("twaccesstokensecret", "");
}

void ApplicationUI::logoutEpicue()
{
	setSetting("user_id", "");
	setSetting("user_username", "");
	setSetting("user_email", "");
	setSetting("user_firstname", "");
	setSetting("user_middlename", "");
	setSetting("user_birthdate", "");
	setSetting("user_gender", "");
	setSetting("user_twitterid", "");
	setSetting("user_facebookid", "");
	setSetting("user_foursquareid", "");
	setSetting("user_scoreloopid", "");
}

bool ApplicationUI::isFacebookConnected() {
	bool connected = true;

	if (getSetting("fbuserid", "none") == "none"
			|| getSetting("fbaccess_token", "none") == "none") {
		connected = false;
	}

	return connected;
}

bool ApplicationUI::isTwitterConnected() {
	bool connected = true;

	if (getSetting("twaccesstoken", "none") == "none"
			|| getSetting("twaccesstokensecret", "none") == "none") {
		connected = false;
	}

	return connected;
}

bool ApplicationUI::isEpicueConnected()
{
	bool connected = true;

	if (getSetting("user_id", "none") == "none")
	{
		connected = false;
	}

	return connected;
}

// INITIALIZES BBM
void ApplicationUI::initBBM() {
	m_userProfile = new bb::platform::bbm::UserProfile(m_context, this);
	m_profileEditor = new ProfileEditor(m_userProfile, this);
}

// LOAD BBM PICTURE
void ApplicationUI::requestDisplayPicture() {
	const QByteArray imageData = m_userProfile->displayPicture();
	m_displayPicture = bb::cascades::Image(imageData);
	emit profileChanged();
}

// GET BBM STATUS IF BUSY OR NOT
bool ApplicationUI::busy() const {
	return (m_userProfile->status() == bb::platform::bbm::UserStatus::Busy);
}

// GET BBM DISPLAY NAME
QString ApplicationUI::displayName() const {
	return m_userProfile->displayName();
}

// GET BBM STATUS MESSAGE
QString ApplicationUI::statusMessage() const {
	return m_userProfile->statusMessage();
}

// GET BBM PERSONAL MESSAGE
QString ApplicationUI::personalMessage() const {
	return m_userProfile->personalMessage();
}

QString ApplicationUI::ppid() const {
	return m_userProfile->ppId();
}

QString ApplicationUI::appVersion() const {
	return m_userProfile->applicationVersion();
}

QString ApplicationUI::handle() const {
	return m_userProfile->handle();
}

QString ApplicationUI::platformVersion() const {
	return QString::number(m_userProfile->sdkVersion());
}

// GET BBM DISPLAY PICTURE
QVariant ApplicationUI::displayPicture() const {
	return QVariant::fromValue(m_displayPicture);
}

// GET BBM PROFILE EDITOR OBJECT
ProfileEditor* ApplicationUI::editor() const {
	return m_profileEditor;
}

// GET EPICUE API OBJECT
EpicueAPI* ApplicationUI::api() const {
	return m_api;
}

// TRIGGERED AFTER PULLED TO REFRESH
void ApplicationUI::refresh() {

}

void ApplicationUI::login(const int id)
{
	QSettings settings;
	settings.setValue("loggedin", QVariant(true));
	settings.setValue("userid", QVariant(id));
}

int ApplicationUI::userid() {
	QSettings settings;

	if (settings.value("userid").isNull()) {
		return 0;
	}

	return settings.value("userid").toInt();
}

// GET SETTING
QString ApplicationUI::getSetting(const QString &objectName,
		const QString &defaultValue) {
	QSettings settings;

	if (settings.value(objectName).isNull()
			|| settings.value(objectName) == "") {
		return defaultValue;
	}

	return settings.value(objectName).toString();
}

// SET SETTING
void ApplicationUI::setSetting(const QString &objectName,
		const QString &inputValue) {
	QSettings settings;
	settings.setValue(objectName, QVariant(inputValue));
}

// SHOW A TOAST MESSAGE
void ApplicationUI::showToast(const QString &text) {
	SystemToast *toast = new SystemToast(this);
	toast->setBody(text);
	toast->setPosition(SystemUiPosition::MiddleCenter);
	toast->show();
}

// SHOW A TOAST MESSAGE WITH PROGRESS
void ApplicationUI::showProgressToast(const QString &title,
		const QString &text) {
	SystemProgressToast *progresstoast = new SystemProgressToast(this);

	progresstoast->setBody(title);
	progresstoast->setProgress(75);
	progresstoast->setStatusMessage(text);
	progresstoast->setState(SystemUiProgressState::Active);
	progresstoast->setPosition(SystemUiPosition::MiddleCenter);
	progresstoast->show();
}

// SHOW A DIALOG MESSAGE
void ApplicationUI::showDialog(const QString &title, const QString &text) {
	SystemDialog *dialog = new SystemDialog(this);
	dialog->setTitle(title);
	dialog->setBody(text);
	dialog->setEmoticonsEnabled(true);
	dialog->show();
}

// SHOW A DIALOG MESSAGE WITH PROGRESS
void ApplicationUI::showProgressDialog(const QString &title,
		const QString &body) {
	progressdialog = new SystemProgressDialog();
	progressdialog->setProgress(-1);
	progressdialog->setState(SystemUiProgressState::Active);
	progressdialog->confirmButton()->setEnabled(false);
	progressdialog->setTitle(title);
	progressdialog->setBody(body);
	progressdialog->show();
}

void ApplicationUI::hideProgressDialog()
{
	if(progressdialog != NULL)
	{
		progressdialog->cancel();
	}
}

// INITIALIZE SCORELOOP
void ApplicationUI::showMain() {
	SC_InitData_Init(&m_initData);
	SC_Error_t rc = SC_Client_New(&m_client, &m_initData, GAME_ID, GAME_SECRET,
			GAME_VERSION, GAME_CURRENCY, GAME_LANGUAGE);
	ScoreloopData *scoreloopData = 0;

	if (rc == SC_OK) {
		m_eventHandler = new ScoreloopBpsEventHandler(m_initData);
		scoreloopData = new ScoreloopData(m_client, this);
		scoreloopData->load();
	} else {
		qDebug() << "Could not initialize Scoreloop: " << SC_MapErrorToStr(rc);
		return;
	}
}

//-----------------------------START ALLYSON ----------------------------------------//

void ApplicationUI::saveEpicueDisplayName(const QString &displaynName) {
	QSettings settings;
	settings.setValue("displayname", displaynName);
}

/**
 * returns username/displayname from qsettings.
 * returns 0 if null
 * */
QString ApplicationUI::getEpicueDisplayName() {
	QSettings settings;
	if (settings.value("displayname").isNull()) {
		return NULL;
	}
	return settings.value("displayname").toString();
}

bb::cascades::DataModel* ApplicationUI::modelUser() const {
	return m_modelUser;
}

QString ApplicationUI::getModelUserName()
{
	return qobject_cast<ImageLoader*>(m_modelUser->value(0))->getUsername();
}
//-----------------------------END ALLYSON--------------------------------------//
void ApplicationUI::getLocation() {
	QGeoPositionInfoSource *src = QGeoPositionInfoSource::createDefaultSource(
			this);

	bool positionUpdatedConnected = connect(src,
			SIGNAL(positionUpdated(const QGeoPositionInfo &)), this,
			SLOT(positionUpdated(const QGeoPositionInfo &)));

	if (positionUpdatedConnected) {
		src->requestUpdate();
	} else {

	}
}

void ApplicationUI::positionUpdated(const QGeoPositionInfo & pos) {
	m_userlatitude = pos.coordinate().latitude();
	m_userlongitude = pos.coordinate().longitude();
	emit gotLocation();
}

void ApplicationUI::positionUpdateTimeout() {
	qDebug() << "LOCATION TIMEDOUT";
}

double ApplicationUI::userlatitude() {
	return m_userlatitude;
}

double ApplicationUI::userlongitude() {
	return m_userlongitude;
}

ApplicationUI::~ApplicationUI() {
	delete m_eventHandler;
}

bool ApplicationUI::isNetworkAvailable() {
	QNetworkConfigurationManager netMgr;
	QList<QNetworkConfiguration> mNetList = netMgr.allConfigurations(
			QNetworkConfiguration::Active);

	if (mNetList.count() > 0) {
		if (netMgr.isOnline()) {
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}

// --------------------- INVOCATIONS --------------------- //

void ApplicationUI::invokeSMS(QString number) {
	InvokeRequest request;
	request.setTarget("sys.pim.text_messaging.composer");
	request.setAction("bb.action.SENDTEXT");
	request.setUri("tel:" + number);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeEmail(QString email, QString subject, QString body) {
	InvokeRequest request;
	request.setTarget("sys.pim.uib.email.hybridcomposer");
	request.setAction("bb.action.SENDEMAIL");
	request.setUri(
			"mailto:" + email + "?subject=" + subject.replace(" ", "%20")
					+ "&body=" + body.replace(" ", "%20"));
	invokeManager->invoke(request);
}

void ApplicationUI::invokeCall(QString number) {
	qDebug() << "INVOKED: " << number;

	InvokeRequest request;
	request.setMimeType("application/vnd.blackberry.phone.startcall");
	request.setAction("bb.action.DIAL");

	QVariantMap map;
	map.insert("number", number);
	QByteArray requestData = PpsObject::encode(map, NULL);

	request.setData(requestData);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeBBWorld(QString appurl) {
	InvokeRequest request;
	request.setMimeType("application/x-bb-appworld");
	request.setAction("bb.action.OPEN");
	request.setUri(appurl);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeBrowser(QString url) {
	InvokeRequest request;
	request.setTarget("sys.browser");
	request.setAction("bb.action.OPEN");
	request.setUri(url);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeAddContact(QString number) {
	InvokeRequest request;
	request.setMimeType("application/vnd.blackberry.string.phone");
	request.setTarget("sys.pim.contacts.app");
	request.setAction("bb.action.ADDTOCONTACT");
	request.setData(number.toAscii());
	invokeManager->invoke(request);
}

void ApplicationUI::invokeOpenWithFacebook(QString accountid) {
	InvokeRequest request;
	request.setTarget("com.rim.bb.app.facebook");
	request.setAction("bb.action.OPEN");

	QVariantMap payload;
	payload["object_type"] = "page";
	payload["object_id"] = accountid;

	request.setMetadata(payload);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeOpenWithTwitter(QString accountid) {
	InvokeRequest request;
	request.setTarget("com.twitter.urihandler");
	request.setAction("bb.action.VIEW");
	request.setUri("twitter:connect:" + accountid);
	invokeManager->invoke(request);
}

void ApplicationUI::invokeMap(double latitude, double longitude) {
//	InvokeRequest request;
//	request.setTarget("com.twitter.urihandler");
//	request.setAction("bb.action.VIEW" );
//	request.setUri("twitter:connect:" + accountid);
//	invokeManager->invoke(request);
}
