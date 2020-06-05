"
Description
--------------------

Tab of configuration of page.

- I can Open and Close the registration of conference.
- I can do a manual Backup
"
Class {
	#name : #ERBackupTab,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #actions }
ERBackupTab >> backup [
	[ ERBackupRestore uniqueInstance backup.] 
		on: ERException 
		do: [ :exc | messageComponent changeToAlertOfError .
			messageComponent errorMessage: 'The backup could not be made' ]
]

{ #category : #initialization }
ERBackupTab >> initialize [
	super initialize.
	messageComponent := messageComponent id: 'tabAlertOfconfiguration'.

]

{ #category : #rendering }
ERBackupTab >> renderBackupButtonOn: html [

	html horizontalRule.
	html render: messageComponent.
	html heading level6 with: 'This feature allows you to save all data.'.
	html mdlAnchorButton
		raised;
		primaryColor;
		callback: [ self backup. self updateStateTab: self tabName ];
		with: 'Back up now'.
	html horizontalRule.
]

{ #category : #rendering }
ERBackupTab >> renderContainerOn: html [

	self renderBackupButtonOn: html
]

{ #category : #rendering }
ERBackupTab >> restore [
]

{ #category : #accessing }
ERBackupTab >> tabId [
	^ 'tabBackup'
]

{ #category : #accessing }
ERBackupTab >> tabName [
	^ 'Backup'
]

{ #category : #accessing }
ERBackupTab >> title [ 	
	^ 'Backup'
]
