"
I am an Observer subclass to do a backup (this will use to do an Automatically backup)
"
Class {
	#name : #ERBackupObserver,
	#superclass : #ERObserver,
	#category : #'ESUGApp-Core'
}

{ #category : #'instance creation' }
ERBackupObserver class >> of: anObject [
	^ self new 
		subject: anObject; 
		yourself 
]

{ #category : #updating }
ERBackupObserver >> update [ 
	ERBackupRestore uniqueInstance backup 
]
