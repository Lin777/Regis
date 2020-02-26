"
I'm a store for persisting active records directly to disk via a SmartReference stream with a few extentions to make it non interactive.
"
Class {
	#name : #ESUGFileStore,
	#superclass : #ESUGCachedStore,
	#classInstVars : [
		'serializer'
	],
	#category : #'ESUGApp-Database-Store'
}

{ #category : #accessing }
ESUGFileStore class >> serializer [	
	"^ serializer ifNil: [ serializer := ESUGSmartRefStreamSerializer new ]"
]

{ #category : #accessing }
ESUGFileStore class >> serializer: aSerializer [	
	serializer := aSerializer
]

{ #category : #actions }
ESUGFileStore >> commit: aBlock [
	self shouldNotImplement
]

{ #category : #defaults }
ESUGFileStore >> defaultBaseDirectory [
	"you can override this if you want to force the db somewhere else"
	^ FileLocator imageDirectory / FileLocator image basenameWithoutExtension , 'SandstoneDb'

]

{ #category : #'crash recovery' }
ESUGFileStore >> deleteFailedCommitsForClass: aClass [ 
	"all remaining .new files are failed commits, kill them"

	[ (self dirForClass: aClass) allChildren 
		select: [ :each | 
			each basename endsWith: '.new' ]
		"thenDo: [ :each | FileDirectory deleteFilePath: each ] ] "
		thenDo: [ :each | 
			each delete] ] 
		on: Error
		do: [ :err | Transcript show: 'deleteFailedCommitsForClass: ' , err printString ; cr ]
]

{ #category : #queries }
ESUGFileStore >> dirForClass: aClass [ 
	"compute the path of superclasses all the way up to ActiveRecord, storing 
	subclass records as a subdirectory of the superclasses directory 
	allows ActiveRecord to deal with inheritance"
	| parentClass lineage |
	aClass == SDActiveRecord ifTrue: 
		[ Error signal: 'ActiveRecord itself is abstract, you must only  
 store subclasses' ].
	lineage := OrderedCollection with: aClass.
	parentClass := aClass superclass.
	[ parentClass == SDActiveRecord ] whileFalse: 
		[ lineage addFirst: parentClass.
		parentClass := parentClass superclass ].
	^ lineage 
		inject: self defaultBaseDirectory
		into: [ :dir :each | dir / each name ]
]

{ #category : #queries }
ESUGFileStore >> dirForClass: aClass atId: anId [ 
	"Grab the correct hashed subdirectory for this record"
	^ (self dirForClass: aClass) / (self dirNameFor: anId)
]

{ #category : #queries }
ESUGFileStore >> dirNameFor: anId [ 
	"Answers a string with one decimal digit corresponding to anId.  There is a bug
	in this that does not ever hash to the directory 1, but because of existing datasets
	this must remain, do not want to rehash my databases and it is no big deal"
	self flag: #knownBug.
	^ (anId inject: 0 into: [ : sum : e | sum + e asInteger ]) asReducedSumOfDigits asString
]

{ #category : #actions }
ESUGFileStore >> ensureDown [
	self initializeCache
]

{ #category : #actions }
ESUGFileStore >> ensureForClass: aClass [ 
	| dir |
	super ensureForClass: aClass.
	dir := (self dirForClass: aClass) ensureCreateDirectory .
	0 
		to: 9
		do: [ :num | (dir / num asString) ensureCreateDirectory ].
]

{ #category : #'delegated queries' }
ESUGFileStore >> familyForClass: aClass [ 
	"I'm returing raw cache dictionary here because this read only copy
	doesn't need concurrency protection, just a naked dictionary''"
	^ aClass allSubclasses 
		inject: (cache at: aClass) dictionary
		into: [ :sum :subclass | sum , (cache at: subclass) dictionary ]
]

{ #category : #'crash recovery' }
ESUGFileStore >> finishPartialCommitsForClass: aClass [ 
	"find where .new exists but .obj doesn't, rename .obj.new to
	.obj to finish commit'"
	
	[ (self dirForClass: aClass) allFiles 
		select: [ :each | 
			(each basename) endsWith: '.obj.new' ]
		thenDo: 
			[ :each | 
			| objFile dir |
			objFile := (each basename)
					copyReplaceAll: '.new'
					with: '' .
			dir := each parent .
			((dir / objFile) exists) ifFalse: 
				[ each renameTo: objFile ] ] ] 
		on: Error
		do: 
			[ :err | 
			Transcript
				show: 'finishPartialCommitsForClass: ' , err printString;
				cr ]
]

{ #category : #'crash recovery' }
ESUGFileStore >> loadChangesForClass: aClass [ 
	| id obj |
	"(self dirForClass: aClass) withSubdirectoriesDo: [ :dir | "
	FileSystem disk directoriesAt: (self dirForClass: aClass) do: [ :dir |
		[ dir asFileReference entries do: 
			[ :each | 
			"there could be tens of thousands of entries, so using do with 
			a condition to avoid the copy a select would generate"
			each isDirectory ifFalse: 
				[ id := each basename copyUpTo: $. .
				obj := (cache at: aClass) at: id ifAbsent: [ nil ].
				obj 
					ifNil: [ self cachedLoadOfClass: aClass from:  id ]
					ifNotNil: [ obj abortChanges ] ] ] ]
			on: Error
			do: [ :err | 
				Transcript show: 'loadChangesForClass: ' , err messageText; cr ] ]
]

{ #category : #actions }
ESUGFileStore >> loadClass: aClass atId: anId [
	[ 
	| obj name |
	name := (self dirForClass: aClass atId: anId) /  (anId , '.obj').
	obj := self class serializer materializeFromFile: name.
	^ obj
		onLoad;
		yourself ] on: Error do: [ :err | 
			SDLoadError signal: 'loadClass:atId: - loadClass: Loading id=' , anId , '. ' , err messageText ]
]

{ #category : #actions }
ESUGFileStore >> recoverForClass: aClass [ 
	self
		finishPartialCommitsForClass: aClass;
		deleteFailedCommitsForClass: aClass;
		loadChangesForClass: aClass
]

{ #category : #actions }
ESUGFileStore >> removeObject: anObject [
	| dir |
	super removeObject: anObject.
	dir := self dirForClass: anObject class atId: anObject id.	

	(dir / anObject id , 'obj') ensureDelete.
	(dir / anObject id , 'new') ensureDelete.
	(dir / anObject id , 'old') ensureDelete.
	
]

{ #category : #actions }
ESUGFileStore >> storeObject: origObject [

	| currentVersion newVersion oldVersion dir anObject |
	super storeObject: origObject.
	anObject := origObject sandstoneDeepCopy sandstoneMarkReferences.
	dir := self dirForClass: anObject class atId: anObject id.
	currentVersion := (dir / anObject id) absolutePath , 'obj'.
	newVersion := currentVersion , 'new'.
	oldVersion := currentVersion , 'old'.
	newVersion asFileReference ensureDelete.
	self class serializer serialize: anObject toFile: newVersion.
	oldVersion asFileReference ensureDelete .	
	[ currentVersion asFileReference renameTo: oldVersion basename ]
		ifError: [ 
		].
	newVersion asFileReference renameTo: currentVersion basename .
	oldVersion asFileReference ensureDelete .
]

{ #category : #actions }
ESUGFileStore >> updateObject: anObject [
	self storeObject: anObject
]
