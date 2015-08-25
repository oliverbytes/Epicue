#include "APIController.hpp"
#include "ApplicationUI.hpp"
#include "EpicueAPI.hpp"
#include "ProfileEditor.hpp"

#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QSslConfiguration>
#include <QUrl>
#include <QtNetwork/QtNetwork>
#include <QtLocationSubset/QGeoPositionInfo>
#include <QtLocationSubset/QGeoPositionInfoSource>

using QtMobilitySubset::QGeoPositionInfoSource;

APIController::APIController(QObject* parent)
    : QObject(parent)
    , m_networkAccessManager(new QNetworkAccessManager(this))
{
	locationTimer = new QTimer(this);
	connect(locationTimer, SIGNAL(timeout()), this, SLOT(updateLocation()));
}

QString APIController::getJSON
	(
		const QString &url
	)
{
    const QUrl theurl(url);
    QNetworkRequest request(theurl);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);

    return "done";
}

void APIController::postToFB
	(
		const QByteArray &message
	)
{
    const QUrl url(EpicueAPI::fbfeedsurl());
    QNetworkRequest request(url);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart messagePart;
    messagePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"message\""));
    messagePart.setBody(message);
    multiPart->append(messagePart);

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);
}

void APIController::postToTwitter
	(
		const QByteArray &message
	)
{
    const QUrl url(EpicueAPI::twposturl());
    QNetworkRequest request(url);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart messagePart;
    messagePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"message\""));
    messagePart.setBody(message);
    multiPart->append(messagePart);

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);
}

void APIController::push
	(
		const QByteArray &message
	)
{
    const QUrl url(EpicueAPI::push_url());
    QNetworkRequest request(url);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart messagePart;
    messagePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"message\""));
    messagePart.setBody(message);
    multiPart->append(messagePart);

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);
}

void APIController::login
	(
		const QByteArray &email,
		const QByteArray &password
	)
{
    const QUrl url(EpicueAPI::login_url());
    QNetworkRequest request(url);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart emailPart;
    emailPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"email\""));
    emailPart.setBody(email);
    multiPart->append(emailPart);

    QHttpPart passwordPart;
    passwordPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"password\""));
    passwordPart.setBody(password);
    multiPart->append(passwordPart);

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);
}

void APIController::registeruser
	(
		const QByteArray &username,
		const QByteArray &password,
		const QByteArray &email
	)
{
    const QUrl url(EpicueAPI::register_url());
    QNetworkRequest request(url);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart usernamePart;
    usernamePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"username\""));
    usernamePart.setBody(username);
    multiPart->append(usernamePart);

    QHttpPart passwordPart;
    passwordPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"password\""));
    passwordPart.setBody(password);
    multiPart->append(passwordPart);

    QHttpPart emailPart;
    emailPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"email\""));
    emailPart.setBody(email);
	multiPart->append(emailPart);

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);
}

void APIController::updateuser
	(
		const QByteArray &userid,
		const QByteArray &username,
		const QByteArray &password,
		const QByteArray &email,
		const QByteArray &firstname,
		const QByteArray &middlename,
		const QByteArray &lastname,
		const QByteArray &birthdate,
		const QByteArray &gender
	)
{
    const QUrl url(EpicueAPI::updateuser_url());
    QNetworkRequest request(url);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart useridPart;
    useridPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"userid\""));
	useridPart.setBody(userid);
	multiPart->append(useridPart);

    QHttpPart usernamePart;
    usernamePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"username\""));
    usernamePart.setBody(username);
    multiPart->append(usernamePart);

    QHttpPart passwordPart;
    passwordPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"password\""));
    passwordPart.setBody(password);
    multiPart->append(passwordPart);

    QHttpPart emailPart;
    emailPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"email\""));
    emailPart.setBody(email);
	multiPart->append(emailPart);

	// EXTRAS

	QHttpPart firstnamePart;
	firstnamePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"firstname\""));
	firstnamePart.setBody(firstname);
	multiPart->append(firstnamePart);

	QHttpPart middlenamePart;
	middlenamePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"middlename\""));
	middlenamePart.setBody(middlename);
	multiPart->append(middlenamePart);

	QHttpPart lastnamePart;
	lastnamePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"lastname\""));
	lastnamePart.setBody(lastname);
	multiPart->append(lastnamePart);

	QHttpPart birthdatePart;
	birthdatePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"birthdate\""));
	birthdatePart.setBody(birthdate);
	multiPart->append(birthdatePart);

	QHttpPart genderPart;
	genderPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"gender\""));
	genderPart.setBody(gender);
	multiPart->append(genderPart);

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);
}

void APIController::postTraffic
	(
		const QByteArray &userid,
		const QByteArray &storeid,
		const QByteArray &status,
		const QByteArray &comment,
		const QByteArray &longitude,
		const QByteArray &latitude,
		const QByteArray &picture
	)
{
    const QUrl url(EpicueAPI::createtraffic_url());
    QNetworkRequest request(url);

    qDebug() << "userid: " << userid << ", storeid: " << storeid << ", status: " << status << ", comment: " << comment << ", longitude: " << longitude << ", latitude: " << latitude;

    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart useridPart;
    useridPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"userid\""));
    useridPart.setBody(userid);
    multiPart->append(useridPart);

    QHttpPart storeidPart;
    storeidPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"storeid\""));
    storeidPart.setBody(storeid);
    multiPart->append(storeidPart);

	QHttpPart statusPart;
	statusPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"status\""));
	statusPart.setBody(status);
	multiPart->append(statusPart);

	QHttpPart commentPart;
	commentPart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"comment\""));
	commentPart.setBody(comment);
	multiPart->append(commentPart);

	QHttpPart longitudePart;
	longitudePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"longitude\""));
	longitudePart.setBody(longitude);
	multiPart->append(longitudePart);

	QHttpPart latitudePart;
	latitudePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"latitude\""));
	latitudePart.setBody(latitude);
	multiPart->append(latitudePart);

//    QHttpPart picturePart;
//    picturePart.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("image/jpeg"));
//    picturePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"picture\""));
//    QFile *file = new QFile(picture);
//    file->open(QIODevice::ReadOnly);
//    picturePart.setBodyDevice(file);
//    file->setParent(multiPart);
//    multiPart->append(picturePart);

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);
}

void APIController::onGetReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    QString response;

    if (reply)
    {
        if (reply->error() == QNetworkReply::NoError)
        {
            const int available = reply->bytesAvailable();

            if (available > 0)
            {
                const QByteArray buffer(reply->readAll());
                response = QString::fromUtf8(buffer);
            }
        }
        else
        {
            response = tr("Error: %1 status: %2").arg(reply->errorString(), reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString());
            qDebug() << response;
        }

        reply->deleteLater();
    }

    if (response.trimmed().isEmpty())
    {
        response = tr("Unable to retrieve post response");
    }

    emit complete(response);
}

void APIController::startLocationUpdater(int secondsInterval)
{
	locationTimer->start(secondsInterval);
}

void APIController::stopLocationUpdater()
{
	locationTimer->stop();
}

void APIController::updateLocation()
{
	getLocationUpdater();
}

void APIController::getLocationUpdater()
{
	QGeoPositionInfoSource *src = QGeoPositionInfoSource::createDefaultSource(this);

	bool positionUpdatedConnected = connect(src,
	    SIGNAL(positionUpdated(const QGeoPositionInfo &)), this,
	    SLOT(positionUpdatedUpdater(const QGeoPositionInfo &)));

	if (positionUpdatedConnected)
	{
	    src->requestUpdate();
	}
	else
	{

	}
}

void APIController::positionUpdatedUpdater(const QGeoPositionInfo & pos)
{
	m_userlatitude = pos.coordinate().latitude();
	m_userlongitude = pos.coordinate().longitude();

	qDebug() << "UPDATED UPDATER LOCATION";
}

void APIController::positionUpdateTimeoutUpdater()
{

}

////////////////////////////////////////

void APIController::getLocation()
{
	QGeoPositionInfoSource *src = QGeoPositionInfoSource::createDefaultSource(this);

	bool positionUpdatedConnected = connect(src,
	    SIGNAL(positionUpdated(const QGeoPositionInfo &)),
	    this,
	    SLOT(positionUpdated(const QGeoPositionInfo &)));

	if (positionUpdatedConnected)
	{
	    src->requestUpdate();
	}
	else
	{

	}
}

void APIController::positionUpdated(const QGeoPositionInfo & pos)
{
	m_userlatitude = pos.coordinate().latitude();
	m_userlongitude = pos.coordinate().longitude();
	emit gotLocation(m_userlatitude, m_userlongitude);

	qDebug() << "UPDATED ONE SHOT LOCATION";
}

void APIController::positionUpdateTimeout()
{

}

double APIController::userlatitude()
{
	return m_userlatitude;
}

double APIController::userlongitude()
{
	return m_userlongitude;
}
