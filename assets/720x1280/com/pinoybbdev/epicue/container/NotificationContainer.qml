import bb.cascades 1.0

import ".."

Container {
    id: _notificationArea
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    
    Container {
        layout: DockLayout {}
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
        ImageView {
            id: backgroundImage
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            imageSource: "asset:///images/notification_background.amd"
        }
        
        Container {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            preferredWidth: 600
            
            scaleX: 0.9
            scaleY: 0.9
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                preferredWidth: 600
                
                Button {
                    text: "Log in"
                    
                    rightMargin: 0
                    
                    onClicked: {
                        loginSheet.open();
                        _notificationArea.translationY = -400
                        _notificationArea.visible = false
                    }
                    
                    attachedObjects: [
                        LoginSheet {
                            id: loginSheet
                        }
                    ]
                }
                
                Button {
                    text: "Sign up"
                    leftMargin: 0
                    
                    onClicked: {
                        registrationSheet.open();
                        _notificationArea.translationY = -400
                        _notificationArea.visible = false
                    }
                    
                    attachedObjects: [
                        RegistrationSheet {
                            id: registrationSheet
                        }
                    ]
                }
            }
            
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                preferredWidth: 600
                
                Button {
                    text: "Login with Facebook"
                    
                    preferredWidth: 600
                    
                    onClicked: {
                        facebookSheet.open();
                        _notificationArea.translationY = -400
                        _notificationArea.visible = false
                    }
                    
                    attachedObjects: [
                        FacebookSheet {
                            id: facebookSheet
                        }
                    ]
                }
            }
            
            Container {
                layout: DockLayout {
                    
                }
                
                horizontalAlignment: HorizontalAlignment.Fill
                
                topMargin: 30
                
                Label {
                    text: "Skip"
                    textStyle.color: Color.LightGray
                    maxWidth: 250
                    
                    horizontalAlignment: HorizontalAlignment.Right
                    
                    gestureHandlers: [
                        TapHandler {
                            onTapped: {
                                _notificationArea.translationY = -400
                                _notificationArea.visible = false
                            }
                        }
                    ]
                }
            }
        }
    }

    
    Container {
        layout: DockLayout {
        
        }
        preferredHeight: 18
        background: Color.create("#F59215")
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
        ImageView {
            imageSource: "asset:///images/arrow_up.png"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
        }
    }
}