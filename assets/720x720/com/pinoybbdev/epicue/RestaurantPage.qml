import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0

import "component"
import "container"
import "resto"

Page {
    id: _restoPage
    titleBar: EpicueTitleBar {
        id: epicueTitleBar
        navPane: navigationPane
    }
    
    property variant thedata;
    property variant theimage;
    
    property alias notificationVisible: notification.visible
    property RestoTabButton selectedInfo: genButton
    property variant createdControl
    property variant navigationPane
    
    actions: [
        ActionItem {
            id: shareActionItem
            imageSource: "asset:///images/app_icons/ic_share.png"
            title: "Share"
            ActionBar.placement: ActionBarPlacement.OnBar
            attachedObjects: [
                Invocation {
                    id: invoke
                    query {
                        mimeType: "text/plain"
                        invokeActionId: "bb.action.SHARE"
                        invokerIncluded: true
                        data: "Check out this resto " + restoNameLabel.text + "! Looks like it's very popular!"
                    }
                }
            ]
            onTriggered: {
                invoke.trigger("bb.action.SHARE")
            }
        },
        ActionItem {
            id: postCueActionItem
            title: "Post a Cue"
            imageSource: "asset:///images/app_icons/ic_epicue_create_cue.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                postCueSheet.open();
            }
        },
        ActionItem {
            id: trafficActionItem
            title: "Traffic"
            imageSource: "asset:///images/app_icons/ic_view_list.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                postCueSheet.open();
            }
        },
        ActionItem {
            id: addToContactsActionItem
            imageSource: "asset:///images/app_icons/ic_add_to_contacts.png"
            title: "Add to Contacts"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                myapp.invokeAddContact(thedata.telnum, thedata.email);
            }
        },
        ActionItem {
            id: refreshActionItem
            imageSource: "asset:///images/app_icons/ic_reload.png"
            title: "Refresh"
            ActionBar.placement: ActionBarPlacement.InOverflow
        }
    ]
    
    attachedObjects: [
        PostCueSheet {
            id: postCueSheet 
        },
        ComponentDefinition {
        	id: generalInfoDefinition
            source: "asset:///com/pinoybbdev/epicue/resto/GeneralInfoSection.qml"
        },
        ComponentDefinition {
            id: contactInfoDefinition
            source: "asset:///com/pinoybbdev/epicue/resto/ContactInfoSection.qml"
        },
        ComponentDefinition {
            id: locationInfoDefinition
            source: "asset:///com/pinoybbdev/epicue/resto/LocationInfoSection.qml"
        },
        ComponentDefinition {
            id: menuInfoDefinition
            source: "asset:///com/pinoybbdev/epicue/resto/MenuInfoSection.qml"
        },
        ComponentDefinition {
            id: reviewsInfoDefinition
            source: "asset:///com/pinoybbdev/epicue/resto/ReviewsInfoSection.qml"
        }
    ]
    
    MainContainer {
        id: mainContainer
        ScrollView {
            scrollViewProperties.scrollMode: ScrollMode.Vertical
            
            Container {
                
                NotificationContainer {
                    id: notification
                    visible: false
                }
                
//                translationY: -(notification.preferredHeight)
                
                SectionContainer {
                    preferredHeight: 120
                    fullWidth: true
                    
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        
                        ImageView {
                            image: thedata.image
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            scalingMethod: ScalingMethod.AspectFill
                        }
                        
                        bottomPadding: 5
                    }
                }
                
                Container {
                    id: restoInfoContainer
                    leftPadding: mainContainer.margins
                    rightPadding: mainContainer.margins
                    bottomPadding: mainContainer.margins
                    
                    Label {
                        id: restoNameLabel
                        text: thedata.name
                        textStyle.fontSize: FontSize.Large
                        textStyle.fontWeight: FontWeight.W600
                        bottomMargin: 0
                        textStyle.color: Color.DarkGray
                    }
                    
                    Label {
                        id: restoTypeLabel
                        text: thedata.storetypeid
                        textStyle.fontSize: FontSize.XSmall
                        textStyle.fontWeight: FontWeight.Bold
                        textStyle.color: Color.DarkGray
                        topMargin: 0
                        opacity: 0.4
                    }
                }
                
                //Menu/Tabs
                Container {
                	layout: DockLayout {
                     
                    }
                    
                    horizontalAlignment: HorizontalAlignment.Fill
                    
                    //tab buttons
                	SectionContainer {
                	    fullWidth: true
                	    
                    	horizontalAlignment: HorizontalAlignment.Fill
                    	verticalAlignment: VerticalAlignment.Top
                    	
                    	preferredHeight: 180
                    }
                	
                	//traffic/rating info
                	Container {
						layout: DockLayout {
          
          				}
                          
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        
                        
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            
                            ImageView {
                                imageSource: "asset:///images/drop_shadow.png"
                                translationY: trafficBar.preferredHeight - 1
                                horizontalAlignment: HorizontalAlignment.Fill
                            }
                        }
                        
						Container {
						    horizontalAlignment: HorizontalAlignment.Right
						    verticalAlignment: VerticalAlignment.Fill
						    
						    layout: DockLayout {
              
              				}
                            
                            rightPadding: 60
                            translationY: trafficBar.preferredHeight - 1
                            
                            Container {
                                layout: DockLayout {
                                    
                                }
                                
                                horizontalAlignment: HorizontalAlignment.Center
                                
                                ImageView {
                                    imageSource: "asset:///images/resto_traffic_level"+thedata.trafficlevel+".png"
                                }
                                
                                Container {
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    
                                    horizontalAlignment: HorizontalAlignment.Center
                                    
                                    ImageView {
                                        imageSource: "asset:///images/home_traffic_average.png"
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                    }
                                    
                                    translationX: -4
                                    visible: true
                                }
                                
                                Container {
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    
                                    visible: false
                                    horizontalAlignment: HorizontalAlignment.Center
                                    translationY: -5
                                    translationX: -4
                                    
                                    ImageView {
                                        imageSource: "asset:///images/home_traffic_clock.png"
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        scaleX: 0.75
                                        scaleY: 0.75
                                    }
                                    
                                    Label {
                                        text: "2s"
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        textStyle.fontSize: FontSize.XXSmall
                                        textStyle.color: Color.White
                                        textStyle.fontWeight: FontWeight.W100
                                        leftMargin: 0
                                        leftPadding: 0
                                    }
                                }
                                
                                ImageView {
                                    imageSource: "asset:///images/traffic_level"+thedata.trafficlevel+".png"
                                    horizontalAlignment: HorizontalAlignment.Center
                                    scaleX: 0.8
                                    scaleY: 0.8
                                    translationY: 23
                                    translationX: -4
                                }
                            }
                            
                           
          				}
					     	    
                	    Container {
                	        id: trafficBar
                        	layout: DockLayout {}
                        	
                            background: {
                            	if (thedata.trafficlevel == "1") {
                                    Color.create("#2CCC88");
                                } else if (thedata.trafficlevel == "2") {
                                    Color.create("#FFDC22");
                                } else if (thedata.trafficlevel == "3") {
                                    Color.create("#DF3822");
                                } else {
                                    Color.create("#848484");
                                }
                            }
                        	preferredHeight: 80
                            
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Top
                                
                            //ratings
                            Container {
                                layout: DockLayout {
                                
                                }
                                
                                horizontalAlignment: HorizontalAlignment.Left
                                verticalAlignment: VerticalAlignment.Center
                                
                                translationX: -10
                                
                                ImageView {
                                    imageSource: "asset:///images/button_background_transluscent.png"
                                    horizontalAlignment: HorizontalAlignment.Left
                                    verticalAlignment: VerticalAlignment.Center
                                }
                                
                                ImageView {
                                    imageSource: "asset:///images/ratings_resto_page/rating_horizontal_5_0.png"
                                    horizontalAlignment: HorizontalAlignment.Left
                                    verticalAlignment: VerticalAlignment.Center
                                }
                            }
                            
//                            Container {
//                                layout: DockLayout {}
//                                
//                                horizontalAlignment: HorizontalAlignment.Right
//                                verticalAlignment: VerticalAlignment.Center
// 
//								rightPadding: 15
//
//								ImageView {
//                                    imageSource: "asset:///images/button_background_white.amd"
//                                    horizontalAlignment: HorizontalAlignment.Fill
//                                    verticalAlignment: VerticalAlignment.Fill
//                                }
//								
//								Label {
//                                    text: "Post a Cue"
//                                    horizontalAlignment: HorizontalAlignment.Center
//                                    verticalAlignment: VerticalAlignment.Center
//                                    textStyle.fontWeight: FontWeight.W100
//            					}
//                                
//                                onTouchCapture: {
//                                    postCueActionItem.openPostCueSheet()
//                                }

                                Button {
                                    text: "Post a Cue"
                                    horizontalAlignment: HorizontalAlignment.Right
                                    verticalAlignment: VerticalAlignment.Center
                                    scaleX: 0.8
                                    scaleY: 0.8
                                    
                                    onClicked: {
                                        postCueActionItem.triggered()
                                    }
                                }
								
//                            }
                        }
                    }
                	
                	//Tab Menus
                	Container {
                	    id: infoTabs
                	    
                	    property int selectedTabIndex: 0
                	    
                    	layout: StackLayout {
                        	orientation: LayoutOrientation.LeftToRight 
                        }
                    	
                    	horizontalAlignment: HorizontalAlignment.Left
                    	verticalAlignment: VerticalAlignment.Bottom
                    	
                    	leftPadding: 30
                    	bottomPadding: 15
                    	
                        RestoTabButton {
                            id: genButton
                            imageSourceDefault: {
                                switch(Application.themeSupport.theme.colorTheme.style) {
                                    case VisualStyle.Dark: return "asset:///images/resto_icons/ic_tab_gen_info_dark.png";
                                    default: return "asset:///images/resto_icons/ic_tab_gen_info.png";
                                }
                            }
                            imageSourceSelected: "asset:///images/resto_icons/ic_tab_gen_info_selected.png"
                            index: 0
                            selected: (selectedInfo.index == index)
                            gestureHandlers: [
                                TapHandler {
                                    onTapped: {
                                        var same = (selectedInfo.index == genButton.index);
                                        selectedInfo = genButton;
                                        
                                        if (!same) {
                                            if (createdControl != null) {
                                                restaurantInfoContainer.remove(createdControl);    
                                            }
                                            
                                            createdControl = generalInfoDefinition.createObject(restaurantInfoContainer);
                                            restaurantInfoContainer.add(createdControl);
                                        }
                                    }
                                }
                            ]
                        }
                        
                        RestoTabButton {
                            id: contactButton
                            imageSourceDefault: {
                                switch(Application.themeSupport.theme.colorTheme.style) {
                                    case VisualStyle.Dark: return "asset:///images/resto_icons/ic_tab_contact_dark.png";
                                    default: return "asset:///images/resto_icons/ic_tab_contact.png";
                                }
                            }
                            imageSourceSelected: "asset:///images/resto_icons/ic_tab_contact_selected.png"
                            index: 1
                            selected: (selectedInfo.index == index)
                            gestureHandlers: [
                                TapHandler {
                                    onTapped: {
                                        var same = (selectedInfo.index == contactButton.index);
                                        selectedInfo = contactButton;
                                        
                                        if (!same) {
                                            if (createdControl != null) {
                                                restaurantInfoContainer.remove(createdControl);    
                                            }
                                            
                                            createdControl = contactInfoDefinition.createObject(restaurantInfoContainer);
                                            restaurantInfoContainer.add(createdControl);
                                        }           
                                    }
                                }
                            ]
                        }
                        
                        RestoTabButton {
                            id: locationButton
                            imageSourceDefault: {
                                switch(Application.themeSupport.theme.colorTheme.style) {
                                    case VisualStyle.Dark: return "asset:///images/resto_icons/ic_tab_location_dark.png";
                                    default: return "asset:///images/resto_icons/ic_tab_location.png";
                                }
                            }
                            imageSourceSelected: "asset:///images/resto_icons/ic_tab_location_selected.png"
                            index: 2
                            selected: (selectedInfo.index == index)
                            gestureHandlers: [
                                TapHandler {
                                    onTapped: {
                                        var same = (selectedInfo.index == contactButton.index);
                                        selectedInfo = locationButton;
                                        
                                        if (!same) {
                                            if (createdControl != null) {
                                                restaurantInfoContainer.remove(createdControl);    
                                            }
                                            
                                            createdControl = locationInfoDefinition.createObject(restaurantInfoContainer);
                                            restaurantInfoContainer.add(createdControl);
                                        }           
                                    }
                                }
                            ]
                        }
                        
                        RestoTabButton {
                            id: menuButton
                            imageSourceDefault: {
                                switch(Application.themeSupport.theme.colorTheme.style) {
                                    case VisualStyle.Dark: return "asset:///images/resto_icons/ic_tab_menu_dark.png";
                                    default: return "asset:///images/resto_icons/ic_tab_menu.png";
                                }
                            }
                            imageSourceSelected: "asset:///images/resto_icons/ic_tab_menu_selected.png"
                            index: 3
                            selected: (selectedInfo.index == index)
                            gestureHandlers: [
                                TapHandler {
                                    onTapped: {
                                        var same = (selectedInfo.index == contactButton.index);
                                        selectedInfo = menuButton;
                                        
                                        if (!same) {
                                            if (createdControl != null) {
                                                restaurantInfoContainer.remove(createdControl);    
                                            }
                                            
                                            createdControl = menuInfoDefinition.createObject(restaurantInfoContainer);
                                            restaurantInfoContainer.add(createdControl);
                                        }                                        
                                    }
                                }
                            ]
                        }
                        
                        RestoTabButton {
                            id: reviewsButton
                            imageSourceDefault: {
                                switch(Application.themeSupport.theme.colorTheme.style) {
                                    case VisualStyle.Dark: return "asset:///images/resto_icons/ic_tab_reviews_dark.png";
                                    default: return "asset:///images/resto_icons/ic_tab_reviews.png";
                                }
                            }
                            imageSourceSelected: "asset:///images/resto_icons/ic_tab_reviews_selected.png"
                            index: 4
                            selected: (selectedInfo.index == index)
                            gestureHandlers: [
                                TapHandler {
                                    onTapped: {
                                        var same = (selectedInfo.index == contactButton.index);
                                        selectedInfo = reviewsButton;
                                        
                                        if (!same) {
                                            if (createdControl != null) {
                                                restaurantInfoContainer.remove(createdControl);    
                                            }
                                            
                                            createdControl = reviewsInfoDefinition.createObject(restaurantInfoContainer);
                                            restaurantInfoContainer.add(createdControl);
                                        }           
                                    }
                                }
                            ]
                        }
                    }
                }
                
                RestaurantInfoContainer {
                    id: restaurantInfoContainer
                    restoName: thedata.name
                    pointerPosition: {
						var imageWidth = 81;
						var imageMargin = 30;
						var pointerMid = 21;
                        return (imageWidth * selectedInfo.index) + (imageMargin * (selectedInfo.index + 1)) + (imageWidth / 2) - pointerMid;
                    }
                }
            }   
        }
    }
    
    onCreationCompleted:
    {
        createdControl = generalInfoDefinition.createObject(restaurantInfoContainer);
        restaurantInfoContainer.add(createdControl);
    }
}