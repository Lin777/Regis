Class {
	#name : #ERRegisterAsAttendeePageTest,
	#superclass : #ERRegisterTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #tests }
ERRegisterAsAttendeePageTest >> address: aString1 address2: aString2 city: aString3 contactCountry: aString4 province: aString5 postal: aString6 facebookURL: aString7 twitterURL: aString8 homePageURL: aString9 [
	|address address2 city contactCountry province postal facebookURL twitterURL homePageURL|
	address := driver findElementByID: 'address'.
	address2 := driver findElementByID: 'address2'.
	city := driver findElementByID: 'city'.
	contactCountry := driver findElementByID: 'contactCountry'.
	province := driver findElementByID: 'province'.
	postal := driver findElementByID: 'postal'.
	facebookURL := driver findElementByID: 'facebookURL'.
	twitterURL := driver findElementByID: 'twitterURL'.
	homePageURL := driver findElementByID: 'homePageURL'.
	address sendKeys: aString1 .
	address2 sendKeys: aString2.
	city sendKeys: aString3.
	contactCountry sendKeys: aString4.
	province sendKeys: aString5.
	postal sendKeys: aString6.
	facebookURL sendKeys: aString7.
	twitterURL sendKeys: aString8.
	homePageURL sendKeys: aString9
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> coupon: aString [
	|coupon|
	coupon := driver findElementByID: 'coupon'.
	
	coupon sendKeys: aString 
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> fillAllContactFields [
	self address: 'Example Av.' address2: 'Example St.' city: 'Cochabamba' contactCountry: 'Bolivia' province: 'Cercado' postal: '0000' facebookURL: 'https://es-la.facebook.com/' twitterURL: '' homePageURL: ''
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> keywords: aString1 additionalText: aString2 [ 
	|keywords  additionalText |
	keywords := driver findElementByID: 'keywords'.
	additionalText := driver findElementByID: 'additionalText'.
	
	keywords sendKeys: aString1 .
	additionalText sendKeys: aString2.
	
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonAdditional [
	|next|
	self pressNextButtonAffiliation .
	self keywords: 'Example' additionalText: 'Example'. 
	next := driver findElementByID: 'additionalInfoForm-nextButton'.
	next click.
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonAffiliation [ 
	|next|
	self pressNextButtonConference .
	self fillAllAffiliationFields.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonConference [
	|next|
	self pressNextButtonContact .
	next := driver findElementByID: 'conferenceOptionsForm-nextButton'.
	next click.
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonContact [
	|next|
	self pressNextButtonUser.
	self fillAllContactFields.
	next := driver findElementByID: 'contactInfoForm-nextButton'.
	next click.
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pressNextButtonPayment [
	|next|
	self pressNextButtonAdditional.
	next := driver findElementByID: 'paymentInformationForm-nextButton'.
	next click.
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> pushRegisterButton [
	|register|
	register := driver findElementByID: 'register-button'.
	register click.
	self assert: (driver findElementByID: 'card-heading') getText = 'Registration'
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> setUp [
	super setUp.
	self pushRegisterButton 
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAdditionalBackButton [
	|next|
	self pressNextButtonAffiliation  .
	next := driver findElementByID: 'additionalInfoForm-previousButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Affiliation')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAdditionalNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonAffiliation .
	self keywords: 'Example' additionalText: 'Example'. 
	next := driver findElementByID: 'additionalInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Payment')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationBackButton [
	|next|
	self pressNextButtonConference  .
	next := driver findElementByID: 'affiliationInfoForm-previousButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonConference .
	self fillAllAffiliationFields.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutFillingAnyField [
	|next|
	self pressNextButtonConference.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationAddrees1Field [
	|next|
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationAddrees1') clear.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Address 1')
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationCityField [
	|next|
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationCity') clear.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'City')
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationNameField [
	|next|
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationName') clear.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Organization Name')
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithoutOrganizationPostalField [
	|next|
	self pressNextButtonConference .
	self fillAllAffiliationFields .
	
	(driver findElementByID: 'organizationPostal') clear.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Postal/Zipcode')
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressCancelButtonAcceptAlert [
	|cancel|
	cancel := driver findElementByID: 'basicInfoForm-goBackLoginButton'.
	cancel click.
	driver acceptAlert .
	self assert: (driver findElementByID: 'card-heading') getText equals: 'User Login'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressCancelButtonDismissAlert [
	|cancel|
	cancel := driver findElementByID: 'basicInfoForm-goBackLoginButton'.
	cancel click.
	driver dismissAlert .
	self assert: (driver findElementByID: 'card-heading') getText equals: 'Registration'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressConferenceBackButton [
	|next|
	self pressNextButtonContact .
	next := driver findElementByID: 'conferenceOptionsForm-previousButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressConferenceNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonContact .
	next := driver findElementByID: 'conferenceOptionsForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Affiliation')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressContactBackButton [
	|next|
	self pressNextButtonUser.
	next := driver findElementByID: 'contactInfoForm-previousButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-User')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressContactNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonUser .
	next := driver findElementByID: 'contactInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Conference')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressDoneButton [
	|next|
	self pressNextButtonPayment .
	next := driver findElementByID: 'registerButton'.
	next click.
	self assert: (driver findElementByID: 'card-heading') getText equals: 'Registration Summary'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressPaymentBackButton [
	|next|
	self pressNextButtonAdditional   .
	next := driver findElementByID: 'paymentInformationForm-previousButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Additional')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithInvalidCoupon [
	|next|
	self pressNextButtonAdditional .
	self coupon: 'invalidCoupon'.
	next := driver findElementByID: 'paymentInformationForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: 'Reduction Ticket Code: There is no ticket with the ticket id provided.'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithoutFillingAnyField [
	|next|
	self pressNextButtonAdditional .
	next := driver findElementByID: 'paymentInformationForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Done')
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self fillAllUserFields.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Contact')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutConfirmPasswordField [
	|next|
	self fillAllUserFields.
	(driver findElementByID: 'confirmPassword') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Confirm Password')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutEmailField [
	|next|
	self fillAllUserFields.
	(driver findElementByID: 'email') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Email')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFillingAnyField [
	|next|
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutFirstNameField [
	|next|
	self fillAllUserFields.
	(driver findElementByID: 'firstName') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'First Name')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutLastNameField [
	|next|
	self fillAllUserFields.
	(driver findElementByID: 'lastName') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Last Name')
]
