import bb.cascades 1.0

Container 
{
    preferredWidth: 1000
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill
    bottomPadding: 10.0
    topPadding: 10.0

    layout: StackLayout 
    {
        orientation: LayoutOrientation.LeftToRight
    }
  
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }

        layoutProperties: StackLayoutProperties {
            spaceQuota: 0.2
        }

        ActivityIndicator {
            preferredHeight: 100
            visible: ListItemData.loading
            running: ListItemData.loading
        }

        ImageView {
            preferredWidth: 200
            preferredHeight: 100
            scalingMethod: ScalingMethod.AspectFill
            image: ListItemData.image
            visible: ! ListItemData.loading
        }
        
        Label {
            verticalAlignment: VerticalAlignment.Bottom
            text: "Php " + ListItemData.price
            textStyle.fontSize: FontSize.XXSmall
            textStyle.fontWeight: FontWeight.Bold
            textStyle.color: Color.DarkCyan
        }
    }

    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }

        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }

        leftPadding: 10.0

        Label {
            text: ListItemData.name
            textStyle.fontSize: FontSize.XLarge
            textStyle.fontWeight: FontWeight.W100
        }

        Label {
            text: ListItemData.description
            textStyle.fontSize: FontSize.XXSmall
            textStyle.fontWeight: FontWeight.Normal
            textStyle.fontStyle: FontStyle.Italic
            multiline: true
        }
    }
}
