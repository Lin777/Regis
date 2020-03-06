"
Description
--------------------

A ERTestRegisterConferenceInformation is a test class for testing the behavior of ERRegisterConferenceInformation model
"
Class {
	#name : #ERRegisterConferenceInformationTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERRegisterConferenceInformationTest >> testAddedPersonIsNormal [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self assert: (reg isNormal: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegan'.
	self deny: (reg isNormal: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegetarian'.
	self deny: (reg isNormal: reg personAddedFoodPreference)  
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testAddedPersonIsVegan [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self deny: (reg isVegan: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegan'.
	self assert: (reg isVegan: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegetarian'.
	self deny: (reg isVegan: reg personAddedFoodPreference)  
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testAddedPersonIsVegetarian [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self deny: (reg isVegetarian: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegan'.
	self deny: (reg isVegetarian: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegetarian'.
	self assert: (reg isVegetarian: reg personAddedFoodPreference)  
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testIsFemale [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self deny: reg isFemale .
	reg gender: 'Female'.
	self assert: reg isFemale 
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testIsMale [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self assert: reg isMale .
	reg gender: 'Female'.
	self deny: reg isMale 
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testIsNormal [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self assert: reg isNormal.
	reg foodPreference: 'Vegan'.
	self deny: reg isNormal .
	reg foodPreference: 'Vegetarian'.
	self deny: reg isNormal 
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testIsVegan [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self deny: reg isVegan.
	reg foodPreference: 'Vegan'.
	self assert: reg isVegan .
	reg foodPreference: 'Vegetarian'.
	self deny: reg isVegan 
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testIsVegetarian [

	| reg |
	reg := self class testRegisterConferenceInformation.
	self deny: reg isVegetarian.
	reg foodPreference: 'Vegan'.
	self deny: reg isVegetarian.
	reg foodPreference: 'Vegetarian'.
	self assert: reg isVegetarian  
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testNonValidOptionFoodPreferenceField [
	| reg |
	reg := (self class testRegisterConferenceInformation) foodPreference: 'Non.Valid.Option'; yourself .
	self assertNonValidField: reg
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testNonValidOptionFoodPreferenceOfExtraPersonField [

	| reg |
	reg := (self class testRegisterConferenceInformation) personAddedFoodPreference: 'Non.Valid.Option'; yourself.
	self assertNonValidField: reg
]

{ #category : #tests }
ERRegisterConferenceInformationTest >> testNonValidOptionGenderField [

	| reg |
	reg := (self class testRegisterConferenceInformation) gender: 'Non.Valid.Option'; yourself.
	self assertNonValidField: reg
]
