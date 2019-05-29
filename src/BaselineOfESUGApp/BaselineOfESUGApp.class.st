"
This baseline is used to load a ESUGApp from repository. 

Depends on:
- Seaside3
- MaterialDesignLite
- Parasol
- SandstoneDb
- NeoJSON
- NeoCSV

Load type: 
- atomic

This file does not load other dependencies because they have a conflicts with others, this dependencies are:
- Artefact
- MaterialDesignLite (with extension for Magritte)
- Magritte
"
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
			self setUpDependencies: spec.
			spec
				package: 'ESUGApp-PostMark-Core' with: [ spec requires: 'NeoJSON' ];
				package: 'ESUGApp-Model' with: [ spec requires: 'SandstoneDb' ];
				package: 'ESUGApp-Controller' with: [ spec requires: #('Seaside3' 'NeoCSV') ];
				package: 'ESUGApp-Core' with: [ spec requires: #('ESUGApp-View') ];		
				package: 'ESUGApp-Library' with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Model') ];
				package: 'ESUGApp-Form' with: [ spec requires: #('ESUGApp-View') ];
				package: 'ESUGApp-Component' with: [ spec requires: #('MaterialDesignLite' 'ESUGApp-Controller') ];
				package: 'ESUGApp-View' with: [ spec requires: #('ESUGApp-Library' 'ESUGApp-Component') ];
				package: 'ESUGApp-Test' with: [ spec requires: #('Parasol' 'ESUGApp-Core') ];
				package: 'ESUGApp-Extensions' with: [ spec requires: #('ESUGApp-Core')].
			spec 
				group: 'Core' with: #('ESUGApp-PostMark-Core' 'ESUGApp-Form' 'ESUGApp-Extensions' 'ESUGApp-Core');
				group: 'Tests' with: #('ESUGApp-PostMark-Core' 'ESUGApp-Form' 'ESUGApp-Test' 'ESUGApp-Extensions' 'ESUGApp-Core')]
]

{ #category : #baselines }
BaselineOfESUGApp >> setUpDependencies: spec [
	spec	
		baseline: 'Seaside3'	
		with: [ spec	
				repository: 'github://SeasideSt/Seaside:v3.3.x/repository' ].
	
	spec
		baseline: 'Parasol'
		with: [ spec
				loads: 'tests';
				repository: 'github://Lin777/Parasol:UpdateSeasideVersion/repository' ].
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
		project: 'NeoJSON'
		with: [ spec
				className: 'ConfigurationOfNeoJSON';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
	spec
		project: 'NeoCSV'
		with: [ spec
				className: 'ConfigurationOfNeoCSV';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ].
]
