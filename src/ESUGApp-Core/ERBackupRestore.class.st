"
Description
--------------------

I am a class that control the generation of backup of page.

Instance Variables
--------------------
	version: a Number with that each backup will be saved
"
Class {
	#name : #ERBackupRestore,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
ERBackupRestore class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #'actions api' }
ERBackupRestore >> backup [
	| file |
	[ [ self lock
		critical: [ self backupDirectory.
			file := self referenceFile.
			self truncateVersions.
			self writeSTONFile: file. ] ]
		on: Error
		do: [ :error | ERException backupError signal ] ]
		forkAt: Processor systemBackgroundPriority
		named: self subProcessName.
	^ self backupFileName
]

{ #category : #accessing }
ERBackupRestore >> backupDirectory [
	^ (FileSystem workingDirectory asFileReference / self nameDirectory)
		 ensureCreateDirectory
]

{ #category : #'actions api' }
ERBackupRestore >> backupFileName [
	^ ''
		join:
			{self fileNamePrefix.
			'.'.
			self version}
]

{ #category : #accessing }
ERBackupRestore >> backupFilenames [

	^ self backupDirectory files select: [ :fileName |
		(fileName path basename) beginsWith: self fileNamePrefix ]
]

{ #category : #accessing }
ERBackupRestore >> fileNamePrefix [
	^ 'esug'
]

{ #category : #actions }
ERBackupRestore >> incrementVersionNumber [
	^ version := self version + 1
]

{ #category : #accessing }
ERBackupRestore >> lastBackup [
	| lastBackup file |
	lastBackup := self lastBackupFilename.
	file := self referenceBackupFile: lastBackup.
	lastBackup ifNil: [ ^ nil ].
	^ self readSTONOf: file
]

{ #category : #accessing }
ERBackupRestore >> lastBackupFilename [
	^ self backupFilenames detectMax: [ :fileName | 
		self versionOf: (fileName path basename) ]
]

{ #category : #'actions api' }
ERBackupRestore >> lock [ 
	^ Semaphore forMutualExclusion 
]

{ #category : #accessing }
ERBackupRestore >> nameDirectory [
	^ 'Backup'
]

{ #category : #accessing }
ERBackupRestore >> objectsToBackup [
	^ OrderedCollection new
		add: ERFee findAll;
		add: ERUserAccount findAll;
		add: ERReductionTicket findAll;
		add: ERAttendee findAll;
		add: ERGroup findAll;
		add: ERAward findAll;
		add: ERTalk findAll;
		add: ERConference findAll;
		yourself
]

{ #category : #'actions api' }
ERBackupRestore >> readSTONOf: aFile [
	^ aFile readStreamDo: [ :stream | STON fromString: stream contents ]
]

{ #category : #accessing }
ERBackupRestore >> referenceBackupFile: lastBackup [
	^ (''
		join:
			{self nameDirectory.
			'/'.
			lastBackup path basename}) asFileReference
]

{ #category : #'actions api' }
ERBackupRestore >> referenceFile [
	^ (''
		join:
			{self nameDirectory.
			'/'.
			self fileNamePrefix.
			'.'.
			self incrementVersionNumber}) asFileReference
]

{ #category : #'actions api' }
ERBackupRestore >> restoreBackup [
	self updateVersionToLastVersionOfBackup.
	self lastBackup ifNotNil: [ :backup | backup do: 
		[ :aClass | aClass do: [ :anObject | anObject save ] ] ]
]

{ #category : #'actions api' }
ERBackupRestore >> restoreBackup: aFilePath [
	| aFile |
	self updateVersionToLastVersionOfBackup: aFilePath.
	[ aFile ifNotNil: [ :backup | backup do:
		[ :aClass | aClass do: [ :anObject | anObject save ] ] ] ]
	on: FileDoesNotExistException 
	do: [ :exp | exp signal ].
	
]

{ #category : #'actions api' }
ERBackupRestore >> subProcessName [
	^ ''
		join:
			{'backup:'.
			self version}
]

{ #category : #accessing }
ERBackupRestore >> transformedObjectsToSTON [
	^ STON toStringPretty: self objectsToBackup
]

{ #category : #actions }
ERBackupRestore >> truncateVersions [

	| files |
	files := self backupDirectory allFiles.
	(files select: [ :n | (n extension asNumber <= (self version - 10)) ]) do: #delete
]

{ #category : #'actions api' }
ERBackupRestore >> updateVersionToLastVersionOfBackup [
	self version: ( self versionOf: self lastBackupFilename path basename)
]

{ #category : #'actions api' }
ERBackupRestore >> updateVersionToLastVersionOfBackup: aFilePath [
	|lastBackup|
	lastBackup := ERBackupRestore new lastBackupFilename.
	lastBackup ifNil: [ 
		self version: ( self versionOf: (aFilePath splitOn: '/')last) ]
	ifNotNil: [ 
		self version: ( self versionOf: lastBackup path basename) ]
]

{ #category : #accessing }
ERBackupRestore >> version [
	version ifNil: [ version := 0 ].
	 ^ version
]

{ #category : #accessing }
ERBackupRestore >> version: aNumber [
	version := aNumber
]

{ #category : #accessing }
ERBackupRestore >> versionOf: fileName [
	^ (fileName substrings: '.' ) last asInteger 
]

{ #category : #'actions api' }
ERBackupRestore >> writeSTONFile: file [
	^ file
		writeStreamDo:
			[ :stream | stream nextPutAll: self transformedObjectsToSTON ]
]
