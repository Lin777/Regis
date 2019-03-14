Class {
	#name : #ERTestRegisterConferenceInformation,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestRegisterConferenceInformation >> testAddedPersonIsNormal [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self assert: (reg isNormal: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegan'.
	self deny: (reg isNormal: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegetarian'.
	self deny: (reg isNormal: reg personAddedFoodPreference)  
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testAddedPersonIsVegan [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self deny: (reg isVegan: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegan'.
	self assert: (reg isVegan: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegetarian'.
	self deny: (reg isVegan: reg personAddedFoodPreference)  
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testAddedPersonIsVegetarian [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self deny: (reg isVegetarian: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegan'.
	self deny: (reg isVegetarian: reg personAddedFoodPreference).
	reg personAddedFoodPreference: 'Vegetarian'.
	self assert: (reg isVegetarian: reg personAddedFoodPreference)  
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testIsFemale [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self deny: reg isFemale .
	reg gender: 'Female'.
	self assert: reg isFemale 
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testIsMale [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self assert: reg isMale .
	reg gender: 'Female'.
	self deny: reg isMale 
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testIsNormal [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self assert: reg isNormal.
	reg foodPreference: 'Vegan'.
	self deny: reg isNormal .
	reg foodPreference: 'Vegetarian'.
	self deny: reg isNormal 
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testIsVegan [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self deny: reg isVegan.
	reg foodPreference: 'Vegan'.
	self assert: reg isVegan .
	reg foodPreference: 'Vegetarian'.
	self deny: reg isVegan 
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testIsVegetarian [
	|reg|
	reg := self class testRegisterConferenceInformation.
	self deny: reg isVegetarian.
	reg foodPreference: 'Vegan'.
	self deny: reg isVegetarian.
	reg foodPreference: 'Vegetarian'.
	self assert: reg isVegetarian  
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testNonValidOptionFoodPreferenceField [
	| reg |
	reg := (self class testRegisterConferenceInformation) foodPreference: 'Non.Valid.Option'; yourself .
	self assertNonValidField: reg
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testNonValidOptionFoodPreferenceOfExtraPersonField [
	| reg |
	reg := (self class testRegisterConferenceInformation) personAddedFoodPreference: 'Non.Valid.Option'; yourself .
	self assertNonValidField: reg
]

{ #category : #tests }
ERTestRegisterConferenceInformation >> testNonValidOptionGenderField [
	| reg |
	reg := (self class testRegisterConferenceInformation) gender: 'Non.Valid.Option'; yourself .
	self assertNonValidField: reg
]
