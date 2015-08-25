import bb.cascades 1.0

Container {
	layout: DockLayout {}
    
    property bool topBorderVisible: false
    property bool fullWidth: false

    property alias backgroundVisible: backgroundImage.visible
    
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    
    minWidth: {
        if (fullWidth) {
            768
        }
    }
    
    ImageView {
        id: backgroundImage
    	horizontalAlignment: HorizontalAlignment.Fill
    	verticalAlignment: VerticalAlignment.Fill
        imageSource: {
            if (topBorderVisible) {
                switch(Application.themeSupport.theme.colorTheme.style) {
                    case VisualStyle.Dark: return "asset:///images/section_border_dark.amd";
                    default: return "asset:///images/section_border.amd";
                }
            } else {
                switch(Application.themeSupport.theme.colorTheme.style) {
                    case VisualStyle.Dark: return "asset:///images/section_border_blank_dark.amd";
                    default: return "asset:///images/section_border_blank.amd";
                }
            }
        }
    }
}
