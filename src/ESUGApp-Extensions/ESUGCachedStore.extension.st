Extension { #name : #ESUGCachedStore }

{ #category : #'*ESUGApp-Extensions' }
ESUGCachedStore >> cachedLoadOfClass: aClass from: anId [
	^ (cache at: aClass)
		at: anId
		ifAbsent: [ 
			(self loadClass: aClass atId: anId)
				ifNotNil: [ :it |
					(cache at: aClass) at: anId put: it.
					it resolveReferences ] ]
]

{ #category : #'*ESUGApp-Extensions' }
ESUGCachedStore >> forClass: aClass at: anId ifAbsent: aHandler [
	aClass withAllSubclasses
		do: [ :class | ((cache at: class) at: anId ifAbsent: [ nil ]) 
			ifNotNil: [ :result | ^ result ] ].
	^ aHandler value
]

{ #category : #'*ESUGApp-Extensions' }
ESUGCachedStore >> forClass: aClass detect: aBlock ifFound: aHandler [
	aClass withAllSubclasses
		do: [ :class | 
			((cache at: class) detect: aBlock ifNone: [ nil ])
				ifNotNil: [ :found | 
					aHandler value: found.
					^ found ] ].
	^ nil
]
