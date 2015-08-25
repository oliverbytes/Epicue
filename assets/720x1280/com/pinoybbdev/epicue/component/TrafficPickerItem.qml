import bb.cascades 1.0

Container {
    id: _trafficPickerItem
    layout: DockLayout {
    
    }
    
    property int level: 0
    property bool selected: false
    property variant associatedColor

    property url imageSourceChecked
    property alias trafficImageSource: trafficIndicator.imageSource
    
    ImageView {
        id: levelButton
        
        property url defaultImageSource: "asset:///images/post_traffic_unselected.png"
        
        rightPadding: 2
        rightMargin: 2
        leftPadding: 0
        leftMargin: 0
        
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Top
        
        imageSource: {
         	if (selected) {
                 imageSourceChecked
         	} else {
                 defaultImageSource
         	}
        }
    }
    
    ImageView {
        id: trafficIndicator
        
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        
        translationY: 5 + 1
    }
}