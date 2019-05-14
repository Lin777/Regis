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
	
	(self hasOption: '--no-quit')
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
	ERSandstoneDatabase initialize.
]

{ #category : #'as yet unclassified' }
RestoreCommandLineHandler >> deleteBackupFolder [
	((FileSystem workingDirectory asFileReference / 'Backup')
		 ensureCreateDirectory) ensureDeleteAll
]

{ #category : #activation }
RestoreCommandLineHandler >> evaluateArguments [
	| argumentString |
	argumentString :=  self argumentString.
	argumentString ifEmpty: [ ^ self ].
	self restore: argumentString
]

{ #category : #initialization }
RestoreCommandLineHandler >> initializeAllObjects [	
	ERUserAccount warmUp.
	ERAttendee warmUp.
	ERAward warmUp.
	ERReductionTicket warmUp.
	ERFee warmUp.
	ERGroup warmUp.
	ERTalk warmUp.
	ERConference warmUp.
	ERSandstoneDatabase initialize.
]

{ #category : #'as yet unclassified' }
RestoreCommandLineHandler >> restore: aStream [
	[ self deleteBackupFolder.
	self deleteAll .
	ERBackupRestore uniqueInstance restoreBackup: aStream asString.
	self hasSessionChanged
		ifFalse: [ 
			self stdout
				print: 'Restore succesfull';
				lf ] ]
		on: Error
		do: [ :error | self handleError: error]
]
