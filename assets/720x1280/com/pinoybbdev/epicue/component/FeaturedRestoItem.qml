import bb.cascades 1.0

Container {
    id: featuredRestoItem
    property alias imageSource: restoImage.imageSource
    property alias title: restoName.text
    
    layout: DockLayout {}

    preferredWidth: 604
    preferredHeight: 342
    
    maxWidth: preferredWidth
    maxHeight: preferredHeight

    background: Color.create("#E2E0D4")
    
    leftMargin: 10
    rightMargin: 10
    topMargin: 10
    bottomMargin: 10
    
    ActivityIndicator {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        preferredHeight: 150
        preferredWidth: 150
        visible: ListItemData.loading
        running: ListItemData.loading
    }
    
    ImageView {
        id: restoImage
        image: ListItemData.image
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        maxWidth: {
            return (featuredRestoItem.maxWidth - 4)
        }
        maxHeight: {
            return (featuredRestoItem.maxHeight - 4)
        }
        scalingMethod: ScalingMethod.AspectFill
    }
    
    Container {
        id: photoContainer
        layout: DockLayout {}
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Bottom
        
        leftPadding: 2
        rightPadding: leftPadding
        bottomPadding: leftPadding
        
        ImageView {
	        horizontalAlignment: HorizontalAlignment.Fill
	        verticalAlignment: VerticalAlignment.Bottom
	        imageSource: "asset:///images/photo_text_underlay.png"
	        maxHeight: {
                return (featuredRestoItem.preferredHeight / 2);
            }
	    }
	    
	    Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            
            leftPadding: 10
            rightPadding: leftPadding
            bottomPadding: 10

            Label {
                id: restoName
                text: ListItemData.name
		        textStyle.color: Color.create("#FEFEFE")
		        textStyle.fontWeight: FontWeight.W100
		        textStyle.fontSize: FontSize.XLarge
		        
		        minWidth:  {
                    return (featuredRestoItem.preferredWidth - (photoContainer * 2)) 
		        }
		    }
		}
    }
}
