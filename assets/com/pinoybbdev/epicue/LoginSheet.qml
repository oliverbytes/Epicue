import bb.cascades 1.0
import Network.APIController 1.0
import Network.EpicueAPI 1.0
import bb.system 1.0

import "component"
import "container"
Sheet {
    id: loginSheet
    peekEnabled: true
    property Sheet registrationSheet

    function isFormValid() {
        var errorMessage = "";
        if (email.text.trim().length == 0) {
            errorMessage += "Email is required\n";
        }
        if (password.text.trim().length == 0) {
            errorMessage += "Password is required\n";
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
            title: "Login"
            sheet: loginSheet

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
                    id: password
                    hintText: "Password"
                    inputMode: TextFieldInputMode.Password
                }

                Button {
                    text: "Login"
                    horizontalAlignment: HorizontalAlignment.Fill
                    onClicked: 
                    {
                        if (isFormValid()) 
                        {
                            myapp.showProgressDialog("Logging in..", "Please wait...");
                            controller.login(email.text, password.text);
                        }
                    }

                    attachedObjects: [
                        APIController 
                        {
                            id: controller
                            onComplete: 
                            {
                                myapp.hideProgressDialog();

                                if (response.toString().indexOf("ERROR") == -1)
                                {
                                    myapp.parseJSONUser(response);
                                    myapp.showToast("Logged In Successfully");
                                    myapp.editor.savePersonalMessage("I just logged in Epicue");
                                    loginSheet.close();
                                } 
                                else 
                                {
                                    myapp.showToast(response);
                                }
                            }
                        }
                    ]
                }
                Label {
                    text: "Not yet registered?"
                    textStyle.color: Color.Blue
                    horizontalAlignment: HorizontalAlignment.Right
                    onTouch: 
                    {
                        registrationSheet.open();
                    }
                }
            }
        }
    }
}