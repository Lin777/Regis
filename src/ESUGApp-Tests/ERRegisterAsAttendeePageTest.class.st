"
Description
--------------------

A ERRegisterAsAttendeePageTest is a test class for testing the behavior of page when the user is registering as Attendee
"
Class {
	#name : #ERRegisterAsAttendeePageTest,
	#superclass : #ERRegisterTest,
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #tests }
ERRegisterAsAttendeePageTest >> coupon: aString [
	self selectElementWithID: 'coupon' send: aString
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> fillAllContactFields [
	self selectElementWithID: 'address' send: 'Example Av.'.
	self selectElementWithID: 'address2' send: 'Example St.'.
	self selectElementWithID: 'city' send: 'Cochabamba'.
	self selectElementWithID: 'contactCountry' send: 'Bolivia'.
	self selectElementWithID: 'province' send: 'Cercado'.
	self selectElementWithID: 'postal' send: '0000'.
	self selectElementWithID: 'facebookURL' send: 'https://es-la.facebook.com/'.
	self selectElementWithID: 'twitterURL' send: ''.
	self selectElementWithID: 'homePageURL' send: ''
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonAdditional [
	self pressNextButtonAffiliation .
	self selectElementWithID: 'keywords' send: 'Example'.
	self selectElementWithID: 'additionalText' send: 'Example'.
	self clickElementWithID: 'additionalInfoForm-nextButton'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonAffiliation [ 
	self pressNextButtonConference .
	self fillAllAffiliationFields.
	self clickElementWithID: 'affiliationInfoForm-nextButton'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonConference [
	self pressNextButtonContact .
	self clickElementWithID:'conferenceOptionsForm-nextButton'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonContact [
	self pressNextButtonUser.
	self fillAllContactFields.
	self clickElementWithID: 'contactInfoForm-nextButton'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonPayment [
	self pressNextButtonAdditional.
	self clickElementWithID: 'paymentInformationForm-nextButton'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pushRegisterButton [
	self clickElementWithID: 'register-button'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Registration'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> setUp [
	super setUp.
	self pushRegisterButton 
]

{ #category : #registerAdditionalInformationTests }
ERRegisterAsAttendeePageTest >> testPressAdditionalBackButton [
	self pressNextButtonAffiliation  .
	self clickElementWithID: 'additionalInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Billing Information')
]

{ #category : #registerAdditionalInformationTests }
ERRegisterAsAttendeePageTest >> testPressAdditionalNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonAffiliation .
	self selectElementWithID: 'keywords' send: 'Example'.
	self selectElementWithID: 'additionalText' send: 'Example'.
	self clickElementWithID: 'additionalInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Payment')
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressBillingBackButton [
	self pressNextButtonConference  .
	self clickElementWithID: 'affiliationInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonConference .
	self fillAllAffiliationFields.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional')
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutFillingAnyField [
	self pressNextButtonConference.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationAddrees1Field [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	(driver findElementByID: 'organizationAddrees1') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationAddrees1') equals: 'This field is required.'
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationCityField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationCity') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationCity') equals: 'This field is required.'
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationNameField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationName') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationName') equals: 'This field is required.'.
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationPostalField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	(driver findElementByID: 'organizationPostal') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationPostal') equals: 'This field is required.'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressCancelButtonAcceptAlert [
	self clickElementWithID: 'basicInfoForm-goBackLoginButton'.
	driver acceptAlert .
	self assert: (self textOfElementWithID: 'card-heading') equals: 'User Login'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressCancelButtonDismissAlert [
	self clickElementWithID: 'basicInfoForm-goBackLoginButton'.
	driver dismissAlert .
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Registration'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressConferenceBackButton [
	self pressNextButtonContact .
	self clickElementWithID: 'conferenceOptionsForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressConferenceNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonContact .
	self clickElementWithID: 'conferenceOptionsForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Billing Information')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressContactBackButton [
	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-User')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressContactNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonUser .
	self clickElementWithID: 'contactInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #registerPaymentInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressPaymentBackButton [
	self pressNextButtonAdditional   .
	self clickElementWithID: 'paymentInformationForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional').
	
]

{ #category : #registerPaymentInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithInvalidCoupon [
	self pressNextButtonAdditional .
	self coupon: 'invalidCoupon'.
	self clickElementWithID: 'registerButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: 'Reduction Ticket Code: There is no ticket with the ticket id provided.'
]

{ #category : #registerPaymentInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithoutFillingAnyField [
	self pressNextButtonAdditional .
	self clickElementWithID: 'registerButton'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Registration Summary'
	
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [
	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutConfirmPasswordField [
	self fillAllUserFields.
	(driver findElementByID: 'confirmPasswordRegister') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'confirmPasswordRegister') equals: 'This field is required.'
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutEmailField [
	self fillAllUserFields.
	(driver findElementByID: 'email') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'email') equals: 'This field is required.'
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFillingAnyField [
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFirstNameField [
	self fillAllUserFields.
	(driver findElementByID: 'firstName') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'firstName') equals: 'This field is required.'
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutLastNameField [
	self fillAllUserFields.
	(driver findElementByID: 'lastName') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self assert: (self getTextErrorOf: 'lastName') equals: 'This field is required.'
]
