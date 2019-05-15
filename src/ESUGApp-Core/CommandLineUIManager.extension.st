Extension { #name : #CommandLineUIManager }

{ #category : #'*ESUGApp-Core' }
CommandLineUIManager >> fileDoesNotExistErrorNotificationDefaultAction: aFileDoesNotExistException [
	"log the syntax notificaiton and print a nicely formatted and colored syntax error on stderr"
	Smalltalk logDuring: [ :logger |
		logger print: aFileDoesNotExistException messageText; cr.
		aFileDoesNotExistException signalerContext errorReportOn: logger ].
		"in noninteractive mode simply quit"
	^ self exitFailure
]
