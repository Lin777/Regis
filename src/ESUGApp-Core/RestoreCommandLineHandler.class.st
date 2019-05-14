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
		
	self evaluateArguments.
	
	(self hasOption: 'no-quit')
		ifFalse: [ self quit ]
]

{ #category : #activation }
RestoreCommandLineHandler >> argumentString [
	| arguments skipArguments |
	
	"Now this is ugly... Coral would be nice here! Basically we strip skipArguments if, and only if they appear at the beginning of arguments"
	skipArguments := #( '--no-quit' '--save' '-rlb' '--restore').

	arguments := (skipArguments includes: self arguments first)
		ifFalse: [ self arguments ]
		ifTrue: [
			(self arguments size >= 2 and: [ skipArguments includes: self arguments second ])
				ifTrue: [ self arguments allButFirst: 2 ]
				ifFalse: [ self arguments allButFirst ]].
		
	^ arguments joinUsing: Character space.
]

{ #category : #activation }
RestoreCommandLineHandler >> evaluateArguments [
	| argumentString |
	argumentString :=  self argumentString.
	argumentString ifEmpty: [ ^ self ].
	self restore: argumentString
]

{ #category : #'as yet unclassified' }
RestoreCommandLineHandler >> restore: aStream [
	[ ERBackupRestore uniqueInstance restoreBackup: aStream asString.
	self hasSessionChanged
		ifFalse: [ 
			self stdout
				print: 'Restore succesfull';
				lf ] ]
		on: Error
		do: [ :error | self handleError: error]
]
