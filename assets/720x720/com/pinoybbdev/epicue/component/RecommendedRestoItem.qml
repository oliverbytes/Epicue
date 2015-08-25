import bb.cascades 1.0

Container {
    id: featuredRestoItem
    
    property NavigationPane navigationPane
    
    layout: DockLayout {}
    
    preferredWidth: 248
    preferredHeight: preferredWidth
    
    leftMargin: 6
    rightMargin: 6
    topMargin: 6
    bottomMargin: 6
    
    ActivityIndicator {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        preferredHeight: 150
        preferredWidth: 150
        visible: ListItemData.loading
        running: ListItemData.loading
    }
    
    ImageView 
    {
        id: restoImage
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        preferredWidth: {
            return (featuredRestoItem.maxWidth - 2)
        }
        preferredHeight: {
            return (featuredRestoItem.maxHeight - 2)
        }
        scalingMethod: ScalingMethod.AspectFill
        loadEffect: ImageViewLoadEffect.FadeZoom
        image: ListItemData.image
        visible: ! ListItemData.loading
    }
    
    Container {
        layout: DockLayout {}
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Bottom
        
        leftPadding: 1
        rightPadding: leftPadding
        bottomPadding: leftPadding
        
        ImageView {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Bottom
            imageSource: "asset:///images/photo_text_underlay.png"
            maxHeight: {
                return (featuredRestoItem.maxHeight / 2);
            }
        }
        
        Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            
            leftPadding: 30
            rightPadding: leftPadding
            bottomPadding: 0
            
            Label {
                id: restoNameLabel
                textStyle.color: Color.create("#FEFEFE")
                textStyle.fontWeight: FontWeight.Normal
                textStyle.fontSize: FontSize.XSmall
                bottomMargin: 0
                text: ListItemData.name
            }
            
            Label {
                id: distanceLabel
                textStyle.fontSize: FontSize.XXSmall
                textStyle.color: Color.create("#FEFEFE")
                opacity: 0.5
                topMargin: 0
                translationY: -5
                text: ListItemData.distance
            }
        }	    
    }
    
    //RATINGS
    Container {
        
        horizontalAlignment: HorizontalAlignment.Left
        verticalAlignment: VerticalAlignment.Bottom
        
        leftPadding: 7
        rightPadding: leftPadding
        bottomPadding: 0
        
        ImageView {
            id: ratingsView
            
            imageSource: {
                if ((ListItemData.ratings > 4.75)) {
                    return "asset:///images/ratings_5_0.png"
                } else if ((ListItemData.ratings > 4.25)) {
                    return "asset:///images/ratings_4_5.png"
                } else if ((ListItemData.ratings > 3.75)) {
                    return "asset:///images/ratings_4_0.png"
                } else if ((ListItemData.ratings > 3.25)) {
                    return "asset:///images/ratings_3_5.png"
                } else if ((ListItemData.ratings > 2.75)) {
                    return "asset:///images/ratings_3_0.png"
                } else if ((ListItemData.ratings > 2.25)) {
                    return "asset:///images/ratings_2_5.png"
                } else if ((ListItemData.ratings > 1.75)) {
                    return "asset:///images/ratings_2_0.png"
                } else if ((ListItemData.ratings > 1.25)) {
                    return "asset:///images/ratings_1_5.png"
                } else if ((ListItemData.ratings > 0.75)) {
                    return "asset:///images/ratings_1_0.png"
                } else if ((ListItemData.ratings > 0.25)) {
                    return "asset:///images/ratings_0_5.png"
                } else {
                    return "asset:///images/ratings_0_0.png"
                }
            }
            scalingMethod: ScalingMethod.Fill
        }
    }
    
    //TRAFFIC
    Container {
        layout: DockLayout {}
        
        verticalAlignment: VerticalAlignment.Top
        horizontalAlignment: HorizontalAlignment.Right
        rightPadding: 10
        
        scaleX: 0.8
        scaleY: 0.8
        translationY: -14
        
        ImageView {
            imageSource: "asset:///images/home_traffic_background.png"
            verticalAlignment: VerticalAlignment.Bottom
        }
        
        ImageView {
            verticalAlignment: VerticalAlignment.Bottom
            imageSource: 
            {
                return "asset:///images/traffic_level"+ListItemData.trafficlevel+".png"
            }
            translationY: -1
        }
        
        ImageView {
            imageSource: "asset:///images/home_traffic_average.png"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            translationY: -40
            opacity: 0.5
            visible: ListItemData.averagestatus
        }
        
        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            translationY: -40
            opacity: 0.5
            
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            
            ImageView {
                imageSource: "asset:///images/home_traffic_clock.png"
                verticalAlignment: VerticalAlignment.Center
                
                rightMargin: 5
                rightPadding: 0
            }
            
            Label {
                verticalAlignment: VerticalAlignment.Center
                text: 
                {
                    return lapsedTime
                }
                
                maxWidth: 55
                
                textStyle.fontSize: FontSize.XXSmall
                textStyle.color: Color.White
                
                leftPadding: 0
                leftMargin: 5
            
            }
            
            visible: {
                return !ListItemData.averagestatus
            }
        }
    }
}
