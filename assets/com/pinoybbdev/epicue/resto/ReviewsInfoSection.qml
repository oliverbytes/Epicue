import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0

import "../component"
import "../container"

Container {
    horizontalAlignment: HorizontalAlignment.Fill
    
    topPadding: 20
    leftPadding: 12
    rightPadding: 12
    bottomPadding: 50
    
    Label {
        translationY: 35
        text: "Reviews"
        textStyle.color: Color.Gray
        textStyle.fontStyle: FontStyle.Italic
        textStyle.fontSize: FontSize.Small
        bottomMargin: 20.0

    }
    
    ActivityIndicator {
        id: loading
        preferredHeight: 100
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        visible: true
        running: true
        topMargin: 30
    }
    
    Label {
        id: info
        visible: false
        text: "No Reviews Yet"
        topMargin: 30
    }
    
    ListView  {
        id: listReviews
        dataModel: myapp.modelReviews
        objectName: "listReviews"
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

    attachedObjects: 
    [
	    APIController 
	    {
            id: controller
            onComplete: 
            {
                loading.running = false;
                loading.visible = false;
                
                if(response != "[]")
                {
                    listReviews.visible = true;
                    myapp.parseJSONReviews(response, "reviewsstore");
                }
                else 
                {
                    info.visible = true;
                }
            }
	    },
	    EpicueAPI 
	    {
	        id: epicueAPI
	    }
    ]
    
    onCreationCompleted: 
    {
        controller.getJSON(epicueAPI.getreviews_url() + "?itemtype=store&itemid="+thedata.id);
    }
}  