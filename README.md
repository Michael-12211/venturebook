Overview of application

Our application, Venturebook, is designed to be a convenient scrapbooking app for those who travel. It will allow people to make notes marking notable points on their trips. The notes will allow the user to record a title for it, as well as a more elaborate description and the opportunity to upload a picture of it through their camera. Each post will additionally record not only when, but also where it was made. Users can view their posts in a chronological recount organized into trips for a simple view. The unique side of the app is that each post to the scrapbook can be seen on the map where it was made. This can provide a nice visual representation of the journey and another degree to which it can be remembered.
The app mostly serves a recreational role, as well as being somewhat niche, but provides a nice functionality to those who’d want it. The target audience is pervasive travellers who would like to use the app to keep track of their journeys and make records for a scrapbook conveniently from their phone as they have their experiences, rather than having to retroactively fit everything together in a book from their hotel room.
Above the personal side of the application, we aim to include a social aspect by allowing posts to be uploaded to a remote database. This side will use mostly the same data types as the core data, but be visible to any user of the app. Any post made is initially private, but can be uploaded by clicking a button on the details view page, and removed the same way. This can serve as a way to search out attractions by seeing what people talk about while not branching beyond the scope of the application. These posts can be viewed on a map to try to find attractions nearby.
Originally, we wanted this side of the app to have an “influencer’ appeal, where you could tell a story specifically about you, but this was cut for several reasons. Firstly, it would require an account creation to use, which was intrusive and provided a roadblock to all users in exchange for services only a small portion would benefit from. It also posed the risk of turning the application into a social-media type deal, which detracted from the casual, personal nature of scrapbooking we were trying to capture. In further service of capturing that intended feeling, we added music to our application that would play music akin to watching a slideshow, which we believe improves the overall product.
The app includes, in total, 3 main use cases; make notes, view your personal scrapbook, and view online posts, each of which will be accessible directly through the home menu, so they will not interfere with any other use case.
The final major topic that needs to be addressed is that when developing the app, we planned to use an app clip to show the map of public notes. This unfortunately could not be done. We learned too late that firebase is incompatible with app clips, and thus cannot be displayed. As every feature requires either firebase or coreDB, which itself can’t work with an app clip, this functionality had to be cut. We are aware that this means we don’t have the required advanced functionality, but there is nothing we can do.
The other major bug that was not able to be resolved in time also pertains to firebase. Firebase stores images as blob files, and can only accept images as file paths. This means that the default image, which is a file, can be stored, but any photos from the user’s camera cannot be uploaded onto firebase.




Responsibilities and Accomplishments

General responsibilities
Roles in the group beyond programming elements

Anh Phan: Data layer
	Firebase setup and integration
	Online database design
Michael Kempe: Business layer
	Organization of views
	Local data structures
Kevin Tran: Presentation layer
	Front end design
	Palette, branding, consistent appearance


Specific accomplishments
Views / class tasks completed

Anh Phan
	Firebase integration
		Registering app for firebase
		Configuring credentials
		Utility functions (read / write)
		Maintain remote database, alter when necessary
		Firebase helper class
	Note details
		Accept note object retrieved from any location
		Display all information in one view
		Allow uploading to firebase
	Trips view
		Provide ability to add new trips
		Displays a list of all trips
		Allows deleting of trips
		Links to note list, passing the trip to sort by
Kevil Tran
	Overall app branding and style
		Background colour
		Music
		Icons
	Home View
	Maps
		Display a map, centred on the user
		Include pins for each note retrieved from coreDB or firebase (depending on the map)
Michael Kempe
	Core data structure
		Create local data types used by general functions
		Manage the core database, alter when necessary
		CoreDB helper classes
		Reverse-lookup of coreDB index by note ID
	Location manager
		Create location management classes
		Ensure location is used consistently and without error
	Add / Edit notes
		Input fields in the forms
		Input validation
		Saving to core data
		Set up camera services
	My Notes
		Display a list of all the user’s notes
		Allow the ability to filter to only notes from a specific trip when navigated to from the trip view
		Provide access to the details page
		Allow deleting of posts from core data (and firebase if they are uploaded)
	App Clip
		Create app clip target
		Link necessary pages to the clip target
		Create necessary exclusion statements to ensure the app clip is as small as possible.
	Assorted
		Filter buttons on details view by upload and owner status
		Un-post from firebase option
		Set up custom map annotations that include title and link to details
		Map load with geocoding methods


