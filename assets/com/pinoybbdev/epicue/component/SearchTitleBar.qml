import bb.cascades 1.0

import ".."

TitleBar {
	id: _epicueTitleBar
	appearance: TitleBarAppearance.Plain
	scrollBehavior: TitleBarScrollBehavior.Sticky
	
	property bool expanded: false
	
	property variant navPane
	
	kind: TitleBarKind.FreeForm
	
	kindProperties: FreeFormTitleBarKindProperties {
	    id: _filterSection
	    
	    expandableArea.expanded: _epicueTitleBar.expanded
	    expandableArea.toggleArea: TitleBarExpandableAreaToggleArea.IndicatorOnly
	    expandableArea.indicatorVisibility: TitleBarExpandableAreaIndicatorVisibility.Hidden
		expandableArea.content: Container {
        	 preferredHeight: 300
             horizontalAlignment: HorizontalAlignment.Fill
             background: Color.DarkGray
             enabled: false
        }
		
        content: 
	    
		Container {
		    layout: DockLayout {}
            
            horizontalAlignment: HorizontalAlignment.Fill
            
		    preferredHeight: 124
			property int overlayHeight: 120

            background: Color.create("#F5931C")
		
			Container {
			    layout: StackLayout {
           			orientation: LayoutOrientation.RightToLeft
           		}
		
		        horizontalAlignment: HorizontalAlignment.Fill
		        verticalAlignment: VerticalAlignment.Center
		        
		        leftPadding: 10
		        rightPadding: leftPadding
		        topPadding: leftPadding
		        bottomPadding: leftPadding
                
//                Button {
//                    text: "Filters"
//                    
//                    horizontalAlignment: HorizontalAlignment.Right
//                    verticalAlignment: VerticalAlignment.Center
//                    
//                    maxWidth: 200
//                    
//                    scaleX: 0.85
//                    scaleY: 0.85
//                    
//                    leftMargin: 0
//                }
                
                Container {
                    layout: DockLayout {
                        
                    }
                    
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    
                    rightMargin: 0
                    
                    TextField {
                        id: searchTextField
                        hintText: "Search"
                        leftPadding: 60
                        
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        onTextChanged:
                        {
                            searchStores(searchTextField.text);
                        }
                    }
                    
                    ImageView {
                        imageSource: "asset:///images/app_icons/ic_search.png"
                        scaleX: 0.7
                        scaleY: 0.7
                        translationX: -10
                        horizontalAlignment: HorizontalAlignment.Left
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
                
                Button {
                    text: "Cancel"
                    visible: searchTextField.focused
                    maxWidth: 200
                    
                    onClicked: {
                        navPane.pop(_epicueTitleBar.parent)
                    }
                }
		    }
		}
	}
}