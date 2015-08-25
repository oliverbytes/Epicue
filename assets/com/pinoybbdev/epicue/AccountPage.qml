import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0

import "component"
import "container"
import "resto"

NavigationPane {
    id: accountNavPane
    
    function loadUser()
    {
        if (myapp.isEpicueConnected()) 
        {
            controller.getJSON(epicueAPI.getusers_url() + "?id=" + myapp.getSetting("user_id", "none"));
        }
        else
        {
            displayName.text = "Guest";
            description.text = "None";
        }
    }
    
    function loadReviews()
    {
        loadingReviews.running = true;
        loadingReviews.visible = true;
        reviewsController.getJSON(epicueAPI.getreviews_url() + "?userid="+myapp.getSetting("user_id", ""));
    }
    
    function loadCues()
    {
        loadingCues.running = true;
        loadingCues.visible = true;
        cuesController.getJSON(epicueAPI.gettraffics_url() + "?userid="+myapp.getSetting("user_id", ""));
    }
    
    attachedObjects: 
    [
        APIController 
        {
            id: controller
            onComplete: 
            {
                myapp.parseJSONUser(response);
                displayName.text = myapp.getSetting("user_username", "none");
                description.text = myapp.getSetting("user_firstname", "") + " "+ myapp.getSetting("user_middlename", "") + " "+ myapp.getSetting("user_lastname", "");
            }
        },
        APIController 
        {
            id: reviewsController
            onComplete: 
            {
                loadingReviews.running = false;
                loadingReviews.visible = false;
                
                if(response != "[]")
                {
                    listReviewsMe.visible = true;
                    myapp.parseJSONReviews(response, "reviewsuser");
                }
                else 
                {
                    infoReviews.visible = true;
                }
            }
        },
        APIController 
        {
            id: cuesController
            onComplete: 
            {
                loadingCues.running = false;
                loadingCues.visible = false;
                
                if(response != "[]")
                {
                    listCuesMe.visible = true;
                    myapp.parseJSONTraffics(response);
                }
                else 
                {
                    infoCues.visible = true;
                }
            }
        },
        EpicueAPI 
        {
            id: epicueAPI
        }
    ]

    Page {
        id: cuesPage
        actions: [
            ActionItem 
            {
                id: postCueAction
                title: qsTr("Post a Cue")
                imageSource: "asset:///images/app_icons/ic_epicue_create_cue.png"
                onTriggered: {
                    cuesPage.openSearchPost(true);
                }
            },
            ActionItem 
            {
                id: searchAction
                title: qsTr("Search")
                imageSource: "asset:///images/app_icons/ic_search.png"
                onTriggered: {
                    cuesPage.openSearchPost(false);
                }
            },
            ActionItem 
            {
                id: refreshAction
                title: qsTr("Refresh")
                imageSource: "asset:///images/app_icons/ic_reload.png"
                onTriggered: 
                {
                	loadUser();
                }
            }
        ]

        function openSearchPost(postCueAction) 
        {
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
                                        text: myapp.getSetting("user_username", "Guest")
	                                    textStyle.fontSize: FontSize.XLarge
	                                    bottomMargin: 0
	                                }
	
	                                Label {
	                                    id: description
                                        text: myapp.getSetting("user_firstname", "") + " "+ myapp.getSetting("user_middlename", "") + " "+ myapp.getSetting("user_lastname", "");
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
	
	                                Container 
	                                {
	                                    layout: DockLayout 
	                                    {
	
	                                    }
	
	                                    background: Color.create("#848484")
	                                    horizontalAlignment: HorizontalAlignment.Fill
	                                    verticalAlignment: VerticalAlignment.Center
	                                    bottomPadding: 5
	                                    
	                                    Button 
	                                    {
	                                        text: "Edit Profile"
	                                        horizontalAlignment: HorizontalAlignment.Right
	                                        verticalAlignment: VerticalAlignment.Center
	                                        scaleX: 0.8
	                                        scaleY: 0.8
	                                        enabled: myapp.isEpicueConnected();
	                                        
	                                        onClicked: 
	                                        {
                                                editProfileSheet.open();   
	                                        }
	                                        
	                                        attachedObjects: EditProfileSheet 
	                                        {
                                            	id: editProfileSheet
                                            	
                                            	onClosed: 
                                            	{
                                                    loadUser();
                                                }
                                            }
	                                    }
	                                }
	
	                                SectionContainer 
	                                {
	                                    Container 
	                                    {
                                            horizontalAlignment: HorizontalAlignment.Center
                                            
                                            topPadding: 20
                                            bottomPadding: 20
                                              
                                            SegmentedControl 
                                            {
                                                id: activitiesControl
                                                horizontalAlignment: HorizontalAlignment.Center
                                                
                                                Option {
                                                    id: cuesOption
                                                    text: "Cues"
                                                    enabled: true
                                                }
                                                Option {
                                                    id: reviewsOption
                                                    text: "Reviews"
                                                    enabled: true
                                                }
                                                Option {
                                                    id: cueponsOption
                                                    text: "Cuepons"
                                                }
                                                
                                                selectedOption: cueponsOption
                                                
                                                onSelectedOptionChanged: 
                                                {
                                                    cues.visible = false;
                                                    reviews.visible = false;
                                                    cuepons.visible = false;
                                                    listReviewsMe.visible = false;
                                                    
                                                    if(selectedOption.text == "Cues")
                                                    {
                                                        loadCues();
                                                        cues.visible = true;
                                                    }
                                                    else if(selectedOption.text == "Reviews")
                                                    {
                                                        loadReviews();
                                                        reviews.visible = true;
                                                    }
                                                    else if(selectedOption.text == "Cuepons")
                                                    {
                                                        cuepons.visible = true;
                                                    }
                                                }
                                            }
                                            
                                            Container 
                                            {
                                                id: cues
                                                visible: false
                                                horizontalAlignment: HorizontalAlignment.Center
                                                
                                                ActivityIndicator 
                                                {
                                                    id: loadingCues
                                                    preferredHeight: 300
                                                    horizontalAlignment: HorizontalAlignment.Center
                                                    verticalAlignment: VerticalAlignment.Center
                                                    visible: true
                                                    running: true
                                                    topMargin: 30
                                                }
                                                
                                                Label {
                                                    id: infoCues
                                                    visible: false
                                                    text: "No Cues Yet"
                                                    topMargin: 30
                                                }
                                                
                                                ListView  
                                                {
                                                    id: listCuesMe
                                                    objectName: "listCuesMe"
                                                    rightPadding: 20.0
                                                    leftPadding: 20.0
                                                    preferredHeight: 400
                                                    topMargin: 50
                                                    visible: false
                                                    listItemComponents: 
                                                    [
                                                        ListItemComponent 
                                                        {
                                                            type: ""
                                                            CueItem 
                                                            {
                                                            
                                                            }
                                                        }
                                                    ]
                                                } 
                                            }
                                            
                                            Container 
                                            {
                                                id: reviews
                                                visible: false
                                                horizontalAlignment: HorizontalAlignment.Center
                                                
                                                ActivityIndicator 
                                                {
                                                    id: loadingReviews
                                                    preferredHeight: 300
                                                    horizontalAlignment: HorizontalAlignment.Center
                                                    verticalAlignment: VerticalAlignment.Center
                                                    visible: true
                                                    running: true
                                                    topMargin: 30
                                                }
                                                
                                                Label {
                                                    id: infoReviews
                                                    visible: false
                                                    text: "No Reviews Yet"
                                                    topMargin: 30
                                                }
                                                
                                                ListView  
                                                {
                                                    id: listReviewsMe
                                                    objectName: "listReviewsMe"
                                                    rightPadding: 20.0
                                                    leftPadding: 20.0
                                                    preferredHeight: 400
                                                    topMargin: 50
                                                    visible: false
                                                    listItemComponents: 
                                                    [
                                                        ListItemComponent 
                                                        {
                                                            type: ""
                                                            ReviewItem 
                                                            {
                                                            	
                                                            }
                                                        }
                                                    ]
                                                }  
                                            }
                                            
                                            Container {
                                                id: cuepons
                                                visible: false
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
	                                
	                                bottomPadding: 100
	                                
                                    Button 
                                    {
                                        id: facebookButton
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        topMargin: 50
                                        
                                        text: 
                                        {
                                            if(myapp.isFacebookConnected())
                                            {
                                                return "Disconnect Facebook";
                                            }
                                            else 
                                            {
                                                return "Connect with Facebook";
                                            }
                                        }
                                        
                                        onClicked: 
                                        {
                                            if(myapp.isFacebookConnected())
                                            {
                                                myapp.logoutFacebook();
                                                facebookButton.text = "Connect with Facebook";
                                                myapp.showToast("Facebook is now disconnected");
                                            }
                                            else 
                                            {
                                                facebookSheet.open();
                                            }
                                        }
                                        
                                        attachedObjects: [
                                            FacebookSheet {
                                                id: facebookSheet
                                                onClosed: 
                                                {
                                                    if(myapp.isFacebookConnected())
                                                    {
                                                        facebookButton.text = "Disconnect Facebook";
                                                    }
                                                    else 
                                                    {
                                                        facebookButton.text = "Connect with Facebook";
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                    
                                    Button {
                                        id: twitterButton
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        bottomMargin: 50
                                        
                                        text: 
                                        {
                                            if(myapp.isTwitterConnected())
                                            {
                                                return "Disconnect Twitter";
                                            }
                                            else 
                                            {
                                                return "Connect with Twitter";
                                            }
                                        }
                                        
                                        onClicked: 
                                        {
                                            if(myapp.isTwitterConnected())
                                            {
                                                myapp.logoutTwitter();
                                                twitterButton.text = "Connect with Twitter";
                                                myapp.showToast("Twitter is now disconnected");
                                            }
                                            else 
                                            {
                                                twitterSheet.open();
                                            }
                                        }
                                        
                                        attachedObjects: [
                                            TwitterSheet  {
                                                id: twitterSheet
                                                onClosed: {
                                                    if(myapp.isTwitterConnected())
                                                    {
                                                        twitterButton.text = "Disconnect Twitter";
                                                    }
                                                    else 
                                                    {
                                                        twitterButton.text = "Connect with Twitter";
                                                    }
                                                }
                                            }
                                        ]
                                    }
	                                
	                            }
	                        }
	                    }
	                }
                }
            }
        }
    }

    onCreationCompleted: 
    {
        loadUser();
    }
}