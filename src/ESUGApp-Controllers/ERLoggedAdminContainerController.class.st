Class {
	#name : #ERLoggedAdminContainerController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controllers'
}

{ #category : #'as yet unclassified' }
ERLoggedAdminContainerController >> updateUserFields: anUser [
	(ERUserAccount findUserByEmail: anUser email) ifNil: [ ^ anUser save ].
	^ nil
]
