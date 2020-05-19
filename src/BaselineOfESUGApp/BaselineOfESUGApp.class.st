"
This baseline is used to load a ESUGApp from repository. 

Depends on:
- Seaside3
- MaterialDesignLite
- Parasol
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
				package: 'ESUGApp-Model' with: [ spec requires: #('DatabaseEsug') ];
				package: 'ESUGApp-Controller' with: [ spec requires: #('Seaside3' 'NeoCSV') ];
				package: 'ESUGApp-Core' with: [ spec requires: #('ESUGApp-View') ];		
				package: 'ESUGApp-Library' with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Model') ];
				package: 'ESUGApp-Form' with: [ spec requires: #('ESUGApp-View') ];
				package: 'ESUGApp-Component' with: [ spec requires: #('MaterialDesignLite' 'ESUGApp-Controller') ];
				package: 'ESUGApp-View' with: [ spec requires: #('ESUGApp-Library' 'ESUGApp-Component' 'PSTableSeaside') ];
				package: 'ESUGApp-Tests' with: [ spec requires: #('Parasol' 'ESUGApp-Core') ];
				package: 'ESUGApp-Extensions' with: [ spec requires: #('ESUGApp-Core') ].
			spec 
				group: 'Core' with: #('ESUGApp-PostMark-Core' 'ESUGApp-Form' 'ESUGApp-Extensions' 'ESUGApp-Core');
				group: 'Tests' with: #('ESUGApp-PostMark-Core' 'ESUGApp-Form' 'ESUGApp-Tests' 'ESUGApp-Extensions' 'ESUGApp-Core') ]
]

{ #category : #baselines }
BaselineOfESUGApp >> setUpDependencies: spec [
	spec
		baseline: 'PSTableSeaside'
		with: [ spec repository: 'github://daniapq/PSTableSeaside:master/src' ].
	spec
		baseline: 'DatabaseEsug'
		with: [ spec repository: 'github://daniapq/DatabaseEsug:master/src' ].
	spec	
		baseline: 'Seaside3'	
		with: [ spec	
				repository: 'github://SeasideSt/Seaside:v3.4.x/repository' ].
	spec
		baseline: 'Parasol'
		with: [ spec
				loads: 'tests';
				repository: 'github://daniapq/Parasol:master/repository' ].
	spec
		baseline: 'MaterialDesignLite'
		with: [ spec repository: 'github://daniapq/MaterialDesignLite:master/src' ].
	spec 
		baseline: 'NeoJSON' 
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
	spec 
		baseline: 'NeoCSV' 
		with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
]
