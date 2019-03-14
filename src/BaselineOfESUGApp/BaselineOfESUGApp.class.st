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
				package: 'ESUGApp-Core' with: [ spec requires: #('ESUGApp-View' 'Seaside3' 'ESUGApp-Model') ];		
				package: 'ESUGApp-Library'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Model') ];
				package: 'ESUGApp-Form'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Library' 'ESUGApp-Component' 'ESUGApp-View') ];
				package: 'ESUGApp-Component'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Controller') ];
				package: 'ESUGApp-View'
					with: [ spec
						requires:
							#('Seaside3' 'MaterialDesignLite' 'ESUGApp-Library' 'ESUGApp-Controller' 'ESUGApp-Component') ];
				package: 'ESUGApp-Test'
					with: [ spec
						requires: #('Parasol' 'SandstoneDb' 'ESUGApp-View' 'ESUGApp-Core') ];
				package: 'ESUGApp-Extensions' with: [ spec
						requires:
							#('Seaside3' 'MaterialDesignLite' 'ESUGApp-Core' 'SandstoneDb')]]
]

{ #category : #baselines }
BaselineOfESUGApp >> setUpDependencies: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec
				repository: 'github://SeasideSt/Seaside:master/repository' ].
	spec
		baseline: 'Parasol'
		with: [ spec
				loads: 'tests';
				repository: 'github://SeasideSt/Parasol/repository' ].
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
