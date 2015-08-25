#ifndef POSTHTTP_HPP
#define POSTHTTP_HPP

#include <QtCore/QObject>

class QNetworkAccessManager;

class PostHttp : public QObject
{
    Q_OBJECT
public:
    PostHttp(QObject* parent = 0);

public Q_SLOTS:
    void postTraffic
    		(
				const QByteArray &userid,
				const QByteArray &storeid,
				const QByteArray &status,
				const QByteArray &comment,
				const QByteArray &longitude,
				const QByteArray &latitude,
				const QByteArray &picture
    		);

    void login
			(
				const QByteArray &username,
				const QByteArray &password
			);

    void registeruser
			(
				const QByteArray &username,
				const QByteArray &password,
				const QByteArray &email
			);

Q_SIGNALS:
    void complete(const QString &info);

private Q_SLOTS:
   void onGetReply();

private:
    QNetworkAccessManager* m_networkAccessManager;
};

#endif
