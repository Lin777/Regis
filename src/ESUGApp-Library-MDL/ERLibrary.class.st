Class {
	#name : #ERLibrary,
	#superclass : #WAFileLibrary,
	#category : #'ESUGApp-Library-MDL'
}

{ #category : #'as yet unclassified' }
ERLibrary class >> applicationName [

 ^ 'ESUG Application'

]

{ #category : #updating }
ERLibrary >> alertCss [
	^ '
.alert {
  color: red
  }
  '
]

{ #category : #updating }
ERLibrary >> closeAlertJs [
	^ '
	$(".close-alert").click(function(e){
  		$(this).parent().remove();
		e.preventDefault();
	});'
]

{ #category : #updating }
ERLibrary >> cssForHomePage [
	^ 'html, body {
  font-family: ''Roboto'', ''Helvetica'', sans-serif;
}

.demo-layout .mdl-layout__header .mdl-layout__drawer-button {
  color: white;
}

.demo-drawer {
  border: none;
}

.demo-drawer-header {
  box-sizing: border-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-flex-direction: column;
      -ms-flex-direction: column;
          flex-direction: column;
  -webkit-justify-content: flex-end;
      -ms-flex-pack: end;
          justify-content: flex-end;
  padding: 16px;
  height: 151px;
}

.demo-navigation {
  -webkit-flex-grow: 1;
      -ms-flex-positive: 1;
          flex-grow: 1;
}
.demo-layout .demo-navigation .mdl-navigation__link {
  display: -webkit-flex !important;
  display: -ms-flexbox !important;
  display: flex !important;
  -webkit-flex-direction: row;
      -ms-flex-direction: row;
          flex-direction: row;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
  color: white;
  font-weight: 500;
}
.demo-layout .demo-navigation .mdl-navigation__link:hover {
  background-color: #0b7bfc;
  color: white;
}
.active-link{
  background-color: #0b7bfc;
  color: white;
}
.demo-navigation .mdl-navigation__link .material-icons {
  font-size: 24px;
  color: white;
  margin-right: 32px;
}
'
]

{ #category : #updating }
ERLibrary >> esugCss [
	^ self cssForHomePage , self alertCss 
]

{ #category : #updating }
ERLibrary >> esugJs [
	^ self validatorOfRegister, self validatorForLogin , self closeAlertJs 
]

{ #category : #updating }
ERLibrary >> selectorsToInclude [
	^ Array with: 'esugJs' with: 'esugCss'
]

{ #category : #updating }
ERLibrary >> validatorForLogin [
	^ ' $().ready(function() {
	    $("#login-button").on("click", function(){
        $("#loginForm").validate();
        $("#emailLogin").rules("add", {
            required: true,
            email: true, 
            minlength: 8,
            maxlength:80,
            messages: {
                required: "Please enter your email", 
                email: "The format of email is incorrect", 
                minlenght: "The minimum number of characters allowed is 8", 
                maxlenght: "The maximum number of characters allowed is 80"
            }
        });
        $("#passwordLogin").rules("add", {
            required: true,
            messages:
            {
                required: "Please enter your password"
            } 
        });
    });
	});
'
]

{ #category : #updating }
ERLibrary >> validatorOfRegister [
	^ '
 $.validator.addMethod("valueNotEquals", function(value, element, arg){
  return arg !== value;
 }, "Value must not equal arg.");

	$().ready(function() {
    $("#formRegister").validate({
			ignore:"",
			
        rules:
        {
            "days[]": {required: true, maxlength:5}
        },
        messages:
        {
            "days[]": {required: "You must check at least 1 box", maxlength: "Check no more than {0} boxes"}
        }

    });
    $("#firstName").rules("add", {
        required: true,
        messages: {required: "Please enter your First Name"}
    });
    $("#lastName").rules("add", {
        required: true,
        messages: {required: "Please enter your Last Name"}
    });
    $("#email").rules("add", {
        required: true,
        email: true, 
        minlength: 8, 
        maxlength:30,
        messages: {
            required: "Please enter your email", 
            email: "The format of email is incorrect", 
            minlength: "The minimum number of characters allowed is 8", 
            maxlength: "The maximum number of characters allowed is 30"
        }
    });
    $("#password").rules("add", {
        required: true,
        minlength: 8, 
        messages: {
            required: "Please enter your password", 
            minlength: "Your password must have at least 8 characters"
        }
    });
    $("#confirmPassword").rules("add", {
        required: true,
        equalTo: "#password",
        messages: {
            required: "Please confirm your password", 
            equalTo: "Your password does not match"
        }
    });
    $("#address").rules("add", {
        required: true,
        messages: {
            required: "Please enter your contact Address"
        }
    });
    $("#country").rules(  "add", {
        valueNotEquals: "1",
           messages: {
                valueNotEquals: "Please select a Country" 
           } 
        }
    );
    $("#city").rules("add", {
        required: true,
        messages: {
            required: "Please enter your contact City"
        }
    });
    $("#province").rules("add", {
        required: true,
        messages: {
            required: "Please enter your contact Province/State"
        }
    });
    $("#postal").rules("add", {
        required: true,
        messages: {
            required: "Please enter your contact Postal/ZipCode"
        }
    });
    
    /*$("#facebookURL").rules("add", {
        required: true,
        messages: {}
    });
    $("#twitterURL").rules("add", {
        required: true,
        messages: {}
    });
    $("#homePage").rules("add", {
        required: true,
        messages: {}
    });

    $("days[]").rules("add", {
        required: true,
        maxlength:5,
        messages: {
            required: "You must check at least 1 box", 
            maxlength: "Check no more than {0} boxes"
        }
    });*/
    $("#orgName").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization Name"
        }
    });
    $("#orgAddress1").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization Address"
        }
    });
    $("#orgCity").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization City"
        }
    });
    $("#orgCountry").rules(  "add", {
        valueNotEquals: "1",
           messages: {
                valueNotEquals: "Please select a Country" 
           } 
        }
    );
    $("#orgProvince").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization Province"
        }
    });
    $("#orgPostal").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Code Postal of your Organization"
            }
    });
 });'
]

{ #category : #updating }
ERLibrary >> validatorOfRegisterAsGroupManager [
	^ ' $().ready(function() {
    $("#formRegisterAsGroup").validate({
    });
    $("#firstNameGM").rules("add", {
        required: true,
        messages: {required: "Please enter your First Name"}
    });
    $("#lastNameGM").rules("add", {
        required: true,
        messages: {required: "Please enter your Last Name"}
    });
    $("#registerEmailGM").rules("add", {
        required: true,
        email: true, 
        minlength: 8, 
        maxlength:30,
        messages: {
            required: "Please enter your email", 
            email: "The format of email is incorrect", 
            minlength: "The minimum number of characters allowed is 8", 
            maxlength: "The maximum number of characters allowed is 30"
        }
    });
    $("#registerPasswordGM").rules("add", {
        required: true,
        minlength: 8, 
        messages: {
            required: "Please enter your password", 
            minlength: "Your password must have at least 8 characters"
        }
    });
    $("#registerConfirmPasswordGM").rules("add", {
        required: true,
        equalTo: "#registerPasswordGM",
        messages: {
            required: "Please confirm your password", 
            equalTo: "Your password does not match"
        }
    });
    $("#organizationNameGM").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization Name"
        }
    });
    $("#organizationAddressGM").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization Address"
        }
    });
    $("#organizationCityGM").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization City"
        }
    });
    $("#organizationProvinceStateGM").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Organization Province"
        }
    });
    $("#organizationPostalGM").rules("add", {
        required: true,
        messages: {
            required: "Please enter your Code Postal of your Organization"
            }
    });

 });'
]
