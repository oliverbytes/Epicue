import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0
import bb.system 1.0

Sheet {
    id: sheet
    peekEnabled: true
    
    property int times: 0;
    property bool postAfterLogin: false;
    property string postText: "TWITTER WORKS";
    
    onOpened: 
    {
        browser.storage.clearCache();
        browser.storage.clearCookies();
        browser.storage.clear();
        browser.url = epicueAPI.twauthurl();
    }
    
    onCreationCompleted: 
    {
        browser.storage.clearCache();
        browser.storage.clearCookies();
        browser.storage.clear();
    }
    
    Page {
        
        titleBar: TitleBar 
        {
            title: "Twitter Connect"
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

                    ActivityIndicator {
                        id: theloading
                        running: true
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                    }
                    
                    WebView 
                    {
                        id: browser;
                        //url: epicueAPI.twauthurl();
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
                                myapp.setSetting("twaccesstoken", message.data);
                            }
                            else if(times == 2)
                            {
                                myapp.setSetting("twaccesstokensecret", message.data);
                                
                                if(postAfterLogin)
                                {
                                    controller.postToTwitter(postText);
                                }
                                else 
                                {
                                    myapp.showToast("Twitter is now connected.");
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