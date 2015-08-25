import bb.cascades 1.0

import "component"
import "container"

NavigationPane {
    id: accountNavPane
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
//                	ScrollView {
                	    Container {
                            
                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                
                                horizontalAlignment: HorizontalAlignment.Fill
                                
                                topPadding: 10
                                leftPadding: 15
                                rightPadding: 15
                                bottomPadding: 10
                                
                                Container {
                                    preferredHeight: 140
                                    preferredWidth: 140
                                    
                                    background: Color.White
                                    
                                    layout: DockLayout {
                                    }
                                    
                                    Container {
                                        preferredHeight: 140
                                        preferredWidth: 140
                                        
                                        background: Color.White
                                        layout: DockLayout {
                                        }
                                        
                                        Container {
                                            preferredWidth: 130
                                            preferredHeight: 130
                                            horizontalAlignment: HorizontalAlignment.Center
                                            verticalAlignment: VerticalAlignment.Center
                                            background: Color.create("#848484")
                                        }
                                        
                                        ImageView {
                                            imageSource: "asset:///images/app_icons/ic_epicue_account.png"
                                            maxHeight: 130
                                            maxWidth: 130
                                            horizontalAlignment: HorizontalAlignment.Center
                                            verticalAlignment: VerticalAlignment.Center
                                            scalingMethod: ScalingMethod.AspectFill
                                        }
                                    }
                                    
                                    leftMargin: 20
                                    rightMargin: 20
                                }
                                
                                Container {
                                    Label {
                                        text: "Guest"
                                        textStyle.fontSize: FontSize.Large
                                        bottomMargin: 0
                                    }
                                    
                                    Label {
                                        text: "No description"
                                        textStyle.fontSize: FontSize.XSmall
                                        textStyle.fontWeight: FontWeight.W100
                                        multiline: true
                                        topMargin: 0
                                        opacity: 0.5
                                    }
                                }
                            } 
                            
                            SectionContainer {
                                fullWidth: true
                                minHeight: 400
                                
                                Container {
                                    
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    
                                    Container {
                                        layout: DockLayout {
                                        
                                        }
                                        
                                        background: Color.create("#848484")
                                        
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        verticalAlignment: VerticalAlignment.Center
                                        
                                        bottomPadding: 0
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
                                            
                                            topPadding: 10
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
                                                
                                                topMargin: 10
                                                
                                                Container {
                                                    horizontalAlignment: HorizontalAlignment.Fill
                                                    
                                                    topMargin: 15
                                                    bottomMargin: 15
                                                    
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
                                                    
                                                    topMargin: 15
                                                    bottomMargin: 15
                                                    
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
//                }
            }
        }
    }
}
