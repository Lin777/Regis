"
Usage: restore [--help] [--save] [ --no-quit ] <path of backup file>
	--help                   list this help message
	--save                   save the image after restore
	--no-quit                if specified, the image continues runing after
	                         restore data
	<path of backup file>    path of backup file to restore and 
	                         the result is printed on stdout

Documentation:

This handler restore the path (path from root) passed to the image:
	pharo Pharo.image restore ""/complet/path/of/backup/file/esug.1""
	
You also can use this command whitout especify a path, and this use by default a path of last backup
	pharo Pharo.image restore
"
Class {
	#name : #RestoreCommandLineHandler,
	#superclass : #STCommandLineHandler,
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
RestoreCommandLineHandler class >> commandName [
	^ 'restore'
]

{ #category : #accessing }
RestoreCommandLineHandler class >> description [
	^ 'Restore the last backup'
]

{ #category : #'handler selection' }
RestoreCommandLineHandler class >> isResponsibleFor: commandLineArguments [
	"directly handle top-level -e and --evaluate options"
	commandLineArguments withFirstArgument: [ :arg| 
		(#('-rlb' '--restore') includes: arg)
			ifTrue: [ ^ true ]].
	
	^ commandLineArguments includesSubCommand: self commandName
]

{ #category : #activation }
RestoreCommandLineHandler >> activate [
	self activateHelp
		ifTrue: [  ^ self ].
		
	self arguments 
		ifEmpty: [ ^ self ].
		
	self evaluateArguments.
	
	(self hasOption: 'save')
		ifTrue: [ 
			^ Smalltalk 
				snapshot: true 
				andQuit: (self hasOption: 'no-quit') not ].
	
	(self hasOption: 'no-quit')
		ifFalse: [ self quit ]
]

{ #category : #activation }
RestoreCommandLineHandler >> argumentString [
	| arguments skipArguments |
	
	skipArguments := #( '--no-quit' '--save' '-rlb' '--restore').

	arguments := (skipArguments includes: self arguments first)
		ifFalse: [ self arguments ]
		ifTrue: [
			(self arguments size >= 2 and:
			 [ skipArguments includes: self arguments second ])
				ifTrue: [ self arguments allButFirst: 2 ]
				ifFalse: [ self arguments allButFirst ]].
		
	^ arguments joinUsing: Character space.
]

{ #category : #modifying }
RestoreCommandLineHandler >> deleteAll [ 	
	self initializeAllObjects.
	ERAttendee
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERAttendee coolDown.
	ERAward
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERAward coolDown.	
	ERFee
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERFee coolDown.
	ERGroup
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERGroup coolDown.
	ERReductionTicket
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERReductionTicket coolDown.
	ERTalk
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERTalk coolDown.
	ERUserAccount
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERUserAccount coolDown.
	ERConference
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERConference coolDown.
	self initializeAllObjects
]

{ #category : #activation }
RestoreCommandLineHandler >> evaluateArguments [
	| argumentString |
	argumentString :=  self argumentString.
	argumentString ifEmpty: [ ^ self restore ].
	self restore: argumentString
]

{ #category : #'as yet unclassified' }
RestoreCommandLineHandler >> handleError: error [	
	
	"for syntax errors we can used the default action"	"otherwise resignal it"
	(error isKindOf: FileDoesNotExistException)
		ifTrue: [ self printFileNotFoundWarning: error .
			self exitFailure ]
		ifFalse: [ error pass ]
]

{ #category : #initialization }
RestoreCommandLineHandler >> initializeAllObjects [	
	ERDatabase initialize.
]

{ #category : #'as yet unclassified' }
RestoreCommandLineHandler >> printFileNotFoundWarning: aFileException [
	| errorMessage  |
	
	stderr := VTermOutputDriver stderr.
		
	"first gather the error title to be able to underline it properly"
	errorMessage := String streamContents: [ :s|
		s nextPutAll: 'File does not exist: '; 
			print: aFileException messageText ].
	
	 stderr red;
		nextPutAll: errorMessage; lf;
		nextPutAll: ('' padLeftTo: errorMessage size with: $=); lf;
		clear.
]

{ #category : #'as yet unclassified' }
RestoreCommandLineHandler >> restore [
	[ self deleteAll.
	ERBackupRestore uniqueInstance restoreBackup.
	self hasSessionChanged
		ifFalse: [ 
			self stdout
				print: 'Restore succesfull';
				lf ] ]
		on: Error
		do: [ :error | self handleError: error]
]

{ #category : #'as yet unclassified' }
RestoreCommandLineHandler >> restore: aStream [
	[ self deleteAll.
	ERBackupRestore uniqueInstance restoreBackup: aStream asString.
	self hasSessionChanged
		ifFalse: [ 
			self stdout
				print: 'Restore succesfull';
				lf ] ]
		on: Error
		do: [ :error | self handleError: error]
]
