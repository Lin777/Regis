Class {
	#name : #ERUserAccountForEdit,
	#superclass : #ERUserAccount,
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
		options: ERAttendee roles;
		withoutLabel: true;
		id: 'role';
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]
