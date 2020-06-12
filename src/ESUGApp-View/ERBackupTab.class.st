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
	#instVars : [
		'uploadFile'
	],
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

	^ {'Backup File' . 'Date/Time' . PSTableSortableHeaderOptions new cell: ''}
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
				with: [ :att | self restoreByFile: att ]
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

{ #category : #accessing }
ERBackupTab >> receiveFile: aFile [
	| contentFile backup uploadFileName |
	
	uploadFileName := aFile fileName.
	(uploadFileName matchesRegex: '^\b(esug)\b(\.[0-9]+)$')
		ifTrue: [ 
				contentFile := (aFile contentType: 'text/plain; charset=utf-8' seasideMimeType) 
							contentsDecoded.
				backup := STON fromString: contentFile.
				backup do: [ :aClass | aClass do: [ :anObject | anObject save ] ].
				self updateStateTab: self tabName.
						messageComponent class: 'alert-success'.
						messageComponent errorMessage: 'Successful restoration, log out and enter again' ]
		ifFalse: [ self updateStateTab: self tabName.
						messageComponent class: 'errors'.
						messageComponent errorMessage: 'Backup file error: Select a valid backup file' ].
]

{ #category : #rendering }
ERBackupTab >> renderBackupButtonOn: html [
	
	html div
		style: 'display: flex; justify-content: space-around;';
		with: [
		html form
			id: 'backup-form';
			style: 'display: flex; align-items: center;';
			multipart; 
			with: [
				html fileUpload
					id: 'backup-upload-file';
					style: 'margin: 0px 50px 0px 0px';
					callback: [ :value | self receiveFile: value ].
				html submitButton
					id: 'backup-upload-button';
					class: 'mdl-button mdl-js-button mdl-button--raised mdl-button--primary';
					with: 'Upload external backup' ].
		html mdlAnchorButton
			id: 'backup-now-button';
			raised;
			primaryColor;
			callback: [ self backup. self updateStateTab: self tabName ];
			with: 'Backup now'. ]
]

{ #category : #rendering }
ERBackupTab >> renderContainerOn: html [

	html render: messageComponent.
	html heading level6 with: 'This feature allows you to save all data. Only backups created on this page can be loaded.'.
	self renderBackupButtonOn: html.
	html horizontalRule.
	self renderTableBackupOn: html
]

{ #category : #rendering }
ERBackupTab >> renderTableBackupOn: html [

	table := ERTable new
		tableId: 'backup-table';
		header: self headers;
		levelTotal: 6;
		showPaginationBar: false;
		showSearchingField: false;
		showSelectionLimit: false;
		rows: self backupFiles;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		sortingMethod: self sortingMethodBackup. 
	html render: table
]

{ #category : #rendering }
ERBackupTab >> restoreByFile: aFile [
	
	| backup |
	[ 
		backup := aFile readStreamDo: [ :stream | STON fromString: stream contents ].
		backup do: [ :aClass | aClass do: [ :anObject | anObject save ] ].
		self updateStateTab: self tabName.
		messageComponent class: 'alert-success'.
		messageComponent errorMessage: 'Successful restoration, log out and enter again' ]
			on: PMException
			do: [ :exception | 
				messageComponent class: 'errors'.
				messageComponent errorMessage: exception messageText.
				self updateStateTab: self tabName ].
]

{ #category : #accessing }
ERBackupTab >> sortingMethodBackup [
	^ { [ :att | att path basename ]
		. [ :att | att asFileReference creationTime asDate ddmmyyyy, ' - ', att asFileReference creationTime asTime asString ] }
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
