#ifndef IMAGELOADER_HPP
#define IMAGELOADER_HPP

#include <QByteArray>
#include <bb/cascades/Image>

class ImageLoader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)
    Q_PROPERTY(QVariant image READ image NOTIFY imageChanged)

    // ------------------------------ 1 ------------------------------------- //
    Q_PROPERTY(QString id READ id NOTIFY param1Changed)

    // ------------------------------ 2 ------------------------------------- //
    Q_PROPERTY(QString pending READ pending NOTIFY param2Changed)

    // ------------------------------ 3 ------------------------------------- //
    Q_PROPERTY(QString enabled READ enabled NOTIFY param3Changed)

    // ------------------------------ 4 ------------------------------------- //
    Q_PROPERTY(QString datetime READ datetime NOTIFY param4Changed)

    // ------------------------------ 5 ------------------------------------- //
    Q_PROPERTY(QString picture READ picture NOTIFY param5Changed)

    // ------------------------------ 6 ------------------------------------- //
    Q_PROPERTY(QString name READ name NOTIFY param6Changed)
    Q_PROPERTY(QString itemid READ itemid NOTIFY param6Changed)
    Q_PROPERTY(QString status READ status NOTIFY param6Changed)

    // ------------------------------ 7 ------------------------------------- //
    Q_PROPERTY(QString branchname READ branchname NOTIFY param7Changed)
    Q_PROPERTY(QString itemtype READ itemtype NOTIFY param7Changed)
    Q_PROPERTY(QString storeid READ storeid NOTIFY param7Changed)

    // ------------------------------ 8 ------------------------------------- //
    Q_PROPERTY(QString address READ address NOTIFY param8Changed)
    Q_PROPERTY(QString description READ description NOTIFY param7Changed)
    Q_PROPERTY(QString userid READ userid NOTIFY param7Changed)

    // ------------------------------ 9 ------------------------------------- //
    Q_PROPERTY(QString longitude READ longitude NOTIFY param9Changed)
    Q_PROPERTY(QString price READ price NOTIFY param9Changed)
    Q_PROPERTY(QString username READ username NOTIFY param9Changed)

    // ------------------------------ 10 ------------------------------------- //
    Q_PROPERTY(QString latitude READ latitude NOTIFY param10Changed)
    Q_PROPERTY(QString producttypeid READ producttypeid NOTIFY param9Changed)
    Q_PROPERTY(QString review READ review NOTIFY param9Changed)

    // ------------------------------ 11 ------------------------------------- //
	Q_PROPERTY(QString telnum READ telnum NOTIFY param11Changed)
	Q_PROPERTY(QString comment READ comment NOTIFY param9Changed)

	// ------------------------------ 12 ------------------------------------- //
	Q_PROPERTY(QString deliverynum READ deliverynum NOTIFY param12Changed)

	// ------------------------------ 13 ------------------------------------- //
	Q_PROPERTY(QString email READ email NOTIFY param13Changed)

	// ------------------------------ 14 ------------------------------------- //
	Q_PROPERTY(QString storetypeid READ storetypeid NOTIFY param14Changed)

	// ------------------------------ 15 ------------------------------------- //
	Q_PROPERTY(QString distance READ distance NOTIFY param15Changed)

	// ------------------------------ 16 ------------------------------------- //
	Q_PROPERTY(QString ratings READ ratings NOTIFY param16Changed)

	// ------------------------------ 17 ------------------------------------- //
	Q_PROPERTY(QString trafficlevel READ trafficlevel NOTIFY param17Changed)

	// ------------------------------ 18 ------------------------------------- //
	Q_PROPERTY(QString averagestatus READ averagestatus NOTIFY param18Changed)

	// ------------------------------ 19 ------------------------------------- //
	Q_PROPERTY(QString trafficlevel READ trafficlevel NOTIFY param19Changed)

	// ------------------------------ 20 ------------------------------------- //
	Q_PROPERTY(QString averagestatus READ averagestatus NOTIFY param20Changed)

	// ------------------------------ 21 ------------------------------------- //
	Q_PROPERTY(QString facebookid READ facebookid NOTIFY param21Changed)

	// ------------------------------ 22 ------------------------------------- //
	Q_PROPERTY(QString twitterid READ twitterid NOTIFY param22Changed)

	// ------------------------------ EXTRA ------------------------------------- //
	Q_PROPERTY(QString website READ website NOTIFY param22Changed)

public:
    ImageLoader
    	(
    		const QString &param1,
    		const QString &param2,
    		const QString &param3,
    		const QString &param4,
    		const QString &param5,
    		const QString &param6,
    		const QString &param7,
    		const QString &param8,
    		const QString &param9,
    		const QString &param10,
    		const QString &param11,
			const QString &param12,
			const QString &param13,
			const QString &param14,
			const QString &param15,
			const QString &param16,
			const QString &param17,
			const QString &param18,
			const QString &param19,
			const QString &param20,
			const QString &param21,
			const QString &param22,
    		QObject* parent = 0
    	);
    ~ImageLoader();
    void load();
    QString getUsername();

Q_SIGNALS:
    void imageChanged();
    void loadingChanged();

    void param1Changed();
    void param2Changed();
    void param3Changed();
    void param4Changed();
    void param5Changed();
    void param6Changed();
    void param7Changed();
	void param8Changed();
	void param9Changed();
	void param10Changed();
	void param11Changed();
	void param12Changed();
	void param13Changed();
	void param14Changed();
	void param15Changed();
	void param16Changed();
	void param17Changed();
	void param18Changed();
	void param19Changed();
	void param20Changed();
	void param21Changed();
	void param22Changed();

private Q_SLOTS:
    void onReplyFinished();
    void onImageProcessingFinished();

private:
    bool loading() const;
    QVariant image() const;

    // ------------------------------ 1 ------------------------------------- //
    QString id() const;

    // ------------------------------ 2 ------------------------------------- //
    QString pending() const;

    // ------------------------------ 3 ------------------------------------- //
    QString enabled() const;

    // ------------------------------ 4 ------------------------------------- //
    QString datetime() const;

    // ------------------------------ 5 ------------------------------------- //
    QString picture() const;

    // ------------------------------ 6 ------------------------------------- //
    QString name() const;
    QString itemid() const;
    QString status() const;

    // ------------------------------ 7 ------------------------------------- //
    QString branchname() const;
    QString itemtype() const;
    QString storeid() const;

    // ------------------------------ 8 ------------------------------------- //
    QString address() const;
    QString description() const;
    QString userid() const;

    // ------------------------------ 9 ------------------------------------- //
    QString longitude() const;
    QString price() const;
    QString username() const;

    // ------------------------------ 10 ------------------------------------- //
    QString latitude() const;
    QString producttypeid() const;
    QString review() const;

    // ------------------------------ 11 ------------------------------------- //
    QString telnum() const;
    QString comment() const;

    // ------------------------------ 12 ------------------------------------- //
    QString deliverynum() const;

    // ------------------------------ 13 ------------------------------------- //
    QString email() const;

    // ------------------------------ 14 ------------------------------------- //
    QString storetypeid() const;

    // ------------------------------ 15 ------------------------------------- //
    QString distance() const;

    // ------------------------------ 16 ------------------------------------- //
    QString ratings() const;

    // ------------------------------ 17 ------------------------------------- //
    QString trafficlevel() const;

    // ------------------------------ 18 ------------------------------------- //
    QString averagestatus() const;

    // ------------------------------ 19 ------------------------------------- //
	QString trafficcount() const;

	// ------------------------------ 20 ------------------------------------- //
	QString lasttrafficdatetime() const;

	// ------------------------------ 21 ------------------------------------- //
	QString facebookid() const;

	// ------------------------------ 22 ------------------------------------- //
	QString twitterid() const;

	// ------------------------------ EXTRA ------------------------------------- //
	QString website() const;

    // The property values
    bool m_loading;
    bb::cascades::Image m_image;

    QString m_param1; //
    QString m_param2; //
    QString m_param3; //
    QString m_param4; //
    QString m_param5; //
    QString m_param6; //
    QString m_param7; //
    QString m_param8; //
    QString m_param9; //
    QString m_param10; //
    QString m_param11; //
	QString m_param12; //
	QString m_param13; //
	QString m_param14; //
	QString m_param15; //
	QString m_param16; //
	QString m_param17; //
	QString m_param18; //
	QString m_param19; //
	QString m_param20; //
	QString m_param21; //
	QString m_param22; //

    // The thread status watcher
    QFutureWatcher<QImage> m_watcher;
};

#endif
