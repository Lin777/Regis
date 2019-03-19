Class {
	#name : #ERRegisterTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #tests }
ERRegisterTest >> fillAllAffiliationFields [
	self organizationName: 'Semantics' organizationAddrees1: 'Example Av.' organizationAddrees2: 'Example St.' organizationCity: 'Cochabamba' organizationCountry: 'Bolivia' organizationProvince: 'Cercado' organizationPostal: '0000' membershipType: 'Academic'
]

{ #category : #tests }
ERRegisterTest >> fillAllUserFields [
	self firstName: 'register' lastName: 'register' email: 'register@gmail.com' password: '12345678' confirmPassword: '12345678'.
]

{ #category : #accessing }
ERRegisterTest >> firstName: aString1 lastName: aString2 email: aString3 password: aString4 confirmPassword: aString5 [
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

{ #category : #tests }
ERRegisterTest >> organizationName: aString1 organizationAddrees1: aString2 organizationAddrees2: aString3 organizationCity: aString4 organizationCountry: aString5 organizationProvince: aString6 organizationPostal: aString7 membershipType: aString8 [
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
ERRegisterTest >> pressNextButtonUser [
	|next|
	self fillAllUserFields.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
]
