import bb.cascades 1.0

Container {    
    
    layout: DockLayout {}
    
    property real margins: 20
    
    ImageView {
        id: appBackground
        imageSource: {
            switch(Application.themeSupport.theme.colorTheme.style) {
                case VisualStyle.Dark: return "asset:///images/app_background_dark.png";
                default: return "asset:///images/app_background.png";
            }
        }
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Fill
    }
}
