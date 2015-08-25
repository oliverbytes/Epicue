#ifndef APICONTROLLER_HPP
#define APICONTROLLER_HPP

#include <QtCore/QObject>
#include <QtLocationSubset/QGeoPositionInfo>
#include <QtLocationSubset/QGeoPositionInfoSource>
#include <bb/platform/geo/GeoLocation>
#include <QTimer>

using QtMobilitySubset::QGeoPositionInfo;

class QNetworkAccessManager;

class APIController : public QObject
{
    Q_OBJECT
public:
    APIController(QObject* parent = 0);

    Q_INVOKABLE void startLocationUpdater(int secondsInterval);
    Q_INVOKABLE void stopLocationUpdater();
    Q_INVOKABLE void getLocationUpdater();
	Q_INVOKABLE void positionUpdatedUpdater(const QGeoPositionInfo & pos);
	Q_INVOKABLE void positionUpdateTimeoutUpdater();

    Q_INVOKABLE void getLocation();
	Q_INVOKABLE void positionUpdated (const QGeoPositionInfo & pos);
	Q_INVOKABLE void positionUpdateTimeout();
	Q_INVOKABLE double userlatitude();
	Q_INVOKABLE double userlongitude();

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
				const QByteArray &email,
				const QByteArray &password
			);

    void registeruser
			(
				const QByteArray &username,
				const QByteArray &password,
				const QByteArray &email
			);

    void updateuser
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
			);

    QString getJSON(const QString &url);
    void push(const QByteArray &message);
    void postToFB(const QByteArray &message);
    void postToTwitter(const QByteArray &message);
    void updateLocation();

Q_SIGNALS:
    void complete(const QString &response);
    void gotLocation(const double &latitude, const double &longitude);

private Q_SLOTS:
    void onGetReply();

private:
    QNetworkAccessManager* m_networkAccessManager;
    QTimer *locationTimer;

    double m_userlatitude;
	double m_userlongitude;
};

#endif
