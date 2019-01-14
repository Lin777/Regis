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
				package: 'ESUGApp-Exception';
				package: 'ESUGApp-Model' with: [ spec requires: 'SandstoneDb' ];
				package: 'ESUGApp-Controller' with: [ spec requires: #('Seaside3' 'NeoCSV') ];
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
						requires: #('SandstoneDb' 'ESUGApp-View' 'ESUGApp-DB' 'ESUGApp-Model' 'ESUGApp-SetUp') ] ]
]

{ #category : #baselines }
BaselineOfESUGApp >> setUpDependencies: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec
"				loads: #('Core' 'JQuery' 'Zinc');"
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
				repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/Neo/main' ]
]
