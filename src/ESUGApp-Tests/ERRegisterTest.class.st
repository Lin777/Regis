Class {
	#name : #ERRegisterTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #tests }
ERRegisterTest >> fillAllAffiliationFields [

	self selectElementWithID: 'organizationName' send: 'Semantics'.
	self selectElementWithID: 'organizationAddrees1' send: 'Example Av.' .
	self selectElementWithID: 'organizationAddrees2' send: 'Example St.'.
	self selectElementWithID: 'organizationCity' send: 'Cochabamba'.
	self selectElementWithID: 'organizationCountry' send: 'Bolivia'.
	self selectElementWithID: 'organizationProvince' send: 'Cercado'.
	self selectElementWithID: 'organizationPostal' send: '0000'.
	self selectElementWithID: 'membershipType' send: 'Academic'
]

{ #category : #actions }
ERRegisterTest >> fillAllContactFields [
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

{ #category : #tests }
ERRegisterTest >> fillAllUserFields [
	self selectElementWithID: 'firstName' send: 'register'.
	self selectElementWithID: 'lastName' send: 'register'.
	self selectElementWithID: 'email' send: 'register@gmail.com'.
	self selectElementWithID: 'passwordRegister' send: '12345678'.
	self selectElementWithID: 'confirmPasswordRegister' send: '12345678'
]

{ #category : #actions }
ERRegisterTest >> pressNextButtonAffiliation [

	self fillAllAffiliationFields.
	self clickElementWithID: 'affiliationInfoForm-nextButton'
]

{ #category : #action }
ERRegisterTest >> pressNextButtonContact [
	self fillAllContactFields.
	self clickElementWithID: 'contactInfoForm-nextButton'
]

{ #category : #action }
ERRegisterTest >> pressNextButtonUser [
	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'
]
