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
        text: "Restaurant Menu"
        textStyle.color: Color.Gray
        textStyle.fontStyle: FontStyle.Italic
        textStyle.fontSize: FontSize.Small 
    }
    
    Container {
        layout: DockLayout {
        
        }
        
        translationY: 35
        horizontalAlignment: HorizontalAlignment.Fill
        
    }
}  