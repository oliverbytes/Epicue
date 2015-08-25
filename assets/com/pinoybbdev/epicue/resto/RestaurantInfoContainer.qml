import bb.cascades 1.0

import "../container"

Container {
    id: _infoContainer
    
    property string restoName
    property int pointerPosition: 0
    
    layout: DockLayout {
    
    }
    
    translationY: -30
    topPadding: 5
    
    minHeight: 400
    
    SectionContainer {
        topBorderVisible: true
        translationY: 31
        fullWidth: true
        bottomMargin: 50
        
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        
        ImageView {
            id: pointer
            imageSource: {
                switch(Application.themeSupport.theme.colorTheme.style) {
                    case VisualStyle.Dark: return "asset:///images/section_border_pointer_dark.png";
                    default: return "asset:///images/section_border_pointer.png";
                }
            }
            translationX: pointerPosition
        }
    }

}
