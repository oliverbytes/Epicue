import bb.cascades 1.0
import bb.cascades.maps 1.0
import QtMobility.sensors 1.2
import QtMobilitySubset.location 1.1
import bb.data 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0
import bb.system 1.0

import "com/pinoybbdev/epicue"

TabbedPane {
    id: tabpane
    showTabsOnActionBar: true
    
    Tab {
        id: cuesTab
        title: qsTr("Cues")
        imageSource: "asset:///images/app_icons/ic_epicue_cues.png"
        
        CuesPage {
        	
        }
    }

    Tab {
        id: meTab
        title: qsTr("Me")
        imageSource: "asset:///images/app_icons/ic_epicue_account.png"
        AccountPage 
        {
            id: accountPage
        }
    }

    attachedObjects: 
    [
        LoginSheet 
        {
            id: loginSheet
            registrationSheet: RegistrationSheet 
            {
                loginSheet: loginSheet
            }
            
            onClosed: 
            {
                if(myapp.isEpicueConnected())
                {
                    actionLogin.title = "Logout";
                }
            }
        },
        APIController 
        {
            id: locationUpdater
        }
    ]
    
    onCreationCompleted: 
    {
        var seconds = 10000;
        locationUpdater.startLocationUpdater(seconds);
    }

    Menu.definition: MenuDefinition {
        actions: [
            ActionItem {
                title: "About"
                imageSource: "asset:///images/darkicons/114.%20Info.png"
                onTriggered: 
                {
                    myapp.showDialog("About", "Epicue is the best app to find your next epic eats. Developed by PinoyBBDev.");
                }
            },
            ActionItem 
            {
                title: "Contact Us"
                imageSource: "asset:///images/darkicons/033.%20Mail.png"
                onTriggered: 
                {
                    myapp.invokeEmail(myapp.api.epicueapp_email(), "Customer Support", "")
                }
            },
            ActionItem 
            {
                title: "Rate our App"
                imageSource: "asset:///images/darkicons/025.%20Pencil.png"
                enabled: false 
                onTriggered:
                {
                    myapp.invokeBBWorld(myapp.api.epicueapp_url());
                }
            },
//            ActionItem 
//            {
//                title: "Settings"
//                imageSource: "asset:///images/darkicons/040.%20Settings.png"
//                onTriggered:
//                {
//                	myapp.invokeAddContact("09230323");
//                }
//            },
            ActionItem 
            {
                id: actionLogin
                title: myapp.isEpicueConnected() ? "Logout" : "Login"
                imageSource: "asset:///images/darkicons/007.%20Locked.png"
                ActionBar.placement: ActionBarPlacement.InOverflow
                onTriggered:
                {
                    if (actionLogin.title == "Login") 
                    {
                        loginSheet.open();
                    }
                    else if (actionLogin.title == "Logout")
                    {
                        myapp.showToast("You are now logged out.");   
                        actionLogin.title = "Login";
                        myapp.logoutEpicue();
                    }
                }
            }
        ]
    }
}
