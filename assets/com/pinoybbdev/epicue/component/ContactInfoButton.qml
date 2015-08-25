import bb.cascades 1.0

Container {
    property alias defaultImageSource: contactButton.defaultImageSource
    property alias pressedImageSource: contactButton.pressedImageSource
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
        id: imageView
        imageSource: "asset:///images/contact_container_background.png"
        horizontalAlignment: HorizontalAlignment.Left
        verticalAlignment: VerticalAlignment.Center
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        horizontalAlignment: HorizontalAlignment.Left
        verticalAlignment: VerticalAlignment.Center
        
        Container {
            layout: DockLayout {
            
            }
            
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
            
            ImageButton {
                id: contactButton
                
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
            }
        }
        
        Label {
            id: label
            textStyle.fontWeight: FontWeight.W100
            textStyle.fontSize: FontSize.Small
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
            leftMargin: 10
            
        }
    }
    
}
