Class {
	#name : #BaselineOfESUGApp,
	#superclass : #BaselineOf,
	#category : #BaselineOfESUGApp
}

{ #category : #baselines }
BaselineOfESUGApp >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec
				package: 'ESUGApp-Form'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];
				package: 'ESUGApp-Components'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];
				package: 'ESUGApp-Controllers' with: [ spec requires: #('Seaside3') ];
				package: 'ESUGApp-Library-MDL'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite') ];
				package: 'ESUGApp-Views'
					with: [ spec
						requires:
							#('Seaside3' 'MaterialDesignLite' 'ESUGApp-Library' 'ESUGApp-Controller' 'ESUGApp-Component') ];
				package: 'ESUGApp-Models' with: [ spec requires: #('SandstoneDb') ];
				package: 'ESUGApp-DB' with: [ spec requires: #('SandstoneDb' 'ESUGApp-Model') ];
				package: 'ESUGApp-Test'
					with: [ spec requires: #('SandstoneDb' 'ESUGApp-View' 'ESUGApp-DB' 'ESUGApp-Model') ] ]
]

{ #category : #baselines }
BaselineOfESUGApp >> setUpDependencies: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec
				loads: #('Core' 'JQuery' 'Zinc');
				repository: 'github://SeasideSt/Seaside:v3.2.5/repository' ].
	"spec
		baseline: 'Parasol'
		with: [ spec
				loads: 'tests';
				repository: 'github://SeasideSt/Parasol/repository' ]."
	spec
		baseline: 'MaterialDesignLite'
		with: [ spec
				repository: 'github://DuneSt/MaterialDesignLite:master/src' ].
	spec
		project: 'SandstoneDb'
		with: [ spec
				className: 'ConfigurationOfSandstoneDb';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/gnaritas/SandstoneDb/main' ]
	
]
