import bb.cascades 1.0

ScrollView {
    property int titleBarWidth: 0
    
    translationY: titleBarWidth
    
    scrollViewProperties {
        scrollMode: ScrollMode.Vertical
    }
    
}
