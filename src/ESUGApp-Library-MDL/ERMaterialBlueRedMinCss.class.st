Class {
	#name : #ERMaterialBlueRedMinCss,
	#superclass : #WAFileLibrary,
	#category : #'ESUGApp-Library-MDL'
}

{ #category : #updating }
ERMaterialBlueRedMinCss >> updateRoot: anHtmlRoot [
	
	anHtmlRoot stylesheet url: (WAUrl absolute: 'https://code.getmdl.io/1.3.0/material.blue-red.min.css').
]
