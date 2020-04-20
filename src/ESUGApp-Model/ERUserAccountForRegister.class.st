"
I am a model of User Account for register, I have all necessary fields to create a new user, except role, this model has a default role
"
Class {
	#name : #ERUserAccountForRegister,
	#superclass : #ERUserAccount,
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'magrittes-descriptions' }
ERUserAccountForRegister >> descriptionConfirmPassword [
	<magritteDescription>
	| tmp |
	tmp := MAPasswordDescription new.
	tmp 
		accessor: #confirmPassword; 
		priority: 60;
		beRequired;
		label: 'Confirm Password (Required)';
		withoutLabel: true;
		componentClass: MDLMATextPasswordComponent.
	classId
		ifNil: [ tmp id: 'confirmPasswordRegister' ]
		ifNotNil: [ tmp id: 'confirmPasswordRegister', classId printString ].
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERUserAccountForRegister >> descriptionPassword [
	<magritteDescription>
	| tmp |
	tmp := MAPasswordDescription new.
	tmp 
		accessor: #password; 
		priority: 50;
		beRequired;
		withoutLabel: true;
		label: 'Password (Required)';
		addCondition: [ :value | value matchesRegex: '[A-Za-z0-9._]{8,}' ]
		labelled: 'The password must have at least 8 characters, and only accepts letters, numbers, slash and dots.';
		componentClass: MDLMATextPasswordComponent.
	classId
		ifNil: [ tmp id: 'passwordRegister' ]
		ifNotNil: [ tmp id: 'passwordRegister', classId printString ].
	^ tmp yourself
]
