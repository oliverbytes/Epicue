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
    
    ListView  {
        id: listReviews
        dataModel: myapp.modelReviews
        objectName: "listReviews"
        rightPadding: 20.0
        leftPadding: 20.0
        preferredHeight: 800
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
            id: reviewscontroller
            onComplete: 
            {
                myapp.parseJSONReviews(response);
            }
	    },
	    EpicueAPI {
	        id: epicueAPI
	    }
    ]
    
    onCreationCompleted: 
    {
        reviewscontroller.getJSON(epicueAPI.getreviews_url() + "?itemtype=store&itemid="+thedata.id);
    }
}  