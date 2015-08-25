import bb.cascades 1.0

Container {

	property alias imageSource: cueponImage.imageSource
	property alias text: cueponLabel.text
    
    horizontalAlignment: HorizontalAlignment.Center
    verticalAlignment: VerticalAlignment.Center
    
    leftMargin: 15
    rightMargin: 15
    
    ImageView {
        id: cueponImage
        
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        
        imageSource: "asset:///images/cuepon/cuepons_1.png";
        preferredWidth: 220
        scalingMethod: ScalingMethod.AspectFit
        
        bottomMargin: 10
    }
    
    Label {
        id: cueponLabel
        
        topMargin: 10
        
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        
        text: "Post"
        textStyle.fontSize: FontSize.XXSmall
        textStyle.fontWeight: FontWeight.W100
    }
}
