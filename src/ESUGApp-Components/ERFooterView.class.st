Class {
	#name : #ERFooterView,
	#superclass : #WAComponent,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERFooterView >> renderContentOn: html [ 	
	html html: 
	   '<footer id="footer" class = "mdl-mini-footer">
         <div class = "mdl-mini-footer__left-section mdl-mini-footer__link-list">
            Designed by <a href = "http://semantics.bo">  Semantics</a>
         </div>
      </footer>'
]
