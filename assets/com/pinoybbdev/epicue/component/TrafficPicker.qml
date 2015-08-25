import bb.cascades 1.0

Container {
    id: _trafficPicker
    layout: DockLayout {
        
    }
    
    property int selectedLevel: 0
    property variant associatedColor: Color.create("#848484")
    
    property bool hasSelected: (selectedLevel > 0)
    
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    
    ImageView {
        imageSource: "asset:///images/drop_shadow_big.png"
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Top
        topMargin: 0
        topPadding: 0
    }
    
    onSelectedLevelChanged: {
        if (selectedLevel == 0) {
            associatedColor = Color.create("#848484")
        }
    }
    
    Container {
        id: trafficCont
        
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight 
        }   
        
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Top
        
        leftPadding: 5
        rightPadding: 5
        bottomPadding: 5
        
        TrafficPickerItem {
            id: level1
            level: 1
            associatedColor: Color.create("#2CCC88")
            imageSourceChecked: "asset:///images/post_traffic_level1.png"
            trafficImageSource: "asset:///images/traffic_level1_large.png"
            selected: {
                level1.level == _trafficPicker.selectedLevel
            }
            
            gestureHandlers: [
                TapHandler {
                    onTapped: {
                        if (_trafficPicker.selectedLevel != level1.level) {
                            _trafficPicker.selectedLevel = level1.level
                            _trafficPicker.associatedColor = level1.associatedColor
                        }
                    }                    
                }
            ]
        }
                
        TrafficPickerItem {
            id: level2
            level: 2
            associatedColor: Color.create("#FFDC22")
            imageSourceChecked: "asset:///images/post_traffic_level2.png"
            trafficImageSource: "asset:///images/traffic_level2_large.png"
            selected: {
                level2.level == _trafficPicker.selectedLevel
            }
            
            gestureHandlers: [
                TapHandler {
                    onTapped: {
                        if (_trafficPicker.selectedLevel != level2.level) {
                            _trafficPicker.selectedLevel = level2.level
                            _trafficPicker.associatedColor = level2.associatedColor
                        }
                    }
                }
            ]
        }
        
        TrafficPickerItem {
            id: level3
            level: 3
            associatedColor: Color.create("#DF3822")
            imageSourceChecked: "asset:///images/post_traffic_level3.png"
            trafficImageSource: "asset:///images/traffic_level3_large.png"
            selected: {
                level3.level == _trafficPicker.selectedLevel
            }
            
            gestureHandlers: [
                TapHandler {
                    onTapped: {
                        if (_trafficPicker.selectedLevel != level3.level) {
                            _trafficPicker.selectedLevel = level3.level
                            _trafficPicker.associatedColor = level3.associatedColor
                        }
                    }
                }
            ]
        }         
    }	    
}