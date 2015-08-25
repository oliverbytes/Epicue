#include "PostHttp.hpp"

#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QSslConfiguration>
#include <QUrl>
#include <QtNetwork/QtNetwork>

PostHttp::PostHttp(QObject* parent)
    : QObject(parent)
    , m_networkAccessManager(new QNetworkAccessManager(this))
{
}

void PostHttp::login
		(
			const QByteArray &username,
			const QByteArray &password
		)
{
    const QUrl url("http://epicue.kellyescape.com/includes/webservices/login.php");
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

    QNetworkReply* reply = m_networkAccessManager->post(request, multiPart);

    bool ok = connect(reply, SIGNAL(finished()), this, SLOT(onGetReply()));
    Q_ASSERT(ok);
    Q_UNUSED(ok);

}

void PostHttp::registeruser
		(
			const QByteArray &username,
			const QByteArray &password,
			const QByteArray &email
		)
{
    const QUrl url("http://epicue.kellyescape.com/includes/webservices/register.php");
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

void PostHttp::postTraffic
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
    const QUrl url("http://epicue.kellyescape.com/includes/webservices/createtraffic.php");
    QNetworkRequest request(url);
    //request.setHeader(QNetworkRequest::ContentTypeHeader, "text/plain");

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

void PostHttp::onGetReply()
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

