import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0

import "component"
import "container"

Page {
    id: _searchPage
    
    property bool postCueAction: false //true if regular search action
    property variant navigationPane
    
    titleBar: SearchTitleBar {
        id: searchTitleBar
        expanded: false
        navPane: navigationPane
    }
    
    onCreationCompleted: 
    {
        searchcontroller.getLocation();        
    }
    
    function searchStores(name)
    {
        loading.visible = true;
        loading.running = true;
        var url = epicueAPI.getstores_url() + "?userlatitude="+searchcontroller.userlatitude()+"&userlongitude="+searchcontroller.userlongitude()+"&name=" + name; 
        searchcontroller.getJSON(url);
    }
    
    attachedObjects: APIController 
    {
        id: searchcontroller
        onComplete: 
        {
            loading.visible = false;
            loading.running = false;
            myapp.parseJSONStores(response, "search");
        }
        onGotLocation: 
        {

            searchStores("");
        }
    }
    
    MainContainer {        
        ContentView {
            
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            
            Container {
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                ActivityIndicator {
                    id: loading
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 1000
                    preferredWidth: 1000
                    visible: false
                    running: false 
                }

                ListView {
                    id: listSearch
                    objectName: "listSearch"
                    dataModel: myapp.modelSearch
                    preferredHeight: 1000
                    listItemComponents: 
                    [
                        ListItemComponent 
                        {
                            id: itemComponent
                            SearchedRestoItem {}
                        }
                    ]

                    onTriggered: 
                    {
                        var page = restoPageDef.createObject();
                        page.thedata = dataModel.data(indexPath);
                        navigationPane.push(page);
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
