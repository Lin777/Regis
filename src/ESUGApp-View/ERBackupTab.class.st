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

{ #category : #accessing }
ERBackupTab >> backupFiles [

	self fileReference exists
		ifTrue: [ ^ self fileReference files asOrderedCollection sort: [ :fileA :fileB | (self idOfBackup: fileA path basename) asNumber > (self idOfBackup: fileB path basename) asNumber ] ]
		ifFalse: [ ^ OrderedCollection new ]
]

{ #category : #accessing }
ERBackupTab >> backupFolderName [

	^ 'Backup'
]

{ #category : #tableBlock }
ERBackupTab >> blockTableToExecute [
	^ [ :aFile | 
	OrderedCollection new
		add: ([ :att | att path basename ] value: aFile);
		add: ([ :att | att asFileReference creationTime asDate ddmmyyyy, ' - ', att asFileReference creationTime asTime asString ] value: aFile);
		yourself ]
]

{ #category : #actions }
ERBackupTab >> downloadBackup: backupFile [

	self requestContext respond: [ :response |
		|stream file |
		file := backupFile asFileReference.
		stream := file.
		response
            contentType: WAMimeType textPlain;
            document: stream contents;
            attachmentWithFileName: (backupFile path basename) ]
]

{ #category : #accessing }
ERBackupTab >> fileReference [
	^ FileSystem workingDirectory asFileReference / self backupFolderName
]

{ #category : #accessing }
ERBackupTab >> headers [

	^ #('Backup File' 'Date/Time' '')
]

{ #category : #accessing }
ERBackupTab >> idOfBackup: backupFileName [

	^ (backupFileName substrings: '.') at: 2.
]

{ #category : #initialization }
ERBackupTab >> initialize [
	super initialize.
	messageComponent := messageComponent id: 'tabAlertOfconfiguration'.

]

{ #category : #tableBlock }
ERBackupTab >> listDataToRenderButton [

	^ OrderedCollection new
		add:
			(Array
				with: 'backup'
				with: [ :att | "Add functionality" ]
				with: [ :att | self idOfBackup: att path basename, '-load' ]
				with: 'Load Backup'
				with: ''
				with: false);
		add:
			(Array
				with: 'get_app'
				with: [ :att | self downloadBackup: att ]
				with: [ :att | self idOfBackup: att path basename, '-download' ]
				with: 'Download backup'
				with: ''
				with: false);
		yourself
]

{ #category : #rendering }
ERBackupTab >> renderBackupButtonOn: html [

	html render: messageComponent.
	html heading level6 with: 'This feature allows you to save all data.'.
	"html mdlAnchorButton
		raised;
		primaryColor;
		callback: [ self backup. self updateStateTab: self tabName ];
		with: 'Back up now'."
	html horizontalRule.
]

{ #category : #rendering }
ERBackupTab >> renderContainerOn: html [

	html render: messageComponent.
	html heading level6 with: 'This feature allows you to save all data.'.
	html horizontalRule.
	self renderTableBackupOn: html
]

{ #category : #rendering }
ERBackupTab >> renderTableBackupOn: html [

	table := ERTable new
		tableId: 'backup-table';
		limitPerPage: 10;
		limitPageShowed: 3;
		headers: self headers;
		levelTotal: 6;
		disablePagination: true;
		disableSearching: true;
		listObject: self backupFiles;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
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
	^ ''
]
