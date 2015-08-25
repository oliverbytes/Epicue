import bb.cascades 1.0
import bb.cascades.pickers 1.0
import bb.cascades.multimedia 1.0
import bb.system 1.0

import Network.APIController 1.0
import Network.EpicueAPI 1.0
import Network.PostHttp 1.0

import "component"
import "container"

Sheet {
    
    id: postCueSheet
    
    peekEnabled: false
    
    property real margins: 20
    property variant attachedPhotoSource: ""
    property bool fbPost: false;
    property bool twPost: false;
    property bool bbmPost: true;
    property bool fsPost: false;
    
    onOpened: 
    {
        fbPost = myapp.isFacebookConnected();
        twPost = myapp.isTwitterConnected();
    }
    
    onClosed: {
        trafficPicker.selectedLevel = 0
        timeCheckBox.checked = true
        attachedPhotoSource = ""
    }
    
    Page {
        
        titleBar: SheetTitleBar {
            title: "Post a Cue"
            sheet: postCueSheet
            acceptAction: ActionItem {
                title: "Cue!"
            }
        }
        
        MainContainer {
            
            ContentView {
                Container {
                    Container {
                        id: restoInfoContainer
                        leftPadding: postCueSheet.margins
                        rightPadding: postCueSheet.margins
                        bottomPadding: postCueSheet.margins
                        
                        Label {
                            id: restoNameLabel
                            text: thedata.name
                            textStyle.fontSize: FontSize.XLarge
                            textStyle.fontWeight: FontWeight.W100
                            bottomMargin: 0
                        }
                        
                        Label {
                            id: restoAddressLabel
                            text: thedata.address
                            textStyle.fontSize: FontSize.Small
                            textStyle.fontWeight: FontWeight.W100
                            topMargin: 0
                        }
                    
                    }
                    
                    SectionContainer {
                        id: trafficCommentContainer
                        
                        topBorderVisible: true
                        fullWidth: true
                        
                        Container {
                            
                            Container {
                                id: trafficContainer
                                
                                topPadding: postCueSheet.margins
                                leftPadding: postCueSheet.margins
                                rightPadding: postCueSheet.margins
                                bottomPadding: postCueSheet.margins
                                
                                background: trafficPicker.associatedColor
                                
                                Container {
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill
                                    
                                    Label {
                                        text: "How's the customer traffic?"
                                        textStyle.fontSize: FontSize.XSmall
                                        textStyle.fontWeight: FontWeight.W100
                                        textStyle.fontStyle: FontStyle.Italic
                                        textStyle.color: Color.White
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Bottom
                                        preferredWidth: 550
                                    }
                                    
                                    CheckBox {
                                        id: timeCheckBox
                                        text: "Now"
                                        enabled: true
                                        checked: true
                                        
                                        horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Center
                                    }    
                                }
                                
                                DateTimePicker {
                                    id: timePicker
                                    title: "When was this?"
                                    mode: DateTimePickerMode.DateTime
                                    horizontalAlignment: HorizontalAlignment.Right
                                    visible: !timeCheckBox.checked

                                    bottomMargin: 20
                                }
                            }
                            
                            TrafficPicker {
                                id: trafficPicker
                                bottomMargin: 10
                                topMargin: 0
                                topPadding: 0
                            }
                            
                            Divider {
                                topMargin: 0
                                bottomMargin: 0
                            }
                            
                            Container {
                                id: postCueButtonContainer
                                layout: StackLayout 
                                {
                                    orientation: LayoutOrientation.RightToLeft
                                }
                                
                                verticalAlignment: VerticalAlignment.Bottom
                                
                                topPadding: 20
                                leftPadding: 20
                                rightPadding: 20
                                bottomPadding: 20
                                
                                ImageButton {
                                    defaultImageSource: "asset:///images/post_cue_button.png"
                                    disabledImageSource: "asset:///images/post_cue_button_disabled.png"
                                    enabled: trafficPicker.hasSelected
                                    
                                    onClicked: 
                                    {
                                        myapp.showProgressDialog("Posting your cue", "Please wait...");
                                        
                                        if(postCueController.userlatitude() == "0" || postCueController.userlongitude() == "0")
                                        {
                                            postCueController.getLocation();
                                        }
                                        else 
                                        {
                                            postCueController.postTraffic(myapp.getSetting("user_id", "none"), thedata.id, trafficPicker.selectedLevel, comment.text, postCueController.userlongitude(), postCueController.userlatitude(), "");
                                        } 
                                    }
                                    
                                    attachedObjects: 
                                    [
                                        APIController 
                                        {
                                            id: postCueController
                                            onComplete: 
                                            {
                                                myapp.hideProgressDialog();
                                                
                                                if(fbPost == true)
                                                {
                                                    postFacebookController.postToFB(comment.text);
                                                }
                                                
                                                if(twPost == true)
                                                {
                                                    postTwitterController.postToTwitter(comment.text);
                                                }
                                                
                                                if(bbmPost == true)
                                                {
                                                    myapp.editor.savePersonalMessage(comment.text);
                                                }
                                                
                                                postCueSheet.close();
                                                myapp.showToast("Your cue has been posted");
                                            }
                                            onGotLocation: 
                                            {
                                                if(myapp.isEpicueConnected())
                                                {
                                                    postCueController.postTraffic(myapp.getSetting("user_id", "none"), thedata.id, trafficPicker.selectedLevel, comment.text, postCueController.userlongitude(), postCueController.userlatitude(), "");
                                                }
                                                else 
                                                {
                                                    myapp.hideProgressDialog();
                                                    postCueSheet.close();
                                                    myapp.showToast("Your cue has been posted");
                                                }
                                            }
                                        },
                                        APIController 
                                        {
                                            id: postFacebookController
                                        },
                                        APIController 
                                        {
                                            id: postTwitterController
                                        }
                                    ]
                                }
                                
                                Container {
                                    topPadding: 3
                                    
                                    TextArea {
                                        id: comment
                                        backgroundVisible: false
                                        hintText: "Tell us more about it"
                                        focusHighlightEnabled: true
                                        inputMode: TextAreaInputMode.Text
                                        minHeight: 200
                                        
                                        leftMargin: 0
                                        leftPadding: 0
                                        topMargin: 0
                                        topPadding: 0	 
                                    }
                                }
                            }						                    
                        }
                    
                    }
                    
                    
                    Container {
                        layout: DockLayout {
                            
                        }
                        
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        
                        topMargin: 10
                        rightPadding: 20
                        leftPadding: 20
                        
                        SectionContainer {
                            id: photoArea
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            
                            preferredWidth: 460
                            preferredHeight: 250
                            
                            ImageView {
                                id: attachedPhoto
                                
                                property alias photoAttached: attachedPhoto.visible 
                                
//                                imageSource: "asset:///images/samples/recommended_7.jpg"
                                
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                                
                                scalingMethod: ScalingMethod.AspectFill
                                
                                preferredHeight: photoArea.preferredHeight - postCueSheet.margins - 6
                                preferredWidth: photoArea.preferredWidth - postCueSheet.margins
                                
                                translationY: -2
                                
                                visible: false
                            }
                            
                            ImageView {
                                id: photoPlaceholder
                                imageSource: "asset:///images/post_cue_add_photo.png"
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                                
                                opacity: 
                                {
                                    if (attachedPhoto.photoAttached) 
                                    {
                                        return 0
                                    } 
                                    else 
                                    {
                                        return 1
                                    }
                                }
                                
                            }
                            
                            onTouchCapture: 
                            {
                                photoFilePicker.open()
                            }
                        }
                        
                        SectionContainer 
                        {
                            id: crossPostArea
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            preferredWidth: 255
                            preferredHeight: 250 
                            backgroundVisible: false
                            
                            CrossPostButton 
                            {
                                id: fbCrossPostButton
                                defaultImageSource: "asset:///images/social_facebook_enabled.png"
                                disabledImageSource: "asset:///images/social_facebook_disabled.png"
                                horizontalAlignment: HorizontalAlignment.Left
                                verticalAlignment: VerticalAlignment.Top
                                color: "#445d84"
                                colorToggledOn: "#5F83BA"
                                buttonToggled: myapp.isFacebookConnected();
                                buttonEnabled: myapp.isFacebookConnected();
                                onTouch: 
                                {
                                    if (event.isDown()) 
                                    {
                                        fbPost = !fbPost;
                                        fbCrossPostButton.buttonToggled = !fbCrossPostButton.buttonToggled;
                                    }
                                }
                            }
                            
                            CrossPostButton 
                            {
                                id: twCrossPostButton
                                defaultImageSource: "asset:///images/social_twitter_enabled.png"
                                disabledImageSource: "asset:///images/social_twitter_disabled.png"
                                horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Top
                                color: "#68b0d0"
                                colorToggledOn: "#7ED2F7"
                                buttonToggled: myapp.isTwitterConnected();
                                buttonEnabled: myapp.isTwitterConnected();
                                
                                onTouch:
                                {
                                    if (event.isDown())
                                    {
                                        twPost = !twPost;
                                        twCrossPostButton.buttonToggled = !twCrossPostButton.buttonToggled;
                                    }
                                }
                            }
                            
                            CrossPostButton 
                            {
                                id: bbmCrossPostButton
                                defaultImageSource: "asset:///images/social_bbm_enabled.png"
                                disabledImageSource: "asset:///images/social_bbm_disabled.png"
                                horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Bottom
                                color: "#333333";
                                buttonEnabled: true;
                                colorToggledOn: "#2E2E2E";
                                buttonToggled: true;
                                onTouch: 
                                {
                                    if (event.isDown()) 
                                    {
                                        bbmPost = !bbmPost;
                                        bbmCrossPostButton.buttonToggled = !bbmCrossPostButton.buttonToggled;
                                    }
                                }
                            }
                            
//                            CrossPostButton 
//                            {
//									id: fsCrossPostButton
//                                defaultImageSource: "asset:///images/social_foursquare_enabled.png"
//                                disabledImageSource: "asset:///images/social_foursquare_disabled.png"
//                                horizontalAlignment: HorizontalAlignment.Left
//                                verticalAlignment: VerticalAlignment.Bottom
//                                color: "#aac44a";
//                                buttonEnabled: false;
//                                colorToggledOn: "#7ED2F7";
//                                buttonToggled: false;
//                                onTouch: 
//                                {
//                                    if (event.isDown()) 
//                                    {
//                                        //buttonToggled = !buttonToggled;
//                                    }
//                                }
//                            }
                        }
                    }				        
                }    
            }         
        }
        
        actions: [
            ActionItem {
                id: cameraAction
                title: "Camera"
                imageSource: "asset:///images/app_icons/ic_camera.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: 
                {
                    if (camera.isCameraAccessible(CameraUnit.Rear)) 
                    {
                        camera.open(CameraUnit.Rear);
                    } 
                    else if (camera.isCameraAccessible(CameraUnit.Front)) 
                    {
                        camera.open(CameraUnit.Front);
                    }
                    else
                    {
                        console.log("no accessible cameras");
                    }
                }
            }
        ]
        
        attachedObjects: [
            FilePicker {
                id: photoFilePicker
                type: FileType.Picture
                title: "Select Photo"
                viewMode: FilePickerViewMode.GridView
                sortBy: FilePickerSortFlag.Date
                sortOrder: FilePickerSortOrder.Descending
                onFileSelected: {
                    attachedPhoto.imageSource = "file://" + selectedFiles[0];
                    attachedPhotoSource = "file://" + selectedFiles[0];
                    attachedPhoto.visible = true
                    console.log(attachedPhotoSource);
                } 
            },
            Camera {
                id: camera
                objectName: "cameraObj"
                onTouchCapture: {
                    camera.capturePhoto();
                }
                onPhotoCaptured: {
                    camera.close();
                }
            }
        ]
    }
}