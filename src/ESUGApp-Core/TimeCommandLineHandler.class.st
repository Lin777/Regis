Class {
	#name : #TimeCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
TimeCommandLineHandler class >> commandName [
	^ 'time'
]

{ #category : #activation }
TimeCommandLineHandler >> activate [
 self activateHelp.
 
 FileStream stdout 
  nextPutAll: '[time] ';
  nextPutAll: Time now asString
]
