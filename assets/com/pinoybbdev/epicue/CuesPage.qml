import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0

import "component"
import "container"

NavigationPane {
    id: cuesNavPane

    Page {
        id: cuesPage
        
        actions: [
            ActionItem {
                id: postCueAction
                title: qsTr("Post a Cue")
                imageSource: "asset:///images/app_icons/ic_epicue_create_cue.png"
                onTriggered: {
                    cuesPage.openSearchPost(true);
                }
            },
            ActionItem {
                id: searchAction
                title: qsTr("Search")
                imageSource: "asset:///images/app_icons/ic_search.png"
                onTriggered: {
                    cuesPage.openSearchPost(false);
                }
            },
            ActionItem {
                id: refreshAction
                title: qsTr("Refresh")
                imageSource: "asset:///images/app_icons/ic_reload.png"
                onTriggered: {
                	loadLists();
                }
            }
//            ,
//            ActionItem 
//            {
//                title: "Post Test"
//                ActionBar.placement: ActionBarPlacement.InOverflow
//                onTriggered:
//                {
//                    var nodePage = postTest.createObject();
//                    //nodePage.navigationPane = cuesNavPane;
//                    cuesNavPane.push(nodePage);
//                }
//                
//                attachedObjects: 
//                [
//                    ComponentDefinition {
//                        id: postTest
//                        source: "PostTest.qml"
//                    }
//                ]
//            }
        ]
        
        function openSearchPost(postCueAction) {
            var nodePage = searchPostDef.createObject();
            nodePage.postCueAction = postCueAction;
            nodePage.navigationPane = cuesNavPane;
            cuesNavPane.push(nodePage);
        }
        
        attachedObjects: [
            ComponentDefinition {
                id: searchPostDef
                source: "SearchPage.qml"
            },
            NotificationContainer 
            {
                id: loginNotification
            }
        ]

        
        titleBar: EpicueTitleBar {
            id: epicueTitleBar
            navPane: cuesNavPane
            notification: loginNotification
            notificationVisible: 
            {
                return !myapp.isEpicueConnected();   
            }
        }
        
        MainContainer 
        {        
            ContentView 
            {
                Container 
                {
                    Container 
                    {
                        Header 
                        {
                            title: "Featured"
                        }
                        
                        SectionContainer 
                        {
                            
                            ActivityIndicator 
                            {
                                id: loadingFeatured
                                preferredHeight: 300
                                preferredWidth: 300
                                horizontalAlignment: HorizontalAlignment.Center 
                                verticalAlignment: VerticalAlignment.Center
                                running: false 
                                visible: false  
                            }
                            
                            preferredHeight: 300
                            
                            Container 
                            {
                                topPadding: 15
                                bottomPadding: 20
                                
                                ListView 
                                {
                                    id: listFeaturedItems;
                                    objectName: "listFeaturedItems";
                                    
                                    layout: StackListLayout 
                                    {
                                        orientation: LayoutOrientation.LeftToRight;
                                    }
                                    
                                    listItemComponents: 
                                    [
                                        ListItemComponent 
                                        {
                                            FeaturedRestoItem 
                                            {
                                            
                                            }
                                        }
                                    ]
                                    
                                    onTriggered: 
                                    {
                                        var page 		= restoPageDef.createObject();
                                        page.thedata 	= dataModel.data(indexPath);
                                        push(page);
                                    }
                                }   
                            }     
                        }   
                    }
                    
                    Container 
                    {
                        topMargin: 10
                        preferredHeight: 700
                        
                        Header 
                        {
                            title: "Check out these cues for your next epic eats"
                        }
                        
                        SectionContainer 
                        {
                            ActivityIndicator 
                            {
                                id: loadingRecommended
                                preferredHeight: 500
                                preferredWidth: 500
                                horizontalAlignment: HorizontalAlignment.Center 
                                verticalAlignment: VerticalAlignment.Center
                                running: false 
                                visible: false  
                            }
                            
                            ListView 
                            {
                                id: listRecommendedRestos
                                objectName: "listRecommendedRestos"
                                topPadding: 15
                                leftPadding: 6
                                rightPadding: 6
                                preferredHeight: 900
                                visible: false  
 
                                layout: GridListLayout 
                                {
                                    columnCount: 3
                                    headerMode: ListHeaderMode.None
                                }
                                
                                listItemComponents: 
                                [
                                    ListItemComponent 
                                    {
                                        id: itemComponent
                                        
                                        RecommendedRestoItem 
                                        {
                                            id: restoItem
                                            maxHeight: 300
                                            maxWidth: 300
                                            contextActions: 
                                            [
                                                ActionSet 
                                                {
                                                    title: restoItem.title
                                                    ActionItem {
                                                        id: postCueActionItem
                                                        title: "Post a Cue"
                                                        imageSource: "asset:///images/app_icons/ic_epicue_create_cue.png"
                                                        ActionBar.placement: ActionBarPlacement.OnBar
                                                        
                                                        onTriggered: {
                                                            postCueSheet.open();
                                                        }                
                                                    }
                                                    
                                                    ActionItem {
                                                        id: shareSiteActionItem
                                                        imageSource: "asset:///images/app_icons/ic_share.png"
                                                        title: "Share"
                                                        ActionBar.placement: ActionBarPlacement.OnBar
                                                        attachedObjects: [
                                                            Invocation {
                                                                id: invokeWeb
                                                                query {
                                                                    mimeType: "text/plain"
                                                                    invokeActionId: "bb.action.SHARE"
                                                                    invokerIncluded: true
                                                                    data: "Check out this resto " + restoItem.title + "! Looks like it's very popular!"
                                                                }
                                                            }
                                                        ]
                                                        onTriggered: {
                                                            invokeWeb.trigger("bb.action.SHARE")
                                                        
                                                        }
                                                    }
                                                }
                                            ]
                                        }
                                    }
                                ]
                                
                                onTriggered: 
                                {
                                    var page 			= restoPageDef.createObject();
                                    page.thedata 		= dataModel.data(indexPath);
                                    push(page);
                                }
                                
                                attachedObjects: [
                                    ComponentDefinition {
                                        id: restoPageDef
                                        source: "RestaurantPage.qml"
                                    },
                                    PostCueSheet {
                                        id: postCueSheet 
                                    }
                                ]
                            }
                        }
                    }
                }
            }
        }
    }
    
    function loadLists()
    {
        myapp.showProgressDialog("Loading Restaurants", "Please wait...");
        listRecommendedRestos.visible = false;
        listFeaturedItems.visible = false;
        
        console.log("XXXXXX=====" + storecontroller.userlatitude());
        
        if(storecontroller.userlatitude() == "0" || storecontroller.userlongitude() == "0")
        {
            storecontroller.getLocation();
        }
        else 
        {
            loadingRecommended.running = true;
            loadingRecommended.visible = true;
            
            loadingFeatured.running = true;
            loadingFeatured.visible = true;
            
            var url = epicueAPI.getstores_url() + "?userlatitude="+storecontroller.userlatitude()+"&userlongitude="+storecontroller.userlongitude(); 
            storecontroller.getJSON(url);
            
            var url = epicueAPI.getfeatured_url();
            featuredcontroller.getJSON(url);
        } 
    }
    
    attachedObjects: 
    [
        APIController {
            id: storecontroller
            onComplete: 
            {
                if(response != "[]")
                {
                    myapp.parseJSONStores(response, "store");
                }
                else
                {
                    myapp.showToast("No Restaurants within your location.");
                }
                
                loadingRecommended.running = false;
                loadingRecommended.visible = false;
                listRecommendedRestos.visible = true;
            }
            onGotLocation: 
            {
                myapp.hideProgressDialog();
                //myapp.showToast("Got your location. Please wait...");
                
                loadingRecommended.running = true;
                loadingRecommended.visible = true;
                
                loadingFeatured.running = true;
                loadingFeatured.visible = true;
                
                var url = epicueAPI.getstores_url() + "?userlatitude="+storecontroller.userlatitude()+"&userlongitude="+storecontroller.userlongitude(); 
                storecontroller.getJSON(url);
                
                var url = epicueAPI.getfeatured_url();
                featuredcontroller.getJSON(url);
            }
        },
        APIController {
            id: featuredcontroller
            onComplete: 
            {
                loadingFeatured.running = false;
                loadingFeatured.visible = false;
                listFeaturedItems.visible = true;
                
                if(response != "[]")
                {
                    myapp.parseJSONStores(response, "featured");
                }
                else
                {
                    myapp.showToast("No Featured Restaurants within your location.");
                }
            }
        },
        EpicueAPI {
            id: epicueAPI
        }
    ]
    
    onCreationCompleted: 
    {
        loadLists();
    }
}
