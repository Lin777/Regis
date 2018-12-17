Class {
	#name : #ERRelationalDatabase,
	#superclass : #ERDatabase,
	#instVars : [
		'connection'
	],
	#classVars : [
		'WriteMutex'
	],
	#category : #'ESUGApp-DB'
}

{ #category : #'as yet unclassified' }
ERRelationalDatabase class >> connectionArguments [

 ^ PGConnectionArgs
  hostname: self hostname
  portno: self port
  databaseName: self databaseName
  userName: self userName
  password: self password.
]

{ #category : #accessing }
ERRelationalDatabase class >> databaseName [

 ^ 'esugapp'

]

{ #category : #accessing }
ERRelationalDatabase class >> hostname [

 ^ 'localhost'

]

{ #category : #accessing }
ERRelationalDatabase class >> password [

 ^ 'esug'

]

{ #category : #accessing }
ERRelationalDatabase class >> port [

 ^ 5432
]

{ #category : #'as yet unclassified' }
ERRelationalDatabase class >> setup [
	self new
		connect ;
		"createTables;"
		disconnect.
]

{ #category : #accessing }
ERRelationalDatabase class >> userName [

 ^ 'esug'
]

{ #category : #writing }
ERRelationalDatabase class >> writeMutex [
  
 ^ WriteMutex ifNil: [WriteMutex := Monitor new]
]

{ #category : #actions }
ERRelationalDatabase >> connect [

 "self connection: (PGConnection new
  connectionArgs: self class connectionArguments;
  startup;
  yourself)."
]

{ #category : #accessing }
ERRelationalDatabase >> connection [
	^ connection
]

{ #category : #accessing }
ERRelationalDatabase >> connection: anObject [
	connection := anObject
]

{ #category : #actions }
ERRelationalDatabase >> connectionFailed [

 ^ self connection isNil or: [self connection isConnected not]
]

{ #category : #actions }
ERRelationalDatabase >> disconnect [

 (self connection notNil and: [self connection isConnected])
  ifTrue: [self connection terminate].
]

{ #category : #actions }
ERRelationalDatabase >> initialize [

 super initialize.
 self connect.
]
