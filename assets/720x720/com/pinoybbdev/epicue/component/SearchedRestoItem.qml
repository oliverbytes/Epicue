import bb.cascades 1.0

Container {
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Top
        
        background: Color.create("#FAFAFA")
        
        Divider {
            opacity: 0.2
        } 
        
    }
    
    Container {
        id: searchedItem
        horizontalAlignment: HorizontalAlignment.Fill
        preferredHeight: 160
        background: Color.create("#FAFAFA")
        
        topPadding: 10
        bottomPadding: 10
        rightPadding: 10
        leftPadding: 20
        
        layout: DockLayout {
        
        }
        
        property int trafficLevel: ListItemData.trafficlevel
        property bool averageStatus: true
        property variant lapsedTime
            
        Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
            
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            
            Container {
                id: photoContainer
                preferredHeight: 130
                preferredWidth: 130
                
                background: Color.create("#E0E0E0")
                
                rightMargin: 20
                
                verticalAlignment: VerticalAlignment.Center
                
                topPadding: 1
                bottomPadding: topPadding
                leftPadding: topPadding
                rightPadding: topPadding
                
                Container {
                    preferredHeight: photoContainer.preferredHeight - (photoContainer.topPadding + photoContainer.bottomPadding)
                    preferredWidth: photoContainer.preferredWidth - (photoContainer.leftPadding + photoContainer.rightPadding)
                    
                    background: Color.White
                    
                    layout: DockLayout {
                    
                    }
                    
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    
                    ActivityIndicator {
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 110
                        preferredWidth: 110
                        visible: ListItemData.loading
                        running: ListItemData.loading
                    }
                    
                    ImageView {
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        
                        image: ListItemData.image
                        
                        preferredHeight: 110
                        preferredWidth: 110
                    }
                }   
            }
            
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                Label {
                    text: ListItemData.name
                    bottomMargin: 0
                    topMargin: 0
                }
                
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    
                    Label {
                        text: "FILIPINO"
                        topMargin: 0
                        bottomMargin: 0
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.Bold
                        opacity: 0.5
                    }
                    
                    Label {
                        text: ListItemData.distance
                        topMargin: 0
                        bottomMargin: 0
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.W100
                        textStyle.fontStyle: FontStyle.Italic
                        opacity: 0.5
                    }
                }
                
                Rating {
                    scaleX: 0.6
                    scaleY: 0.6
                    translationX: -60 
                }
            }
        }
        
        Container {
            layout: DockLayout {}
            
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Right
            rightPadding: 30
            
            scaleX: 0.9
            scaleY: 0.9
            translationY: -20
            
            ImageView {
                imageSource: "asset:///images/home_traffic_background.png"
                verticalAlignment: VerticalAlignment.Bottom
            }
            
            ImageView {
                verticalAlignment: VerticalAlignment.Bottom
                imageSource: {
                    return "asset:///images/traffic_level"+ListItemData.trafficlevel+".png";
                }
                translationY: -1
            }
            
            ImageView {
                imageSource: "asset:///images/home_traffic_average.png"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                translationY: -40
                opacity: 0.5
                visible: searchedItem.averageStatus
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
                    text: {
                        return searchedItem.lapsedTime
                    }
                    
                    maxWidth: 55
                    
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.White
                    
                    leftPadding: 0
                    leftMargin: 5
                
                }
                
                visible: {
                    return !searchedItem.averageStatus
                }
            }
        }
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Bottom
        
        Divider {
            opacity: 0.5	
        } 
        
        background: Color.create("#FAFAFA")
    
    }
}