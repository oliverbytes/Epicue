import bb.cascades 1.0

Container {
    property string type
    property alias text: label.text
    
    layout: DockLayout {
        
    }
    
    topMargin: 10
    bottomMargin: 10
    leftMargin: 10
    rightMargin: 10
    
    horizontalAlignment: HorizontalAlignment.Center
    verticalAlignment: VerticalAlignment.Center
    
    ImageView {
        imageSource: "asset:///images/contact_social_container_background.png"
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Top
    }
    
    Container {
        layout: StackLayout {
            
        }
        
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Top
        
        Container {
            layout: DockLayout {
            
            }
            
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            
            ImageButton {
                defaultImageSource: {
                    if (type == "facebook") {
                        return "asset:///images/contact_social_facebook_background.png"
                    } else if (type == "twitter") {
                        return "asset:///images/contact_social_twitter_background.png"
                    } else {
                        return "asset:///images/contact_social_default_background.png"
                    }
                }
                
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
            }
            
            ImageView {
                id: contactIcon
                
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Top
            }
        }
        
        Label {
            id: label
            textStyle.fontWeight: FontWeight.W100
            textStyle.fontSize: FontSize.XXSmall
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
//            translationY: -5
        }
    }
    
}
