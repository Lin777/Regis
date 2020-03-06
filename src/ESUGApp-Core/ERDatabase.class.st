"
Database of ESUGApp
"
Class {
	#name : #ERDatabase,
	#superclass : #Object,
	#category : #'ESUGApp-Core'
}

{ #category : #'class initialization' }
ERDatabase class >> initialize [

	ESUGActiveRecord resetStoreForLoad.
	ESUGActiveRecord setStore: ESUGMemoryStore new.
	ESUGActiveRecord warmUpAllClasses
]

{ #category : #'class initialization' }
ERDatabase class >> initializeWithStore: store [

	ESUGActiveRecord setStore: store.
	ESUGActiveRecord warmUpAllClasses
]
