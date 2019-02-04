Class {
	#name : #ERUserAccountForAdminRegister,
	#superclass : #ERUserAccountForRegister,
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
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
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]
