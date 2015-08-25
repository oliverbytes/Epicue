import bb.cascades 1.0

import "component"
import "container"

Sheet {
    
    id: searchSheet
    
    peekEnabled: false
    
    property real margins: 20

    Page {
        
        titleBar: SheetTitleBar {
            title: "Search"
            sheet: searchSheet
            acceptAction: ActionItem {
                title: "Cue!"
            }
        }
        
        MainContainer {
            
            ContentView {
                Container {
                    
                }    
            }
        }
    }
}