"
I am a model of User Account for register, I have all necessary fields to create a new user
"
Class {
	#name : #ERUserAccountForAdminRegister,
	#superclass : #ERUserAccountForRegister,
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'magrittes-descriptions' }
ERUserAccountForAdminRegister >> descriptionRole [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #role;
		priority: 40;
		beRequired;
		options: ERAttendee rolesForAdminRegister;
		withoutLabel: true;
		id: 'role';
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]
