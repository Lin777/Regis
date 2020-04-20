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

{ #category : #accessing }
ERRegisterAsAttendeePageTest >> coupon: aString [
	self selectElementWithID: 'coupon' send: aString
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonAdditional [
	self pressNextButtonConference.
	self pressNextButtonAffiliation.
	self selectElementWithID: 'keywords' send: 'Example'.
	self selectElementWithID: 'additionalText' send: 'Example'.
	self clickElementWithID: 'additionalInfoForm-nextButton'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonConference [

	self pressNextButtonContact.
	self clickElementWithID:'conferenceOptionsForm-nextButton'
]

{ #category : #actions }
ERRegisterAsAttendeePageTest >> pressNextButtonContact [
	self pressNextButtonUser.
	super pressNextButtonContact
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

{ #category : #running }
ERRegisterAsAttendeePageTest >> setUp [
	super setUp.
	self pushRegisterButton 
]

{ #category : #'register Additional Information Tests' }
ERRegisterAsAttendeePageTest >> testPressAdditionalBackButton [

	self pressNextButtonConference.
	self pressNextButtonAffiliation.
	self clickElementWithID: 'additionalInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Billing Information')
]

{ #category : #'register Additional Information Tests' }
ERRegisterAsAttendeePageTest >> testPressAdditionalNextButtonWithAllFieldsFilledCorrectly [

	self pressNextButtonConference.
	self pressNextButtonAffiliation .
	self selectElementWithID: 'keywords' send: 'Example'.
	self selectElementWithID: 'additionalText' send: 'Example'.
	self clickElementWithID: 'additionalInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Payment')
]

{ #category : #'register Affiliation Information Tests' }
ERRegisterAsAttendeePageTest >> testPressBillingBackButton [

	self pressNextButtonConference.
	self clickElementWithID: 'affiliationInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #'register Affiliation Information Tests' }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithAllFieldsFilledCorrectly [

	self pressNextButtonConference.
	self fillAllAffiliationFields.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional')
]

{ #category : #'register Affiliation Information Tests' }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutFillingAnyField [
	self pressNextButtonConference.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	
]

{ #category : #'register Affiliation Information Tests' }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationAddrees1Field [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	(driver findElementByID: 'organizationAddrees1') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationAddrees1') equals: 'This field is required.'
	
]

{ #category : #'register Affiliation Information Tests' }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationCityField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationCity') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationCity') equals: 'This field is required.'
	
]

{ #category : #'register Affiliation Information Tests' }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationNameField [
	self pressNextButtonConference.
	self fillAllAffiliationFields.
	(driver findElementByID: 'organizationName') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationName') equals: 'This field is required.'.
	
]

{ #category : #'register Affiliation Information Tests' }
ERRegisterAsAttendeePageTest >> testPressBillingNextButtonWithoutOrganizationPostalField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	(driver findElementByID: 'organizationPostal') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'organizationPostal') equals: 'This field is required.'
]

{ #category : #'register  Buttons Tests' }
ERRegisterAsAttendeePageTest >> testPressConferenceBackButton [
	self pressNextButtonContact .
	self clickElementWithID: 'conferenceOptionsForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #'register  Buttons Tests' }
ERRegisterAsAttendeePageTest >> testPressConferenceNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonContact .
	self clickElementWithID: 'conferenceOptionsForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Billing Information')
]

{ #category : #'register  Buttons Tests' }
ERRegisterAsAttendeePageTest >> testPressContactBackButton [
	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-User')
]

{ #category : #'register  Buttons Tests' }
ERRegisterAsAttendeePageTest >> testPressContactNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonUser .
	self clickElementWithID: 'contactInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #'register Payment Information Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressPaymentBackButton [
	self pressNextButtonAdditional.
	self clickElementWithID: 'paymentInformationForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional').
	
]

{ #category : #'register Payment Information Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithInvalidCoupon [
	self pressNextButtonAdditional .
	self coupon: 'invalidCoupon'.
	self clickElementWithID: 'registerButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: 'Reduction Ticket Code: There is no ticket with the ticket id provided.'
]

{ #category : #'register Payment Information Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithoutFillingAnyField [
	self pressNextButtonAdditional .
	self clickElementWithID: 'registerButton'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Registration Summary'
	
]

{ #category : #'register BasicInformation Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [
	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #'register BasicInformation Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutConfirmPasswordField [
	self fillAllUserFields.
	(driver findElementByID: 'confirmPasswordRegister') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'confirmPasswordRegister') equals: 'This field is required.'
]

{ #category : #'register BasicInformation Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutEmailField [
	self fillAllUserFields.
	(driver findElementByID: 'email') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'email') equals: 'This field is required.'
]

{ #category : #'register BasicInformation Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFillingAnyField [
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	
]

{ #category : #'register BasicInformation Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFirstNameField [
	self fillAllUserFields.
	(driver findElementByID: 'firstName') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (self getTextErrorOf: 'firstName') equals: 'This field is required.'
]

{ #category : #'register BasicInformation Tab Tests' }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutLastNameField [
	self fillAllUserFields.
	(driver findElementByID: 'lastName') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self assert: (self getTextErrorOf: 'lastName') equals: 'This field is required.'
]
