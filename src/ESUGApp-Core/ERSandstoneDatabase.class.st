Class {
	#name : #ERSandstoneDatabase,
	#superclass : #Object,
	#instVars : [
		'connection'
	],
	#classVars : [
		'WriteMutex'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #initialization }
ERSandstoneDatabase class >> initialize [
	"self initialize"
	"With SDMemoryStore as default store"
	SDActiveRecord setStore: SDMemoryStore new.
	SDActiveRecord warmUpAllClasses
]

{ #category : #initialization }
ERSandstoneDatabase class >> initializeWithStore: store [
	"self initialize"
	SDActiveRecord setStore: store.
	SDActiveRecord warmUpAllClasses
]
