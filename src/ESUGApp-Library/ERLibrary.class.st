Class {
	#name : #ERLibrary,
	#superclass : #WAFileLibrary,
	#category : #'ESUGApp-Library'
}

{ #category : #accessing }
ERLibrary class >> applicationName [ 
	^ 'ESUG'
]

{ #category : #updating }
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

{ #category : #'as yet unclassified' }
ERLibrary >> disabledCss [
	^ 'a[disabled="disabled"] {
        pointer-events: none;
		  color: currentColor;
  		  cursor: not-allowed;
  		  opacity: 0.5;
  		  text-decoration: none;
      }'
]

{ #category : #'as yet unclassified' }
ERLibrary >> enterAsTabJs [
	^ ''"'$(''input,textarea'').keypress(function(e){
  			if(e.keyCode==13) {
   				$(this).nextAll(''input,textarea'').first().focus();
  			}
		});'"
]

{ #category : #updating }
ERLibrary >> esugCss [
	^ self alertCss, self disabledCss 
]

{ #category : #updating }
ERLibrary >> esugJs [
	^ self registerButtonsJs, self enterAsTabJs
]

{ #category : #updating }
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

{ #category : #updating }
ERLibrary >> registerButtonsJs [
	^ '$().ready(function() {
	$(''.btnNext'').click(function(){
  $(''.mdl-tabs__tab-bar > .is-active'').next("a").find("span").trigger(''click'');});

  $(''.btnPrevious'').click(function(){
  $(''.mdl-tabs__tab-bar > .is-active'').prev("a").find("span").trigger(''click'');
}); });'
]

{ #category : #updating }
ERLibrary >> registerCss [
	^ '
	.mdl-checkbox {height: auto;}
	
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
	^ OrderedCollection new 
	add: 'registerCss';
	add: 'tabsCss';
	add: 'loginCss';
	add: 'generalCss';
	add: 'esugCss';
	add: 'esugJs';
	add: 'validationInputsJs';
	yourself
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
	^ ''"'$().ready(function() {$(''.btnNext'').click(function(){
	console.log(''next'');
	$(''.mdl-tabs__tab-bar > .is-active'').next(''a'').trigger(''click'');
});

  $(''.btnPrevious'').click(function(){
console.log(''prev'');
  $(''.mdl-tabs__tab-bar > .is-active'').prev(''a'').trigger(''click'');}); });'"
]

{ #category : #'as yet unclassified' }
ERLibrary >> validationInputsJs [
	^ '
		$(window).bind("load", function(){
		var newPassword = document.getElementById("password");
	var confNewPassword = document.getElementById("confirmPassword");
	
	function validatePassword(){
		if(newPassword.value != confNewPassword.value){
			confNewPassword.setCustomValidity("Passwords Dont Match");
		} else { 
			confNewPassword.setCustomValidity("");
		}
	}
	
	newPassword.onchange = validatePassword;
	confNewPassword.onkeyup = validatePassword;
	});
	'
]
