#include "EpicueAPI.hpp"
#include <QtCore/QtCore>

EpicueAPI::EpicueAPI(){}

QString EpicueAPI::epicueapp_url()
{
	return "appworld://content/20403171";
}

QString EpicueAPI::epicueapp_email()
{
	return "epicue_support@pinoybbdev.com";
}


QString EpicueAPI::epicueapp_number()
{
	return "+639467595887";
}

QString EpicueAPI::epicueapp_website()
{
	return "http://epicue.com";
}


QString EpicueAPI::searchurl()
{
	return api_url() + "search.php";
}

QString EpicueAPI::twposturl()
{
	QSettings settings;

	QString twaccesstoken = "0";

	if (!settings.value("twaccesstoken").isNull())
	{
		twaccesstoken = settings.value("twaccesstoken").toString();
	}

	QString twaccesstokensecret = "0";

	if (!settings.value("twaccesstokensecret").isNull())
	{
		twaccesstokensecret = settings.value("twaccesstokensecret").toString();
	}

	return api_url() + "twitteroauth/poststatus.php?access_token="+twaccesstoken+"&access_token_secret="+twaccesstokensecret;
}

QString EpicueAPI::twauthurl()
{
	return api_url() + "twitteroauth/connect.php";
}

QString EpicueAPI::fbuserid()
{
	return api_url() + "facebookoauth.php";
}

QString EpicueAPI::fbredirecturi()
{
	return api_url() + "facebookoauth.php";
}

QString EpicueAPI::fbclientid()
{
   return "676117652400921";
}

QString EpicueAPI::fbclientsecret()
{
   return "d2a36ad2becb2eb9ffdc3e327cd66e36";
}

QString EpicueAPI::fbauthurl()
{
   return "https://graph.facebook.com/oauth/authorize?client_id="+fbclientid()+"&scope=offline_access,publish_stream&redirect_uri="+fbredirecturi();
}

QString EpicueAPI::fbfeedsurl()
{
	QSettings settings;

	QString fbuserid = "0";

	if (!settings.value("fbuserid").isNull())
	{
		fbuserid = settings.value("fbuserid").toString();
	}

	QString fbaccess_token = "0";

	if (!settings.value("fbaccess_token").isNull())
	{
		fbaccess_token = settings.value("fbaccess_token").toString();
	}

   return "https://graph.facebook.com/"+fbuserid+"/feed?access_token="+fbaccess_token;
}

QString EpicueAPI::protocol_url()
{
   return "http://";
}

QString EpicueAPI::hostname_url()
{
   bool PROD = true;
   return PROD ? "epicue2.kellyescape.com" : "epicue.kellyescape.com" ;
}

QString EpicueAPI::apipath_url()
{
   return "/includes/webservices/";
}

QString EpicueAPI::api_url()
{
   return protocol_url() + hostname_url() + apipath_url();
}

//------------------- GET --------------------------//

QString EpicueAPI::getfeatured_url()
{
   return api_url() + "getfeatureditems.php?itemtype=store";
}

QString EpicueAPI::getusers_url()
{
   return api_url() + "getusers.php";
}

QString EpicueAPI::getstores_url()
{
   return api_url() + "getstores.php";
}

QString EpicueAPI::getstoretypes_url()
{
   return api_url() + "getstoretypes.php";
}

QString EpicueAPI::getstorepics_url()
{
   return api_url() + "getstorepics.php";
}

QString EpicueAPI::getproducts_url()
{
   return api_url() + "getproducts.php";
}

QString EpicueAPI::getproducttypes_url()
{
   return api_url() + "getproducttypes.php";
}

QString EpicueAPI::getproductpics_url()
{
   return api_url() + "getproductpics.php";
}

QString EpicueAPI::getreviews_url()
{
   return api_url() + "getreviews.php";
}

QString EpicueAPI::gettraffics_url()
{
   return api_url() + "gettraffics.php";
}

//------------------- CREATE --------------------------//

QString EpicueAPI::createuser_url()
{
   return api_url() + "createuser.php";
}

QString EpicueAPI::createstore_url()
{
   return api_url() + "createstore.php";
}

QString EpicueAPI::createstoretype_url()
{
   return api_url() + "createstoretype.php";
}

QString EpicueAPI::createstorepic_url()
{
   return api_url() + "createstorepic.php";
}

QString EpicueAPI::createproduct_url()
{
   return api_url() + "createproduct.php";
}

QString EpicueAPI::createproducttype_url()
{
   return api_url() + "createproducttype.php";
}

QString EpicueAPI::createproductpic_url()
{
   return api_url() + "createproductpic.php";
}

QString EpicueAPI::createreview_url()
{
   return api_url() + "createreview.php";
}

QString EpicueAPI::createtraffic_url()
{
   return api_url() + "createtraffic.php";
}

//------------------- DELETE --------------------------//

QString EpicueAPI::updateuser_url()
{
   return api_url() + "updateuser.php";
}

QString EpicueAPI::updatestore_url()
{
   return api_url() + "updatestore.php";
}

QString EpicueAPI::updatestoretype_url()
{
   return api_url() + "updatestoretype.php";
}

QString EpicueAPI::updatestorepic_url()
{
   return api_url() + "updatestorepic.php";
}

QString EpicueAPI::updateproduct_url()
{
   return api_url() + "updateproduct.php";
}

QString EpicueAPI::updateproducttype_url()
{
   return api_url() + "updateproducttype.php";
}

QString EpicueAPI::updateproductpic_url()
{
   return api_url() + "updateproductpic.php";
}

QString EpicueAPI::updatereview_url()
{
   return api_url() + "updatereview.php";
}

QString EpicueAPI::updatetraffic_url()
{
   return api_url() + "updatetraffic.php";
}

//------------------- DELETE --------------------------//

QString EpicueAPI::delete_url()
{
   return api_url() + "delete.php";
}

//------------------- PUSH --------------------------//

QString EpicueAPI::push_url()
{
   return api_url() + "push.php";
}

QString EpicueAPI::pushAppID()
{
	return "4170-5aa092r1ee29405f98r0oM4c08087126s06";
}

QString EpicueAPI::pushPassword()
{
   return "QU8was3NB";
}

QString EpicueAPI::pushPPGURL()
{
	return "http://cp4170-5aa092r1ee29405f98r0oM4c08087126s06.pushapi.eval.blackberry.com";
}

//------------------- LOGIN --------------------------//

QString EpicueAPI::login_url()
{
   return api_url() + "login.php";
}

//------------------- REGISTER --------------------------//

QString EpicueAPI::register_url()
{
   return api_url() + "register.php";
}
