"
Description
--------------------

I am a controller for configuration of conference, this is only use for admin user.

I can:
 
	- configure the application
"
Class {
	#name : #ERConfigurationController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #action }
ERConfigurationController >> closeRegistration [

	self conference closeRegistration.
	self notifyAllObservers
]

{ #category : #action }
ERConfigurationController >> openRegistration [
	conference openRegistration.
	self notifyAllObservers
]

{ #category : #saving }
ERConfigurationController >> saveFileOn: aFile withStream: stream [
	aFile
		ensureDelete;
		binaryWriteStreamDo: [ :outputStream | 
			(ZnCharacterWriteStream on: outputStream encoding: 'utf8')
				nextPutAll: stream contents ]
]
