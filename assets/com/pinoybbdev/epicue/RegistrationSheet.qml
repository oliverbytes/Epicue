import bb.cascades 1.0
import Network.APIController 1.0
import bb.system 1.0

import "component"
import "container"

Sheet {
    id: registrationSheet
    peekEnabled: true
    property Sheet loginSheet
    function isFormValid() {
        var errorMessage = "";
        if (email.text.trim().length == 0) {
            errorMessage += "Email is required\n";
        }
        if (displayName.text.trim().length == 0) {
            errorMessage += "Display name is required\n";
        }

        if (password.text.trim().length == 0) {
            errorMessage += "Password is required\n";
        }

        if (confirmPassword.text.trim().length == 0) {
            errorMessage += "Confirm Password is required\n";
        }

        if (errorMessage.length == 0) {
            return true;
        } else {
            myapp.showDialog("Warning", errorMessage.toString());
            return false;
        }
    }
    Page {

        titleBar: SheetTitleBar {
            title: "Register"
            sheet: registrationSheet
        }
        
        MainContainer {
            
            Container {
                
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                preferredWidth: 600
                preferredHeight: 720
                
                TextField {
                    id: email
                    hintText: "Email"
                    inputMode: TextFieldInputMode.EmailAddress
                }
                
                TextField {
                    id: displayName
                    hintText: "Display Name"
                }
                
                TextField {
                    id: password
                    hintText: "Password"
                    inputMode: TextFieldInputMode.Password
                }
                
                TextField {
                    id: confirmPassword
                    hintText: "Confirm Password"
                    inputMode: TextFieldInputMode.Password
                }
                
                Button {
                    text: "Sign up"
                    horizontalAlignment: HorizontalAlignment.Fill
                    onClicked: {
                        if (isFormValid()) {
                            if (password.text.toString() == confirmPassword.text.toString()) {
                                myapp.showProgressDialog("Signing up....", "please wait..");
                                controller.registeruser(displayName.text, password.text, email.text);
                            } else {
                                myapp.showDialog("Error", "Passwords do not match");
                            }
                        }
                    
                    }
                    attachedObjects: [
                        APIController {
                            id: controller
                            onComplete: {
                                if (response.toString().indexOf("Sorry") == -1 || response.toString().indexOf("ERROR") == -1) {
                                    myapp.hideProgressDialog();
                                    myapp.showToast("Registration Successful");
                                    myapp.login(response)
                                    myapp.saveEpicueDisplayName(displayName.text);
                                    myapp.editor.savePersonalMessage("I just logged in Epicue");
                                    close();
                                    loginSheet.close();
                                    console.log(response);
                                } else {
                                    myapp.showToast(response);
                                }
                            }
                        }
                    ]
                }
            }
        }
    }
}