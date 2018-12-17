"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestESUGAppComponents,
	#superclass : #PackageManifest,
	#category : #'ESUGApp-Components'
}

{ #category : #'code-critics' }
ManifestESUGAppComponents class >> ruleRBCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ERLoginComponent #loginUser #false)) #'2018-11-19T17:07:16.375792-04:00') )
]
