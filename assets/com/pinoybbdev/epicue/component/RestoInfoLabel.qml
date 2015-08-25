import bb.cascades 1.0

Container {
    property string type
    property alias label: _label.text
    property alias value: _value.text
    
    topMargin: 10
    bottomMargin: 10
    leftMargin: 10
    rightMargin: 10
    
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    
    Container {
        layout: DockLayout {
        
        }
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
        ImageView {
            id: labelBackground
            imageSource: "asset:///images/info_label_background.amd"
            
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Top
            
            maxHeight: 80
        }
        
        Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
            
            leftPadding: 20
            rightPadding: 20
            
            Label {
                id: _label
                
                textStyle.fontWeight: FontWeight.W600
                textStyle.fontSize: FontSize.Default
                textStyle.color: Color.White
            }
        }
    }


	Container {
    	layout: DockLayout {
         
        }
        
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
        ImageView {
            imageSource: "asset:///images/info_value_background.amd"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
        }
        
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            
            topPadding: 10
            leftPadding: 20
            rightPadding: 20
            bottomPadding: 10
            
            Label {
                id: _value
                textStyle.fontWeight: FontWeight.W100
                textStyle.fontSize: FontSize.Small
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
                multiline: true
            }
        } 
    }    
    
}
