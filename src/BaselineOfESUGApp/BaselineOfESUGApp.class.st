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
				package: 'ESUGApp-Models' with: [ spec requires: #('SandstoneDb') ];
				package: 'ESUGApp-Library-MDL'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Models') ];
				package: 'ESUGApp-Form'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Library-MDL') ];
				package: 'ESUGApp-Components'
					with: [ spec requires: #('Seaside3' 'MaterialDesignLite' 'ESUGApp-Controllers') ];
				package: 'ESUGApp-Controllers' with: [ spec requires: #('Seaside3' 'NeoCSV') ];
				package: 'ESUGApp-DB' with: [ spec requires: #('SandstoneDb' 'ESUGApp-Models') ];
				package: 'ESUGApp-Views'
					with: [ spec
						requires:
							#('Seaside3' 'MaterialDesignLite' 'ESUGApp-Library-MDL' 'ESUGApp-Controllers' 'ESUGApp-Components') ];
				package: 'ESUGApp-SetUp' with: [ spec requires: #('ESUGApp-Views' 'Seaside3') ];
				package: 'ESUGApp-Test'
					with: [ spec
						requires: #('SandstoneDb' 'ESUGApp-Views' 'ESUGApp-DB' 'ESUGApp-Models' 'ESUGApp-SetUp') ] ]
]

{ #category : #baselines }
BaselineOfESUGApp >> setUpDependencies: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec
				loads: #('Core' 'JQuery' 'Zinc');
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
