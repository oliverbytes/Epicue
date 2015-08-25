#ifndef EPICUEAPI_HPP
#define EPICUEAPI_HPP

#include <QtCore/QObject>

class EpicueAPI : public QObject
{
    Q_OBJECT

public:
    EpicueAPI();

public Q_SLOTS:

	static QString epicueapp_url();
	static QString epicueapp_email();
	static QString epicueapp_number();
	static QString epicueapp_website();
	static QString searchurl();

    static QString protocol_url();
    static QString hostname_url();
    static QString apipath_url();
    static QString api_url();

    // TWITTER
	static QString twposturl();
	static QString twauthurl();

    // FACEBOOK
    static QString fbuserid();
    static QString fbredirecturi();
    static QString fbclientid();
    static QString fbclientsecret();
    static QString fbauthurl();
    static QString fbfeedsurl();

    // GET
    static QString getfeatured_url();
    static QString getusers_url();
    static QString getstores_url();
    static QString getstoretypes_url();
    static QString getstorepics_url();
    static QString getproducts_url();
    static QString getproducttypes_url();
    static QString getproductpics_url();
    static QString getreviews_url();
    static QString gettraffics_url();

    // CREATE
    static QString createuser_url();
	static QString createstore_url();
	static QString createstoretype_url();
	static QString createstorepic_url();
	static QString createproduct_url();
	static QString createproducttype_url();
	static QString createproductpic_url();
	static QString createreview_url();
	static QString createtraffic_url();

	// UPDATE
	static QString updateuser_url();
	static QString updatestore_url();
	static QString updatestoretype_url();
	static QString updatestorepic_url();
	static QString updateproduct_url();
	static QString updateproducttype_url();
	static QString updateproductpic_url();
	static QString updatereview_url();
	static QString updatetraffic_url();

	// DELETE
	static QString delete_url();

	// BLACKBERRY PUSH SERVICE
	static QString push_url();
	static QString pushAppID();
	static QString pushPassword();
	static QString pushPPGURL();

	// LOGIN
	static QString login_url();

	// REGISTER
	static QString register_url();

private:

};

#endif
