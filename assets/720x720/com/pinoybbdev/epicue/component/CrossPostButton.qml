import bb.cascades 1.0

import "../container"

SectionContainer {
    fullWidth: false
    preferredHeight: 120
    preferredWidth: 120
    
    property alias buttonEnabled: iconButton.enabled
    property string color
    property alias defaultImageSource: iconButton.defaultImageSource
    property alias disabledImageSource: iconButton.disabledImageSource
    
    horizontalAlignment: HorizontalAlignment.Left
    verticalAlignment: VerticalAlignment.Top
    
    Container {
        id: overlay
        background: {
            if (buttonEnabled) {
                Color.create(color)       
            } else {
                Color.create("#e2e0d4")
            }
        }
        preferredWidth: 120
        preferredHeight: 116
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Top
    }
    
    ImageButton {
        id: iconButton
        defaultImageSource: "asset:///images/app_icons/ic_bbm.png"
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
    }

}