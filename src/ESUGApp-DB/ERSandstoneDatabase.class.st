Class {
	#name : #ERSandstoneDatabase,
	#superclass : #Object,
	#instVars : [
		'connection'
	],
	#classVars : [
		'WriteMutex'
	],
	#category : #'ESUGApp-DB'
}

{ #category : #initialization }
ERSandstoneDatabase class >> initialize [
	"self initialize"

	SDActiveRecord warmUpAllClasses
]
