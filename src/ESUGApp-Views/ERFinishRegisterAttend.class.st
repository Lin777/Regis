Class {
	#name : #ERFinishRegisterAttend,
	#superclass : #ERPageView,
	#category : #'ESUGApp-Views'
}

{ #category : #testing }
ERFinishRegisterAttend class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERFinishRegisterAttend class >> initialize [

    (WAAdmin register: self asApplicationAt: 'FinishRegisterAttend')
        addLibrary: JQDeploymentLibrary;
        addLibrary: MDLLibrary;
        addLibrary: ERMaterialBlueRedMinCss;
        addLibrary: CssForLoginMDL;
        addLibrary: CssForRegisterFormsMDL;
        addLibrary: ERJQValidateForm;
        addLibrary: ERLibrary;
        preferenceAt: #sessionClass put: ERSession
]

{ #category : #'as yet unclassified' }
ERFinishRegisterAttend >> colorIcon [
	^ 'mdl-color--green'
]

{ #category : #initialization }
ERFinishRegisterAttend >> initialize [
	super initialize.
	title := 'Registration Summary'.
	icon := 'done'.
	id := 'finishRegisterAttend'.
	classContainer := 'mdl-card-register'.
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderActions: html [
	html mdlCardActions class: 'mdl-card--border';
	with: [ 
		html anchor url: 'AttendeeNormalTabs.html';
		class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Back'.
		html anchor url: 'FinishRegisterAttend2.html';
		class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Next'.
		html anchor class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Cancel'.
		html anchor url: 'FinishRegisterAttend2.html';
		class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Finish'.	
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderAffiliation: html [
	html mdlCell class: 'mdl-cell--4-col';
	with: [ 
	self renderTitle: html with: 'Affiliation'.
	self renderStrong: html with: 'Organization Name:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Address Line 1:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Address Line 2:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'City:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Province/States:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Postal/Zip Code:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Country:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'MemberShip Type:' and: 'Lorem Ipsum'.
	self renderTitle: html with: 'Additional Information'.
	self renderStrong: html with: 'Additional Text:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Keywords:' and: 'Yes'.
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderContactInformation: html [
	html mdlCell class: 'mdl-cell--4-col';
	with: [ 
	self renderTitle: html with: 'Contact Information'.
	self renderStrong: html with: 'First Name:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Last Name:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Email:' and: ''.
	self renderStrong: html with: 'Facebook:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Twitter:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Home Page:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Address Line 1:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Address Line 2:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'City:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Province/States:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Postal/Zip Code:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Country:' and: 'Lorem Ipsum'.
	self renderTitle: html with: 'Conference Options'.
	self renderStrong: html with: 'Day(s) to attend:' and: 'Monday dd, Friday dd'.
	self renderStrong: html with: 'Last Name:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'TShirt:' and: 'Small'.
	self renderStrong: html with: 'Type Food:' and: 'Lorem Ipsum'.
	self renderStrong: html with: 'Goes Social Event:' and: 'Yes'.
	self renderStrong: html with: 'Add mailling list:' and: 'No'.
	html break
	].
	
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderPageOn: html [
	html mdlGrid class: 'mdl-grid--no-spacing';
	with: [ 
		self renderContactInformation: html.
		self renderAffiliation: html.
		self renderPaymentInformation: html.
		self renderActions: html.
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderPaymentInformation: html [
	html mdlCell class: 'mdl-cell--4-col';
	with: [ 
	self renderTitle: html with: 'Payment Information'.
	self renderStrong: html with: 'Payment Type:' and: 'Bank Transfer'.
	self renderStrong: html with: 'Payment Currency:' and: 'Euro'.
	self renderStrong: html with: 'Conference Fee:' and: '666.00'.
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderStrong: html with: aString1 and: aString2 [
	html strong: aString1.
	aString2 ifNotNil: [ 
		html text: aString2.
		html break 	
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderTitle: html with: aString [
	html heading level6 with: [
		self renderStrong: html with: aString and: nil.
	].
	html horizontalRule.
]
