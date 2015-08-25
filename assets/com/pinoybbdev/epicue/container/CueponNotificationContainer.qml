import bb.cascades 1.0

//Temp
Container {
    preferredHeight: 500
    minHeight: 500
    
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    
    Container {
        layout: DockLayout {
        
        }
        
        ImageView {
            imageSource: "asset:///images/notification_background.amd"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            bottomMargin: 0
        }
        
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight 
            }
            
            topPadding: 30
            
            verticalAlignment: VerticalAlignment.Fill
            
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                preferredWidth: 350
                
                ImageView {
                    imageSource: "asset:///images/samples/queuer_card.png"
                    
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
            
            }
            
            Container {
                id: contentContainer
                horizontalAlignment: HorizontalAlignment.Fill
                    
                preferredWidth: 400
                
                Container {
                    
                    horizontalAlignment: HorizontalAlignment.Center
                    
                    Label {
                        text: "Congratulations!"
                        textStyle.color: Color.White
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    
                    Label {
                        text: "You have earned"
                        textStyle.color: Color.White
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.W100
                        horizontalAlignment: HorizontalAlignment.Center
                        bottomMargin: 0
                        bottomPadding: 0
                    }
                    
                    Label {
                        text: "QUEUER CARD"
                        textStyle.color: Color.White
                        textStyle.fontWeight: FontWeight.Bold
                        textStyle.fontSize: FontSize.XLarge
                        horizontalAlignment: HorizontalAlignment.Center
                        topMargin: 0
                        bottomMargin: 0
                    }
                    
                    Label {
                        text: "for posting Cues on 10 different"
                        multiline: true
                        textStyle.color: Color.White
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.W100
                        horizontalAlignment: HorizontalAlignment.Center
                        topMargin: 0
                        bottomMargin: 0
                    }
                    
                    Label {
                        text: "popular or heavy-traffic restaurants."
                        multiline: true
                        textStyle.color: Color.White
                        textStyle.fontSize: FontSize.XXSmall
                        textStyle.fontWeight: FontWeight.W100
                        horizontalAlignment: HorizontalAlignment.Center
                        topMargin: 0
                        bottomMargin: 0
                    }
                }
                
                
                Container {
                    layout: DockLayout {
                        
                    }
                    
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    topMargin: 25
                    
                    ImageView {
                        imageSource: "asset:///images/button_background_transluscent.amd"
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        
                        preferredHeight: 80
                    }
                    
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        
                        topPadding: 10
                        bottomPadding: 10
                        
                        Label {
                            text: "Rank #21 :"
                            multiline: true
                            textStyle.color: Color.Yellow
                            textStyle.fontSize: FontSize.XSmall
                            textStyle.fontWeight: FontWeight.Default
                            verticalAlignment: VerticalAlignment.Center
                            topMargin: 0
                            bottomMargin: 0
                        }
                        
                        Label {
                            text: "321 +10pts."
                            multiline: true
                            textStyle.color: Color.White
                            textStyle.fontSize: FontSize.XSmall
                            textStyle.fontWeight: FontWeight.W100
                            verticalAlignment: VerticalAlignment.Center
                            topMargin: 0
                            bottomMargin: 0
                        }
                        
                        ImageView {
                            imageSource: "asset:///images/arrow_right.png"
                            verticalAlignment: VerticalAlignment.Center
                        }
                        
                    }
                }
            }
        }
    }
    
    Container {
        layout: DockLayout {
        
        }
        preferredHeight: 18
        background: Color.create("#F59215")
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
        ImageView {
            imageSource: "asset:///images/arrow_up.png"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
        }
    }
}