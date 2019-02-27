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

{ #category : #initialization }
ERBackupRestore >> backup [ 	
	[[self lock critical: [ 
		self backupDirectory .
		SDFuelSerializer new serialize:
			(self objectsToBackup) toFile: ('' join: {self nameDirectory .'/'.self fileNamePrefix.'.'.self incrementVersionNumber})]] on: Error do: [ :error | ERException backupError signal ]]
		forkAt: Processor systemBackgroundPriority
		named: ('' join: {'backup:'.self version}).
		^ ('' join: {self fileNamePrefix.'.'.self version}) 
]

{ #category : #initialization }
ERBackupRestore >> backupDirectory [
	^ (FileSystem workingDirectory asFileReference / self nameDirectory)
		 ensureCreateDirectory
]

{ #category : #initialization }
ERBackupRestore >> backupFilenames [

	^ self backupDirectory files select: [ :fileName |
		(fileName path basename) beginsWith: self fileNamePrefix ]
]

{ #category : #initialization }
ERBackupRestore >> fileNamePrefix [
	^ 'esug'
]

{ #category : #'as yet unclassified' }
ERBackupRestore >> incrementVersionNumber [
	^ version := self version + 1
]

{ #category : #initialization }
ERBackupRestore >> lastBackup [
	|lastBackup|
	lastBackup := self lastBackupFilename .
	lastBackup ifNil: [ ^ nil ].
	
	^ SDFuelSerializer new materializeFromFile: ('' join: {self nameDirectory .'/'.lastBackup path basename })
]

{ #category : #initialization }
ERBackupRestore >> lastBackupFilename [
	^ self backupFilenames detectMax: [ :fileName | 
		self versionOf: (fileName path basename)]
]

{ #category : #'actions api' }
ERBackupRestore >> lock [ 
	^ Semaphore forMutualExclusion 
]

{ #category : #initialization }
ERBackupRestore >> nameDirectory [
	^ 'Backup'
]

{ #category : #'as yet unclassified' }
ERBackupRestore >> objectsToBackup [
	^ OrderedCollection new 
		add: ERFee findAll;
		add: ERUserAccount findAll;
		add: ERReductionTicket findAll;
		add: ERAttendee findAll;
		add: ERAward findAll ;
		add: ERGroup findAll;
		add: ERTalk findAll;
		add: ERConference findAll;
		yourself
]

{ #category : #'as yet unclassified' }
ERBackupRestore >> restoreBackup [
	self lastBackup ifNotNil: [ :backup | backup do: 
		[ :aClass | aClass do: [ :anObject | anObject save ] ] ]
]

{ #category : #accessing }
ERBackupRestore >> version [
	version ifNil: [ version := 0 ].
	 ^ version
]

{ #category : #'as yet unclassified' }
ERBackupRestore >> versionOf: fileName [
	^ (fileName substrings: '.' ) last asInteger 
]
