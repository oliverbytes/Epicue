import bb.cascades 1.0

TitleBar {
    id: _sheetTitleBar
    appearance: TitleBarAppearance.Plain
    scrollBehavior: TitleBarScrollBehavior.Sticky
    
    property Sheet sheet
    
    dismissAction: ActionItem {
        id: dismissItem
        title: "Cancel"
        function cancel() {
            sheet.close()
        }
        
    }
    
    kind: TitleBarKind.FreeForm
    kindProperties: FreeFormTitleBarKindProperties {
        content: 
        Container {
            layout: DockLayout {}
            
            preferredWidth: 720
            preferredHeight: 104
            
//            property alias title: sheetLabel.text	
//            property int overlayHeight: 100
            
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
            
//		    ImageView {
//		        id: titleBarBackground
//		        horizontalAlignment: HorizontalAlignment.Fill
//		        verticalAlignment: VerticalAlignment.Fill
//		        imageSource: "asset:///images/title_bar_background.png"
//		    }
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Fill
                
                background: Color.create("#F5931C")
                
                Button {
                    id: dismissButton
                    text: {
                        if (dismissAction != null) {
                            return dismissAction.title
                        }
                    }
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    preferredWidth: 200
                    scaleX: 0.8
                    scaleY: 0.8
                    visible: {
                        return (dismissAction != null);
                    }
                    
                    onClicked: {
                        dismissItem.cancel()
                    }
                }
                
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    
                    preferredWidth: {
                        return (720 - (dismissButton.visible ? dismissButton.preferredWidth : 0) - (acceptButton.visible ? acceptButton.preferredWidth : 0))
                    }
                    
                    Label {
                        id: sheetLabel
                        text: _sheetTitleBar.title
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.color: Color.White
                        textStyle.fontSize: FontSize.Large
                    }
                }
                
                Button {
                    id: acceptButton
                    
                    text: {
                        if (acceptAction != null) {
                            return acceptAction.title
                        }
                    }
                    
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                    preferredWidth: 200
                    scaleX: 0.8
                    scaleY: 0.8

                    visible: {
                        return (acceptAction != null);
                    }
                }
            }
        }
    }
	
}