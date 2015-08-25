import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0
import bb.system 1.0

Sheet {
    id: sheet
    peekEnabled: true
    
    onOpened: 
    {
        browser.storage.clearCache();
        browser.storage.clearCookies();
        browser.storage.clear();
        browser.url = epicueAPI.fbauthurl();
    }
    
    property int times: 0;
    property bool postAfterLogin: false;
    property string postText: "FACEBOOK TEST";
    
    onCreationCompleted: 
    {
        browser.storage.clearCache();
        browser.storage.clearCookies();
        browser.storage.clear();
    }

    Page {
        
        titleBar: TitleBar 
        {
            title: "Facebook Connect"
            dismissAction: ActionItem 
            {
                title: "Cancel"
                onTriggered: {
                    sheet.close();
                }
            }
            
            acceptAction: ActionItem 
            {
                title: "Refresh"
                onTriggered: 
                {
                    browser.reload();
                }
            }
        }
        
        Container 
        {
            ScrollView 
            {
                Container 
                {
                    ActivityIndicator 
                    {
                        id: theloading
                        running: true
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                    
                    WebView 
                    {
                        id: browser;
                        //url: epicueAPI.fbauthurl();
    
                        attachedObjects: EpicueAPI 
                        {
                            id: epicueAPI
                        }
                        
                        onLoadingChanged: 
                        {
                            if(loadProgress == 100)
                            {
                                theloading.stop();
                            }
                        }
                        
                        onUrlChanged: 
                        {
                            theloading.start();
                        }
                        
                        onMessageReceived: 
                        {
                            times++;
                            
                            if(times == 1)
                            {
                                myapp.setSetting("fbuserid", message.data);
                            }
                            else if(times == 2)
                            {
                                myapp.setSetting("fbaccess_token", message.data);
                                
                                if(postAfterLogin)
                                {
                                    controller.postToFB(postText);
                                }
                                else 
                                {
                                    myapp.showToast("Facebook is now connected.");
                                    sheet.close();
                                }
                            }
                        }
                    }
                    
                    attachedObjects: APIController 
                    {
                        id: controller
                        onComplete:
                        {
                            sheet.close();
                            myapp.showToast("Successfully Posted");
                        }
                    }
                }         
            }
        }
    }
}