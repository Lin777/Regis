Class {
	#name : #BaselineOfESUGApp,
	#superclass : #BaselineOf,
	#classVars : [
		'Initialized'
	],
	#category : #BaselineOfESUGApp
}

{ #category : #baselines }
BaselineOfESUGApp >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec postLoadDoIt: #'postload:package:'.
		
			self setUpDependencies: spec.
			spec
				package: 'ESUGApp-Exception';
				package: 'ESUGApp-Model' with: [ spec requires: 'SandstoneDb' ];
				package: 'ESUGApp-Controller' with: [ spec requires: #('Seaside3' 'NeoCSV' 'ESUGApp-Exception') ];
				package: 'ESUGApp-DB' with: [ spec requires: #('SandstoneDb' 'ESUGApp-Model') ];
				package: 'ESUGApp-SetUp' with: [ spec requires: #('ESUGApp-View' 'Seaside3') ];		
				package: 'ESUGApp-Library'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Model') ];
				package: 'ESUGApp-Form'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Library' 'ESUGApp-Component' 'ESUGApp-View') ];
				package: 'ESUGApp-Component'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Controller') ];
				package: 'ESUGApp-SandstoneDB' with: [ spec requires: #('SandstoneDb') ];
				package: 'ESUGApp-View'
					with: [ spec
						requires:
							#('Seaside3' 'MaterialDesignLite' 'ESUGApp-Library' 'ESUGApp-Controller' 'ESUGApp-Component') ];
				package: 'ESUGApp-Test'
					with: [ spec
						requires: #('SandstoneDb' 'ESUGApp-View' 'ESUGApp-DB' 'ESUGApp-Model' 'ESUGApp-SetUp') ]";
				package: 'ESUGApp-MDLMagritte' with: [ spec
						requires:
							#('Seaside3' 'MaterialDesignLite' 'ESUGApp-SetUp')]"]
]

{ #category : #baselines }
BaselineOfESUGApp >> loadArtefact [
	Metacello new
        githubUser: 'pharo-contributions' project: 'Artefact' commitish: 'master' path: 'src';
        baseline: 'Artefact';
        onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
        load.
]

{ #category : #baselines }
BaselineOfESUGApp >> loadMagritte [
	Metacello new
	baseline: 'Magritte';
		repository: 'github://magritte-metamodel/magritte:master/source';
		onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
		load: #('Magritte-Seaside')
]

{ #category : #baselines }
BaselineOfESUGApp >> loadMagritteForMDL [
	Metacello new 
		baseline: 'MaterialDesignLite'; 
		repository: 'github://DuneSt/MaterialDesignLite:v2.1.1/src';
		onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec 		isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
		load: 'all'.
	
]

{ #category : #baselines }
BaselineOfESUGApp >> postload: loader package: packageSpec [
	
	"Ignore pre and post loads if already executed"
	| initializersEnabled repo gofer |
	"self halt."
	Initialized = true ifTrue: [ ^ self ].
	
	initializersEnabled := MCMethodDefinition initializersEnabled.

	MCMethodDefinition initializersEnabled: false.
	
	"repo := TonelRepository new
	directory: self packageRepository directory;
	yourself."
	self loadMagritte .
	self loadMagritteForMDL .
	self loadArtefact .
	
	MCMethodDefinition initializersEnabled: initializersEnabled.
	Smalltalk cleanOutUndeclared.
	
	
	Initialized := true.
]

{ #category : #baselines }
BaselineOfESUGApp >> setUpDependencies: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec
				repository: 'github://SeasideSt/Seaside:master/repository' ].
	"spec
		baseline: 'Parasol'
		with: [ spec
				loads: 'tests';
				repository: 'github://SeasideSt/Parasol/repository' ]."
	spec
		baseline: 'MaterialDesignLite'
		with: [ spec repository: 'github://DuneSt/MaterialDesignLite:master/src' ].
	
	spec
		project: 'SandstoneDb'
		with: [ spec
				className: 'ConfigurationOfSandstoneDb';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/gnaritas/SandstoneDb/main' ].
	spec
		project: 'NeoCSV'
		with: [ spec
				className: 'ConfigurationOfNeoCSV';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
]
