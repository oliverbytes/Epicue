import bb.cascades 1.0

import "../component"
import "../container"

Container {
    horizontalAlignment: HorizontalAlignment.Fill
    
    topPadding: 20
    leftPadding: 12
    rightPadding: 12
    bottomPadding: 50
    
    Label {
        translationY: 35
        text: "General Information"
        textStyle.color: Color.Gray
        textStyle.fontStyle: FontStyle.Italic
        textStyle.fontSize: FontSize.Small 
    }
    
    Container {
//        layout: DockLayout {
//        
//        }
        
        translationY: 35
        horizontalAlignment: HorizontalAlignment.Fill
        
        RestoInfoLabel {
            label: "Type/Cuisine"
            value: "Filipino"
        }
        
        RestoInfoLabel {
            label: "Budget Range (per meal)"
            value: "PHP 150-300"
        }
        
        RestoInfoLabel {
            label: "Hours"
            value: "M, T, W, Th, Su: 8:00AM - 10:00PM\nF, Sa: 8:00AM - 11:00PM"
        }
        
        RestoInfoLabel {
            label: "Services"
            value: "Delivery, Wi-Fi"
        }
        
        RestoInfoLabel {
            label: "Amenities"
            value: "Conference Room"
        }
        
    }
}  