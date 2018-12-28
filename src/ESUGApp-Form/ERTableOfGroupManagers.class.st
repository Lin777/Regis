Class {
	#name : #ERTableOfGroupManagers,
	#superclass : #ERTable,
	#category : #'ESUGApp-Form'
}

{ #category : #rendering }
ERTableOfGroupManagers >> deleteAGroupManager: aGroupManager [
]

{ #category : #rendering }
ERTableOfGroupManagers >> generateInvoice: aGroupManager [
]

{ #category : #rendering }
ERTableOfGroupManagers >> headers [
	^ #('Name (D)'	'Email	' 'Organization' 	'Remaing Fee' 'Have all Pay?' ''	)
]

{ #category : #rendering }
ERTableOfGroupManagers >> modifyAGroupManager: aGroupManager [
]

{ #category : #rendering }
ERTableOfGroupManagers >> renderAnItem: anItem at: html [
	html mdlTableHeading: anItem firstName.
	html mdlTableHeading: anItem email.
	html mdlTableHeading: anItem orgName.
	html mdlTableHeading: '660.00 Euros'.
	html mdlTableHeading: 'No'.
	html mdlTableHeading: [ self renderButtonsOfAnGroupManager: anItem at: html ]
]

{ #category : #rendering }
ERTableOfGroupManagers >> renderButtonsOfAnGroupManager: anItem at: html [
	self
		createColoredButton: 'Modify'
		with: [ self modifyAGroupManager: anItem ]
		id: anItem id , '-modify'
		on: html.
	self
		createColoredButton: 'Delete'
		with: [ self deleteAGroupManager: anItem ]
		id: anItem id , '-delete'
		on: html.
	self
		createColoredButton: 'Modify User'
		with: [ self modifyUserFormGroup: anItem ]
		id: anItem id , '-modifyUser'
		on: html.
	self
		createColoredButton: 'Reset password'
		with: [ self resetPasswordAGroupManager: anItem ]
		id: anItem id , '-resetPassword'
		on: html.
	self
		createColoredButton: 'Invoice'
		with: [ self generateInvoice: anItem ]
		id: anItem id , '-invoice'
		on: html
]

{ #category : #rendering }
ERTableOfGroupManagers >> resetPasswordAGroupManager:aGroupManager [
]
