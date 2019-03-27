"
A ERRegisterAsAttendeePageTest is a test class for testing the behavior of page when the user is registering as Attendee
"
Class {
	#name : #ERRegisterAsAttendeePageTest,
	#superclass : #ERRegisterTest,
	#category : #'ESUGApp-Test-Parasol'
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

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressDoneButton [
	self pressNextButtonPayment .
	self clickElementWithID: 'registerButton'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonAdditional [
	self pressNextButtonAffiliation .
	self selectElementWithID: 'keywords' send: 'Example'.
	self selectElementWithID: 'additionalText' send: 'Example'.
	self clickElementWithID: 'additionalInfoForm-nextButton'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonAffiliation [ 
	self pressNextButtonConference .
	self fillAllAffiliationFields.
	self clickElementWithID: 'affiliationInfoForm-nextButton'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonConference [
	self pressNextButtonContact .
	self clickElementWithID:'conferenceOptionsForm-nextButton'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonContact [
	self pressNextButtonUser.
	self fillAllContactFields.
	self clickElementWithID: 'contactInfoForm-nextButton'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonPayment [
	self pressNextButtonAdditional.
	self clickElementWithID: 'paymentInformationForm-nextButton'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pushRegisterButton [
	self clickElementWithID: 'register-button'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Registration'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> setUp [
	super setUp.
	self pushRegisterButton 
]

{ #category : #registerAdditionalInformationTests }
ERRegisterAsAttendeePageTest >> testPressAdditionalBackButton [
	self pressNextButtonAffiliation  .
	self clickElementWithID: 'additionalInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Affiliation')
]

{ #category : #registerAdditionalInformationTests }
ERRegisterAsAttendeePageTest >> testPressAdditionalNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonAffiliation .
	self selectElementWithID: 'keywords' send: 'Example'.
	self selectElementWithID: 'additionalText' send: 'Example'.
	self clickElementWithID: 'additionalInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Payment')
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressAffiliationBackButton [
	self pressNextButtonConference  .
	self clickElementWithID: 'affiliationInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonConference .
	self fillAllAffiliationFields.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional')
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutFillingAnyField [
	self pressNextButtonConference.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationAddrees1Field [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	(driver findElementByID: 'organizationAddrees1') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Address 1')
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationCityField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationCity') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'City')
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationNameField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationName') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Organization Name')
	
]

{ #category : #registerAffiliationInformationTests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationPostalField [
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	(driver findElementByID: 'organizationPostal') clear.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Postal/Zipcode')
	
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
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressConferenceNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonContact .
	self clickElementWithID: 'conferenceOptionsForm-nextButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Affiliation')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressContactBackButton [
	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-User')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressContactNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonUser .
	self clickElementWithID: 'contactInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressDoneButton [
	self pressNextButtonPayment .
	self clickElementWithID: 'registerButton'.
	self assert: (self textOfElementWithID: 'card-heading') equals: 'Registration Summary'
]

{ #category : #registerPaymentInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressPaymentBackButton [
	self pressNextButtonAdditional   .
	self clickElementWithID: 'paymentInformationForm-previousButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional')
]

{ #category : #registerPaymentInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithInvalidCoupon [
	self pressNextButtonAdditional .
	self coupon: 'invalidCoupon'.
	self clickElementWithID: 'paymentInformationForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: 'Reduction Ticket Code: There is no ticket with the ticket id provided.'
]

{ #category : #registerPaymentInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithoutFillingAnyField [
	self pressNextButtonAdditional .
	self clickElementWithID: 'paymentInformationForm-nextButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Done')
	
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [
	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutConfirmPasswordField [
	self fillAllUserFields.
	(driver findElementByID: 'confirmPassword') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Confirm Password')
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutEmailField [
	self fillAllUserFields.
	(driver findElementByID: 'email') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Email')
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFillingAnyField [
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFirstNameField [
	self fillAllUserFields.
	(driver findElementByID: 'firstName') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'First Name')
]

{ #category : #registerBasicInformationTabTests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutLastNameField [
	self fillAllUserFields.
	(driver findElementByID: 'lastName') clear.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Last Name')
]
