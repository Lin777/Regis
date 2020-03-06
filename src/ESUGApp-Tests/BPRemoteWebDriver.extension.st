Extension { #name : #BPRemoteWebDriver }

{ #category : #'*ESUGApp-Tests' }
BPRemoteWebDriver >> acceptAlert [
	"https://www.w3.org/TR/webdriver1/#dismiss-alert"

	^ self handleResponse: (
		self 
			httpPost: self baseSessionURL , 'alert/accept' 
			jsonData: Dictionary new)
]
