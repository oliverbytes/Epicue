import bb.cascades 1.0
import Network.APIController 1.0

Page {
    

    ScrollView {
        Container 
        {
            Header {
                title: "BBM"
            }
            
            TextField {
                id: bbmstatus
                hintText: "BBM Personal Message"
            }
            
            Button {
                text: "post"
                onClicked: 
                {
                    myapp.editor.savePersonalMessage(bbmstatus.text);
                }
            }
            
            Header {
                title: "Facebook"
            }
            
            TextField {
                id: facebookStatus
                hintText: "Facebook Status"
            }
            
            Button {
                text: "post: " + myapp.isFacebookConnected();
                onClicked: 
                {
                    if(myapp.isFacebookConnected())
                    {
                        controller.postToFB(facebookStatus.text);
                    }
                    else 
                    {
                        // this text will be posted if the postAfterLogin = true, else sheet will only close
                        facebookSheet.postText = facebookStatus.text;
                        facebookSheet.postAfterLogin = true;
                        facebookSheet.open();
                    }
                }
            }
            
            Button {
                text: "connect"
                onClicked: 
                {
                    facebookSheet.open();
                }
            }
            
            Button {
                text: "logout"
                onClicked: 
                {
                    myapp.logoutFacebook();
                    myapp.showToast("done");
                }
            }
            
            Header {
                title: "Twitter"
            }
            
            TextField {
                id: twitterStatus
                hintText: "Twitter Status"
            }
            
            Button {
                text: "post: " + myapp.isTwitterConnected();
                onClicked: 
                {
                    if(myapp.isTwitterConnected())
                    {
                        controller.postToTwitter(twitterStatus.text);
                    }
                    else 
                    {
                        // this text will be posted if the postAfterLogin = true, else sheet will only close
                        twitterSheet.postText = twitterStatus.text;
                        twitterSheet.postAfterLogin = true;
                        twitterSheet.open();
                    }
                }
            }
            
            Button {
                text: "connect"
                onClicked: 
                {
                    twitterSheet.open();
                }
            }
            
            Button {
                text: "logout"
                onClicked: 
                {
                    myapp.logoutTwitter();
                    myapp.showToast("done");
                }
            }
            
            Header {
                title: "Cross Post"
            }
            
            Button {
                text: "post"
                onClicked: 
                {
                    if(myapp.isTwitterConnected() && myapp.isFacebookConnected())
                    {
                        controller.postToFB(twitterStatus.text);
                    }
                    else 
                    {
                        myapp.showToast("Not all is connected yet");
                    }
                }
            }
            
            Button {
                text: "logout all"
                onClicked: 
                {
                    myapp.logoutFacebook();
                    myapp.logoutTwitter();
                    myapp.logoutEpicue();
                    myapp.showToast("done");
                }
            }
            
            attachedObjects: 
            [
                APIController 
                {
                    id: controller
                    onComplete:
                    {
                        myapp.showToast("Successfully Posted");
                    }
                },
                FacebookSheet {
                    id: facebookSheet
                },
                TwitterSheet  {
                    id: twitterSheet
                }
            ]
        }
    }
}
