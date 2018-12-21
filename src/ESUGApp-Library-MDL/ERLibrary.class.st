Class {
	#name : #ERLibrary,
	#superclass : #WAFileLibrary,
	#category : #'ESUGApp-Library-MDL-ESUGApp-Library-MDL'
}

{ #category : #'as yet unclassified' }
ERLibrary class >> applicationName [

 ^ 'ESUG Application'

]

{ #category : #updating }
ERLibrary >> errorCss [
	^ '
.error {
  color: red
  }
  '
]

{ #category : #updating }
ERLibrary >> esugCss [
	^ self errorCss
]

{ #category : #updating }
ERLibrary >> esugJs [
	^ self validatorOfRegister , self validatorForLogin, self tabsJs
]

{ #category : #updating }
ERLibrary >> generalCss [
	^ '#all {
	margin: 0px;
	padding: 0px;
}
html, body {
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

@media (max-width: 800px) and (min-width: 300px) {
	#card-heading{
		text-align: center;
	    font-weight: 600;
	    font-size: 25px;
	    height: 40px;
	    padding-top: 40px;
	    color: #092e44
	}

	html, body {
        height: 100%;
        width: 100%;
        padding: 0;
        margin: 0;
    }
}
'
]

{ #category : #updating }
ERLibrary >> loginCss [
	^ '
.body {
	background-image: url("../CssForLoginMDL/profile_city.jpg");
	background-size: cover;
	background-position: top center;
	overflow-x: hidden;
}

#login-conatiner{
	margin: auto;
}

.mdl-card, .mdl-card__supporting-text {
    overflow: inherit !important;
}


.mdl-card {
    overflow: visible !important;
    z-index: auto !important;
}


#login-fab {
	border-radius: 50%;
    height: 56px;
    margin: auto;
    min-width: 56px;
    width: 56px;
    overflow: hidden;
    background: rgba(158,158,158,.2);
    box-shadow: 0 1px 1.5px 0 rgba(0,0,0,.12), 0 1px 1px 0 rgba(0,0,0,.24);
    position: absolute;
    top: -30px;
    text-align: center;
    left: 0;
    right: 0;
}

#lock-icon{
	line-height: 56px;
}

.login-button {
  width: 100%;
  height: 40px;
  min-width: initial;
}

#card-heading{
	text-align: center;
    font-weight: 600;
    font-size: 32px;
    height: 40px;
    padding-top: 40px;
    color: #092e44
}

#forgotpassword{
	float: right;
}
'
]

{ #category : #updating }
ERLibrary >> registerCss [
	^ '.body-all {
	background-image: url("../CssForLoginMDL/profile_city.jpg");
	background-size: cover;
	background-position: center;
}

#login-conatiner{
	margin: auto;
}

.mdl-card-register {
		align-items: center;
    overflow: visible !important;
    z-index: auto !important;
		width: 80%;
}
.mdl-textfield{
	width: 100%;
}
#login-fab {
	border-radius: 50%;
    height: 56px;
    margin: auto;
    min-width: 56px;
    width: 56px;
    overflow: hidden;
    background: rgba(158,158,158,.2);
    box-shadow: 0 1px 1.5px 0 rgba(0,0,0,.12), 0 1px 1px 0 rgba(0,0,0,.24);
    position: absolute;
    top: -30px;
    text-align: center;
    left: 0;
    right: 0;
}

#lock-icon{
	line-height: 56px;
}

#login-button {
  width: 100%;
  height: 40px;
  min-width: initial;
}

#card-heading{
	text-align: center;
    font-weight: 600;
    font-size: 32px;
    height: 40px;
    padding-top: 40px;
    color: #092e44
}

#forgotpassword{
	float: right;
}
'
]

{ #category : #updating }
ERLibrary >> selectorsToInclude [
	^ Array with: 'registerCss' with: 'tabsCss' with: 'loginCss' with: 'generalCss' with: 'esugJs' with: 'esugCss'
]

{ #category : #updating }
ERLibrary >> tabsCss [
	^ '/*Vertical Tabs*/
.mdl-tabs__panel {
  display: none;
}
.vertical-mdl-tabs {
    margin-top: 30px;
}
.vertical-mdl-tabs .mdl-tabs__tab-bar {
    -webkit-flex-direction: column;
        -ms-flex-direction: column;
            flex-direction: column;
    padding-bottom: 35px;
    height: inherit;
    border-bottom: none;
      border-right: 1px solid rgba(10, 11, 49, 0.20);
}

.vertical-mdl-tabs .mdl-tabs__tab {
    width: 100%;
    height: 35px;
    line-height: 35px;
    box-sizing: border-box;
    letter-spacing: 2px;
}

.vertical-mdl-tabs .mdl-tabs__tab:hover {
  background: rgba(158, 158, 158, 0.34);
  color: white;
}

.vertical-mdl-tabs.mdl-tabs.is-upgraded a.mdl-tabs__tab.is-active {
    border-right: 3px solid #0b7bfb;
}
.vertical-mdl-tabs.mdl-tabs.is-upgraded .mdl-tabs__tab.is-active:after {
    content: inherit;
    height: 0;
}

.vertical-mdl-tabs.mdl-tabs.is-upgraded .mdl-tabs__panel.is-active, .mdl-tabs__panel {
    padding: 0 30px;
}

.vertical-mdl-tabs.mdl-tabs .mdl-tabs__tab {
    text-align: left;
}

.text-center {
  text-align: center;
}

.mdl-tabs.is-upgraded .mdl-tabs__tab.is-active {
   color: #0b7bfb;
}
'
]

{ #category : #'as yet unclassified' }
ERLibrary >> tabsJs [
	^ '$().ready(function() {$(''.btnNext'').click(function(){
	console.log("next");
	$(''.mdl-tabs__tab-bar > .is-active'').next(''a'').trigger(''click'');
});

  $(''.btnPrevious'').click(function(){
console.log("prev");
  $(''.mdl-tabs__tab-bar > .is-active'').prev(''a'').trigger(''click'');}); });'
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
