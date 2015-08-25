import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0

import "component"
import "container"

NavigationPane {
    id: accountNavPane
    
    function refresh(){
        console.log("myapp.getEpicueDisplayName(): " + myapp.getEpicueDisplayName());
        console.log("myapp.isEpicueConnected(): " + myapp.isEpicueConnected());
        if (myapp.getEpicueDisplayName() == 0 && myapp.isEpicueConnected()) {
            retrieveController.getJSON(epicueAPI.getusers_url(myapp.userid()));
        }else if(myapp.getEpicueDisplayName() != 0  && myapp.isEpicueConnected()){
            displayName.setText(myapp.getEpicueDisplayName());
        }else{
            displayName.setText("Guest");
        }
    }
    
    attachedObjects: [
        APIController {
            id: retrieveController
            onComplete: {
                console.log(response);
                myapp.parseJSONUser(response)
                displayName.setText(myapp.getModelUserName())
                myapp.saveEpicueDisplayName(myapp.getModelUserName());
            }
        },
        EpicueAPI {
            id: epicueAPI
        }
    ]

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

                }
            }
        ]

        function openSearchPost(postCueAction) {
            var nodePage = searchPostDef.createObject();
            nodePage.postCueAction = postCueAction;
            nodePage.navigationPane = accountNavPane;
            accountNavPane.push(nodePage);
        }

        attachedObjects: [
            ComponentDefinition {
                id: searchPostDef
                source: "SearchPage.qml"
            }
        ]

        titleBar: EpicueTitleBar {
            id: epicueTitleBar
            navPane: accountNavPane
        }

        MainContainer {
            ContentView {
                Container {
                	ScrollView {
	                    Container {
	
	                        Container {
	                            layout: StackLayout {
	                                orientation: LayoutOrientation.LeftToRight
	                            }
	
	                            horizontalAlignment: HorizontalAlignment.Fill
	
	                            topPadding: 30
	                            leftPadding: 30
	                            rightPadding: 30
	                            bottomPadding: 30
	
	                            Container {
	                                preferredHeight: 200
	                                preferredWidth: 200
	
	                                background: Color.White
	
	                                layout: DockLayout {
	                                }
	
	                                Container {
	                                    preferredHeight: 200
	                                    preferredWidth: 200
	
	                                    background: Color.White
	                                    layout: DockLayout {
	                                    }
	                                    Container {
	                                        preferredHeight: 200
	                                        preferredWidth: 200
	                                        
	                                        background: Color.White
	                                        layout: DockLayout {
	                                        }
	                                        
	                                        Container {
	                                            preferredWidth: 180
	                                            preferredHeight: 180
	                                            horizontalAlignment: HorizontalAlignment.Center
	                                            verticalAlignment: VerticalAlignment.Center
	                                            background: Color.create("#848484")
	                                        }
	                                        
	                                        ImageView {
	                                            imageSource: "asset:///images/app_icons/ic_epicue_account.png"
	                                            maxHeight: 180
	                                            maxWidth: 180
	                                            horizontalAlignment: HorizontalAlignment.Center
	                                            verticalAlignment: VerticalAlignment.Center
	                                            scalingMethod: ScalingMethod.AspectFill
	                                        }
	                                    }
	                                }
	
	                                leftMargin: 30
	                                rightMargin: 30
	                            }
	
	                            Container {
	                                Label {
	                                    id: displayName
	                                    text: "Guest"
	                                    textStyle.fontSize: FontSize.XLarge
	                                    bottomMargin: 0
	                                }
	
	                                Label {
	                                    text: "No Description"
	                                    textStyle.fontSize: FontSize.Small
	                                    textStyle.fontWeight: FontWeight.W100
	                                    textStyle.fontStyle: FontStyle.Italic
	                                    multiline: true
	                                    topMargin: 0
	                                }
	                            }
	                        }
	
	                        SectionContainer {
	                            fullWidth: true
	                            minHeight: 500
	
	                            Container {
	
	                                horizontalAlignment: HorizontalAlignment.Fill
	
	                                Container {
	                                    layout: DockLayout {
	
	                                    }
	
	                                    background: Color.create("#848484")
	
	                                    horizontalAlignment: HorizontalAlignment.Fill
	                                    verticalAlignment: VerticalAlignment.Center
	
	                                    bottomPadding: 5
	                                    Button {
	                                        text: "Edit Profile"
	                                        horizontalAlignment: HorizontalAlignment.Right
	                                        verticalAlignment: VerticalAlignment.Center
	                                        scaleX: 0.8
	                                        scaleY: 0.8
	                                        enabled: false;
	                                    }
	
	                                }
	
	                                SectionContainer {
	                                    Container {
                                            
                                            horizontalAlignment: HorizontalAlignment.Center
                                            
                                            topPadding: 20
                                            bottomPadding: 20
                                              
                                            SegmentedControl {
                                                id: activitiesControl
                                                horizontalAlignment: HorizontalAlignment.Center
                                                
                                                Option {
                                                    id: cuesOption
                                                    text: "Cues"
                                                    enabled: false
                                                }
                                                Option {
                                                    id: reviewsOption
                                                    text: "Reviews"
                                                    enabled: false
                                                }
                                                Option {
                                                    id: cueponsOption
                                                    text: "Cuepons"
                                                }
                                                
                                                selectedOption: cueponsOption
                                            }
                                            
                                            Container {
                                                id: selectedSegmentContainer
                                                horizontalAlignment: HorizontalAlignment.Center
                                                
                                                Container {
                                                    horizontalAlignment: HorizontalAlignment.Fill
                                                    
                                                    topMargin: 20
                                                    bottomMargin: 20
                                                    
                                                    layout: StackLayout {
                                                        orientation: LayoutOrientation.LeftToRight 
                                                    }
                                                    
                                                    CueponItem {
                                                        imageSource: "asset:///images/cuepon/cuepons_1.png";
                                                        text: "Single Post"
                                                    }
                                                    
                                                    CueponItem {
                                                        imageSource: "asset:///images/cuepon/cuepons_5.png";
                                                        text: "5 Posts"
                                                    }
                                                    
                                                    CueponItem {
                                                        imageSource: "asset:///images/cuepon/cuepons_10.png";
                                                        text: "10 Posts"
                                                    }
                                                }
                                                
                                                Container {
                                                    id: segmentContent
                                                    horizontalAlignment: HorizontalAlignment.Fill
                                                    
                                                    topMargin: 20
                                                    bottomMargin: 20
                                                    
                                                    layout: StackLayout {
                                                        orientation: LayoutOrientation.LeftToRight 
                                                    }
                                                    
                                                    CueponItem {
                                                        imageSource: "asset:///images/cuepon/cuepons_20.png";
                                                        text: "20 Posts"
                                                    }
                                                }
                                            }
                                        }
	                                }
	                            }
	                        }
	
	                    }
	                }
                }
            }
        }
    }

    onCreationCompleted: {
        console.log("Account Page" + "oncreationCompleted");
        refresh();
    }

}
