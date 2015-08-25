import bb.cascades 1.0

import ".."

TitleBar {
	id: _epicueTitleBar
	appearance: TitleBarAppearance.Plain
	scrollBehavior: TitleBarScrollBehavior.Sticky
	
	kind: TitleBarKind.FreeForm

	property alias searchEnabled: searchButton.enabled
	property alias postCueEnabled: postButton.enabled
	
	property bool searchPageBelow: false

	property variant navPane
	
	property variant notification
	property bool notificationVisible
	
    function openSearchPost(postCueAction) 
    {
        if ((searchPageBelow) && (!postCueEnabled)) 
        {
         	navPane.pop();   
        } 
        else 
        {
	        var nodePage = searchPostDef.createObject();
	        nodePage.postCueAction = postCueAction;
	        nodePage.navigationPane = navPane;
	        navPane.push(nodePage);
	    }
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: searchPostDef
            source: "../SearchPage.qml"
        },
        ActionItem {
            id: searchActionItem
            title: "Search"
            imageSource: "asset:///images/app_icons/ic_epicue_cues.png"
            onTriggered: {
                onSearchClicked();
            }
        },
	 	ActionItem {
	 	    id: postCueActionItem
	 	    title: "Post a Cue"
	 	    imageSource: "asset:///images/app_icons/ic_epicue_create_cue.png"
            onTriggered: {
                onPostCueClicked();
            }
       	}   
	]
	
	kindProperties: FreeFormTitleBarKindProperties {
        id: expandedAreaProperties
	    expandableArea.indicatorVisibility: TitleBarExpandableAreaIndicatorVisibility.Hidden
	    expandableArea.content: notification
	    expandableArea.expanded: {
	        return (notificationVisible && (expandableArea.content.visible))
	    }
	    
	    content: 
		Container {
		    layout: DockLayout {}
		    
            horizontalAlignment: HorizontalAlignment.Fill
		    preferredHeight: 124
		
			property int overlayHeight: 120

            background: Color.create("#F5931C")
		
			Container {
			    layout: DockLayout {}
		
		        horizontalAlignment: HorizontalAlignment.Fill
		        verticalAlignment: VerticalAlignment.Fill
		        
		        leftPadding: 20
		        rightPadding: leftPadding
		        
		        ImageView {
		            id: epicueLogo
		            horizontalAlignment: HorizontalAlignment.Center
		            verticalAlignment: VerticalAlignment.Center
		            imageSource: "asset:///images/title_bar_logo.png"
		        }
		
		        ImageButton {
		            id: searchButton
		            horizontalAlignment: HorizontalAlignment.Left
		            verticalAlignment: VerticalAlignment.Top
		            defaultImageSource: "asset:///images/title_bar_search_button.png"
		            
		            onClicked: {
//                  		searchActionItem.triggered()
						openSearchPost(false)
                  	}
		        }
		
		        ImageButton {
		            id: postButton
		            horizontalAlignment: HorizontalAlignment.Right
		            verticalAlignment: VerticalAlignment.Top
		            defaultImageSource: "asset:///images/title_bar_post_button.png"
                    
                    onClicked: {
//                        postCueActionItem.triggered()	
                        
                        openSearchPost(true)
                    }
		        }
		    }
		}
	}
}