import bb.cascades 1.0

import "../component"
import "../container"

Container {
    horizontalAlignment: HorizontalAlignment.Fill
    
    touchPropagationMode: TouchPropagationMode.PassThrough
    
    topPadding: 20
    leftPadding: 12
    rightPadding: 12
    bottomPadding: 50
    
    Label {
        translationY: 35
        text: "Contact Details"
        textStyle.color: Color.Gray
        textStyle.fontStyle: FontStyle.Italic
        textStyle.fontSize: FontSize.Small 
    }
    
    Container {
        layout: DockLayout {
        
        }
        
        touchPropagationMode: TouchPropagationMode.PassThrough
        
        translationY: 35
        horizontalAlignment: HorizontalAlignment.Fill
        
        Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Top
            
            touchPropagationMode: TouchPropagationMode.PassThrough
            
            ContactInfoButton {
                id: phoneButton
				defaultImageSource: "asset:///images/resto_icons/ic_contact_phone_default.png"
                pressedImageSource: "asset:///images/resto_icons/ic_contact_phone_pressed.png"
                
                text: thedata.telnum
                
                onTouchCapture: {
                    myapp.invokeCall(thedata.telnum);
                }
                
                contextActions: [
                    ActionSet {
                        title: thedata.name
                        subtitle: "Phone: " + thedata.telnum
                        ActionItem {
                            title: "Call"
                            imageSource: "asset:///images/app_icons/ic_phone.png";
                            onTriggered: 
                            {
                                myapp.invokeCall(thedata.telnum);
                            } 
                        }
                        ActionItem {
                            title: "Copy"
                            imageSource: "asset:///images/app_icons/ic_copy.png"; 
                        }
                        ActionItem {
                            title: "Share"
                            imageSource: "asset:///images/app_icons/ic_share.png";
                        }
                    }
                ]
            }
            
            ContactInfoButton {
                defaultImageSource: "asset:///images/resto_icons/ic_contact_text_default.png"
                pressedImageSource: "asset:///images/resto_icons/ic_contact_text_pressed.png"
                text: thedata.telnum
                onTouchCapture: {
                    myapp.invokeSMS(thedata.telnum);
                }
            }
            
            ContactInfoButton {
                defaultImageSource: "asset:///images/resto_icons/ic_contact_email_default.png"
                pressedImageSource: "asset:///images/resto_icons/ic_contact_email_pressed.png"
                text: thedata.email
                onTouchCapture: 
                {
                    myapp.invokeEmail(thedata.email, "Inquiry", "");
                }
            }
            
            ContactInfoButton {
                id: webButton
                defaultImageSource: "asset:///images/resto_icons/ic_contact_browser_default.png"
                pressedImageSource: "asset:///images/resto_icons/ic_contact_browser_pressed.png"
                text: "http://sentro1771.net/"
                
                onTouchCapture: {
                    myapp.invokeBrowser(webButton.text);
                }
                
                contextActions: [
                    ActionSet {
                        title: thedata.name
                        subtitle: "Website: " + webButton.text
                        ActionItem {
                            title: "Open in Browser"
                            imageSource: "asset:///images/app_icons/ic_open_link.png" 
                            onTriggered: {
                                myapp.invokeBrowser(webButton.text);
                            }
                        }
                        ActionItem {
                            title: "Copy Link"
                            imageSource: "asset:///images/app_icons/ic_copy_link.png"; 
                        }
                        ActionItem {
                            title: "Share"
                            imageSource: "asset:///images/app_icons/ic_share.png";
                            
                            attachedObjects: [
                                
                                ActionItem {
                                    id: shareSiteActionItem
                                    imageSource: "asset:///images/app_icons/ic_share.png"
                                    title: "Share"
                                    ActionBar.placement: ActionBarPlacement.OnBar
                                    attachedObjects: [
                                        Invocation {
                                            id: invokeSite
                                            query {
                                                mimeType: "text/plain"
                                                invokeActionId: "bb.action.SHARE"
                                                invokerIncluded: true
                                                data: "Check out " + thedata.name + "'s website: " + webButton.text;
                                            }
                                        }
                                    ]
                                    onTriggered: {
                                        invokeSite.trigger("bb.action.SHARE")
                                    }
                                }
                            ] 
                        }
                    }
                ]
            }
        }
        
        
        Container {
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Top
            
            ContactSocialInfoButton {
                id: facebookButton
                type: "facebook"
                text: thedata.facebookid
                
                onTouchCapture: 
                {
                    myapp.invokeOpenWithFacebook(thedata.facebookid);
                }
            }
            
            ContactSocialInfoButton {
                type: "twitter"
                text: "@" + thedata.twitterid
                onTouchCapture: 
                {
                    myapp.invokeOpenWithTwitter(thedata.twitterid);
                }
            }
        }
    }
}