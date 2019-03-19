Class {
	#name : #ERRegisterAsAttendeePageTest,
	#superclass : #ERParasolTest,
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
ERRegisterAsAttendeePageTest >> fillAllAffiliationFields [
	self organizationName: 'Semantics' organizationAddrees1: 'Example Av.' organizationAddrees2: 'Example St.' organizationCity: 'Cochabamba' organizationCountry: 'Bolivia' organizationProvince: 'Cercado' organizationPostal: '0000' membershipType: 'Academic'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> fillAllContactFields [
	self address: 'Example Av.' address2: 'Example St.' city: 'Cochabamba' contactCountry: 'Bolivia' province: 'Cercado' postal: '0000' facebookURL: 'https://es-la.facebook.com/' twitterURL: '' homePageURL: ''
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> fillAllUserFields [
	self firstName: 'register' lastName: 'register' email: 'register@gmail.com' password: '12345678' confirmPassword: '12345678'.
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> firstName: aString1 lastName: aString2 email: aString3 password: aString4 confirmPassword: aString5 [
	|firstName lastName email password confirmPassword|
	firstName := driver findElementByID: 'firstName'.
	lastName := driver findElementByID: 'lastName'.
	email := driver findElementByID: 'email'.
	password := driver findElementByID: 'password'.
	confirmPassword := driver findElementByID: 'confirmPassword'.
	firstName sendKeys: aString1 .
	lastName sendKeys: aString2.
	email sendKeys: aString3.
	password sendKeys: aString4.
	confirmPassword sendKeys: aString5.
]

{ #category : #'as yet unclassified' }
ERRegisterAsAttendeePageTest >> getTextOfError [
	^ (((((driver findElementByClassName: 'errors')findElementByTagName: 'ul')findElementByTagName: 'li')findElementByTagName: 'ul')findElementByTagName: 'li') getText
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> keywords: aString1 additionalText: aString2 [ 
	|keywords  additionalText |
	keywords := driver findElementByID: 'keywords'.
	additionalText := driver findElementByID: 'additionalText'.
	
	keywords sendKeys: aString1 .
	additionalText sendKeys: aString2.
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> organizationName: aString1 organizationAddrees1: aString2 organizationAddrees2: aString3 organizationCity: aString4 organizationCountry: aString5 organizationProvince: aString6 organizationPostal: aString7 membershipType: aString8 [
	|organizationName organizationAddrees1 organizationAddrees2 organizationCity organizationCountry organizationProvince organizationPostal membershipType|
	organizationName := driver findElementByID: 'organizationName'.
	organizationAddrees1 := driver findElementByID: 'organizationAddrees1'.
	organizationAddrees2 := driver findElementByID: 'organizationAddrees2'.
	organizationCity := driver findElementByID: 'organizationCity'.
	organizationCountry := driver findElementByID: 'organizationCountry'.
	organizationProvince := driver findElementByID: 'organizationProvince'.
	organizationPostal := driver findElementByID: 'organizationPostal'.
	membershipType := driver findElementByID: 'membershipType'.
	organizationName sendKeys: aString1 .
	organizationAddrees1 sendKeys: aString2.
	organizationAddrees2 sendKeys: aString3.
	organizationCity sendKeys: aString4.
	organizationCountry sendKeys: aString5.
	organizationProvince sendKeys: aString6.
	organizationPostal sendKeys: aString7.
	membershipType sendKeys: aString8
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
ERRegisterAsAttendeePageTest >> pressNextButtonUser [
	|next|
	self fillAllUserFields.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
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
ERRegisterAsAttendeePageTest >> testPressAdditionalNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonAffiliation .
	self keywords: 'Example' additionalText: 'Example'. 
	next := driver findElementByID: 'additionalInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') = (driver findElementByID: 'tab-Payment')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressAffiliationNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonConference .
	self fillAllAffiliationFields.
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') = (driver findElementByID: 'tab-Additional')
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
	self assert: self getTextOfError equals: 'Address 1 (Required): Input is required but no input given'
	
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
	self assert: self getTextOfError equals: 'City (Required): Input is required but no input given'
	
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
	self assert: self getTextOfError equals: 'Organization Name (Required): Input is required but no input given'
	
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
	self assert: self getTextOfError equals: 'Postal/Zipcode (Required): Input is required but no input given'
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressConferenceNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonContact .
	next := driver findElementByID: 'conferenceOptionsForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') = (driver findElementByID: 'tab-Affiliation')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressContactNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self fillAllUserFields.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') = (driver findElementByID: 'tab-Contact')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressPaymentNextButtonWithoutFillingAnyField [
	|next|
	self pressNextButtonAdditional .
	next := driver findElementByID: 'paymentInformationForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') = (driver findElementByID: 'tab-Done')
	
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self fillAllUserFields.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') = (driver findElementByID: 'tab-Contact')
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutConfirmPasswordField [
	|next|
	self fillAllUserFields.
	(driver findElementByID: 'confirmPassword') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: 'Confirm Password (Required): Input is required but no input given'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutEmailField [
	|next|
	self fillAllUserFields.
	(driver findElementByID: 'email') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: 'Email (Required): Input is required but no input given'
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
	self assert: self getTextOfError equals: 'First Name (Required): Input is required but no input given'
]

{ #category : #tests }
ERRegisterAsAttendeePageTest >> testPressUserNextButtonWithoutLastNameField [
	|next|
	self fillAllUserFields.
	(driver findElementByID: 'lastName') clear.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self shouldnt: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: self getTextOfError equals: 'Last Name (Required): Input is required but no input given'
]
