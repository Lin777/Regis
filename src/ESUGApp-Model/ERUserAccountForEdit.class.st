Class {
	#name : #ERUserAccountForEdit,
	#superclass : #ERUserAccount1,
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERUserAccountForEdit >> descriptionRole [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #role;
		priority: 60;
		beRequired;
		options: ERAttendee1 roles;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]
