Class {
	#name : #ERUserAccountForRegister,
	#superclass : #ERUserAccount,
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
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
		id: 'confirmPassword';
		componentClass: MDLMATextPasswordComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
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
		id: 'password';
		componentClass: MDLMATextPasswordComponent.
	^ tmp yourself
]
