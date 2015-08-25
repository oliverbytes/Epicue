import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0

import "component"
import "container"

Sheet {
    id: sheet
    peekEnabled: true

    Page 
    {
        titleBar: SheetTitleBar 
        {
            title: "Edit Profile"
        }
        
        MainContainer 
        {
            Container 
            {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center  
                preferredWidth: 600
                preferredHeight: 720
                
                Header 
                {
                    title: "Required Infos"
                }
                
                TextField 
                {
                    id: email
                    hintText: "Email"
                    inputMode: TextFieldInputMode.EmailAddress
                    text: myapp.getSetting("user_email", "");
                }
                
                TextField 
                {
                    id: username
                    hintText: "Display Name"
                    text: myapp.getSetting("user_username", "");
                }
                
                TextField 
                {
                    id: password
                    hintText: "Password"
                    inputMode: TextFieldInputMode.Password
                    text: myapp.getSetting("user_password", "");
                }

                Header 
                {
                    title: "Extra Infos"
                }
                
                TextField 
                {
                    id: firstname
                    hintText: "First Name"
                    text: myapp.getSetting("user_firstname", "");
                }
                
                TextField 
                {
                    id: middlename
                    hintText: "Middle Name"
                    text: myapp.getSetting("user_middlename", "");
                }
                
                TextField 
                {
                    id: lastname
                    hintText: "Last Name"
                    text: myapp.getSetting("user_lastname", "");
                }

                DropDown 
                {
                	id: gender
                    title: "Gender"
                    selectedOption: (myapp.getSetting("user_gender", "") == "1" ? male : female)
                    
                	options: 
                	[
                	    Option 
                	    {
                	        id: male
                        	text: "Male"
                        },
                        Option 
                        {
                            id: female
                            text: "Female"
                        }
                	]
                }
                
                Button 
                {
                    text: "Save"
                    horizontalAlignment: HorizontalAlignment.Fill
                    onClicked: 
                    {
                        if
	                        (
	                            username.text.length > 0 && 
                                password.text.length > 0 && 
                                email.text.length > 0
	                        )
                        {
                            myapp.showProgressDialog("Saving Your Info", "Please wait...");
                            var thegender = (gender.selectedOption.text == "Male" ? "1" : "2");
                            controller.updateuser(myapp.getSetting("user_id", "0") ,username.text, password.text, email.text, firstname.text, middlename.text, lastname.text, myapp.getSetting("user_birthdate", "0"), thegender);
                        }
                        else
                        {
                            myapp.showDialog("Warning", "Required fields must not be blank.");
                        }
                    }
                    
                    attachedObjects: 
                    [
                        APIController 
                        {
                            id: controller
                            onComplete: 
                            {
                                if(response == "success")
                                {
                                    loadUser();
                                    myapp.hideProgressDialog();
                                    myapp.showToast("Successfully Updated Your Info");
                                    sheet.close();
                                }
                                else 
                                {
                                    myapp.showDialog("Warning", response);
                                }
                            }
                        }
                    ]
                }
            }
        }
    }
}