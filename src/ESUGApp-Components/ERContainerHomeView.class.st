Class {
	#name : #ERContainerHomeView,
	#superclass : #ERContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerHomeView >> renderContentPage: html [
	html html: '<h3>Welcome to the ESUG Registration System</h3>
                <hr>
                <h6><strong>Conference Home Page: </strong><a href="#"> http://exmple.exaomeosmdfsdkfm..xkmdkfm </a></h6>'.
 html paragraph: attendee userAccount firstName
]
