"
Description
--------------------

I am a library for load Css files and JS files to ESUG page
"
Class {
	#name : #ERLibrary,
	#superclass : #WAFileLibrary,
	#category : #'ESUGApp-Library'
}

{ #category : #accessing }
ERLibrary class >> applicationName [ 
	^ 'ESUG'
]

{ #category : #css }
ERLibrary >> alertCss [
	^ '
	.errors {
		color: #c09853;
		background-color: #fcf8e3;
		border: 1px solid #fbeed5;
	}

	.alert-success {
		color: #468847;
		background-color: #dff0d8;
		border: 1px solid #d6e9c6;
	}
	
	.alert{
		padding: 8px 35px 8px 14px;
		margin-bottom: 18px;
		text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
		-webkit-border-radius: 4px;
		-moz-border-radius: 4px;
		border-radius: 4px;
	}
  '
]

{ #category : #css }
ERLibrary >> disabledCss [
	^ 'a[disabled="disabled"] {
        pointer-events: none;
		  color: currentColor;
  		  cursor: not-allowed;
  		  opacity: 0.5;
  		  text-decoration: none;
      }'
]

{ #category : #css }
ERLibrary >> esugCss [
	^ self alertCss, self disabledCss 
]

{ #category : #js }
ERLibrary >> esugJs [
	^ self validationRegisterJs
]

{ #category : #css }
ERLibrary >> generalCss [
	^ '#all {
	margin: 0px;
	padding: 0px;
}

table { width: 100%; }
.half {width: 49%;
	display: inline-block;}
.third {width: 33%;
	display: inline-block;}
	
.register-member-option { 
	background-color: rgba(0,0,1,0.12);
  	padding: 10px;
   outline: none;
   border: 1px solid rgba(0,0,0,.12);
	cursor: pointer;
}

#accordion .ui-accordion-content {
	height: 100%;
}

.option-text { 
	cursor: pointer;
}

.register-member-bar {
    padding: 5px;
    outline: none;
    border: 1px solid rgba(0,0,0,.12); 
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
  height: 90px;
  display: flex;
  align-items: end;
  justify-content: center;
}

.demo-drawer-text {
	 font-size: 26px;
    -moz-osx-font-smoothing: grayscale;
    margin: 0px 20px;
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

{ #category : #css }
ERLibrary >> loginCss [
	^ '
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
  padding: 0px;
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

{ #category : #css }
ERLibrary >> registerCss [
	^ '
	.mdl-checkbox { height: auto; }
	
	.body-all {
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

#login-button, #register-button {
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

{ #category : #js }
ERLibrary >> selectAccordionRegisterJs [

	^ '
		$().ready(function() {
  			$(document.querySelectorAll("div[id^=\"ui-id-\"]")).each(function() {
				var clickedAccordion = $(this);
				var idAccordion = ($(this)[0].id).charAt(($(this)[0].id).length - 1);
				$(this).on("click", function() { 
					var $active = $(document.querySelector("a[id$=\" "+ idAccordion + "\"]"));
					$active.find("span").trigger("click");
				});
				clickedAccordion.on("click", 
					function() {
						var idAccordion = ($(this)[0].id).charAt(($(this)[0].id).length - 1);
						$(this).on("click", function() { 
							var $active = $(document.querySelector("a[id$=\" "+ idAccordion + "\"]"));
							$active.find("span").trigger("click");
						});
				});
			})
	})'
]

{ #category : #updating }
ERLibrary >> selectorsToInclude [
	^ OrderedCollection new 
	add: 'registerCss';
	add: 'tabsCss';
	add: 'generalCss';
	add: 'esugCss';
	add: 'esugJs';
	add: 'validationInputsJs';
	add: 'validationUpdateProfileJs';
	add: 'loginCss';
	add: 'selectAccordionRegisterJs';
	add: 'validationAccordionRegisterJs';
	yourself
]

{ #category : #css }
ERLibrary >> tabsCss [
	^ '
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
    /*height: 0;*/
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

{ #category : #js }
ERLibrary >> validationAccordionRegisterJs [

	^ '$().ready(function() {
    $("[id^=\"registerAccordionForm\"]").each(function(){
		var idForm = ($(this)[0].id).charAt(($(this)[0].id).length - 1);
		var clickedForm = $(this);
		clickedForm.validate({
        ignore: ":hidden",
        errorClass: "mdl-textfield__error",
        errorElement: "span"    ,
        highlight: function(element, errorClass) {
            $(element).parent().addClass("is-invalid");
        }
		});
	
		$(".btnNextAccordion" + idForm).on("click", function () {
        $("#firstName" + idForm).rules("add", {required:true});
        $("#lastName" + idForm).rules("add", {required:true});
        $("#email" + idForm).rules("add", {required:true, email: true});
        $("#passwordRegister" + idForm).rules("add", {required:true, minlength: 8});
        $("#confirmPasswordRegister" + idForm).rules("add", {required:true, equalTo: "#passwordRegister" + idForm});
        if ((!clickedForm.valid())) {
            return false;
        }
        var $active = $(document.querySelectorAll("a[id$=\" "+ idForm + "\"][class$=\"is-active\"]"));
		  $active.next("a").removeAttr("disabled");
        $active.next("a").find("span").trigger("click");
    });

    $(".btnPreviousAccordion" + idForm).click(function(){
          $(document.querySelector("a[id$=\" "+ idForm + "\"][class$=\"is-active\"]")).prev("a").find("span").trigger("click");
    });});
});'
]

{ #category : #js }
ERLibrary >> validationInputsJs [
	^ '$().ready(function() {
	$("#changePasswordForm").validate({
        ignore: ":hidden",
        errorClass: "mdl-textfield__error",
        errorElement: "span"    ,
        highlight: function(element, errorClass) {
            $(element).parent().addClass("is-invalid");
        }
    });
	$("#password").rules("add", {required:true, minlength: 8});
   $("#confirmPassword").rules("add", {required:true, equalTo: "#password"});
	});
	'
]

{ #category : #js }
ERLibrary >> validationRegisterJs [
	^ '
	$().ready(function() {
		$("#registerForm").validate({
			ignore: ":hidden",
			errorClass: "mdl-textfield__error",
			errorElement: "span",
			highlight: function(element, errorClass) {
				$(element).parent().addClass("is-invalid");
			}
		});
        
    $(".btnNext").on("click", function () {
        $("#firstName").rules("add", {required:true});
        $("#lastName").rules("add", {required:true});
        $("#email").rules("add", {required:true, email: true});
        $("#passwordRegister").rules("add", {required:true, minlength: 8});
        $("#confirmPasswordRegister").rules("add", {required:true, equalTo: "#passwordRegister"});
    
        $("#facebookURL").rules("add", {url: true});
        $("#twitterURL").rules("add", {url: true});
        $("#homePageURL").rules("add", {url: true});
    
        $("#organizationName").rules("add", {required:true});
        $("#organizationAddrees1").rules("add", {required:true});
        $("#organizationCity").rules("add", {required:true});
        $("#organizationPostal").rules("add", {required:true});
        $("#organizationCountry").rules("add", {required:true});
    
        $("#paymentType").rules("add", {required:true});
        $("#paymentCurrency").rules("add", {required:true});
        if ((!$("#registerForm").valid())) {
            return false;
        }
        var $active = $(".mdl-tabs__tab-bar > .is-active");
		$active.next("a").removeAttr("disabled");
        $active.next("a").find("span").trigger("click");
    });

    $(".btnPrevious").click(function(){
          $(".mdl-tabs__tab-bar > .is-active").prev("a").find("span").trigger("click");
    });
});'
]

{ #category : #js }
ERLibrary >> validationUpdateProfileJs [
	^ '$().ready(function() {
	$("#formUpdateProfile").validate({
        ignore: ":hidden",
        errorClass: "mdl-textfield__error",
        errorElement: "span"    ,
        highlight: function(element, errorClass) {
            $(element).parent().addClass("is-invalid");
        }
    });
	});
	'
]
