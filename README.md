# venturebook
Group project for mobile computing

Introduction to app

Our application, venturebook, is designed to be a convenient scrapbooking app for those who travel. It will allow people to make notes marking notable points on their trips. The posts will allow the user to record a title for it, as well as a more elaborate description and the opportunity to upload a picture of it through their camera. Each post will additionally record not only when, but also where it was made. Users can view their posts in a chronological recount organized into trips for a simple view. The unique side of the app is that each post to the scrapbook can be seen on the map where it was made. This can provide a nice visual representation of the journey and another degree to which it can be remembered.
The app mostly serves a recreational role, as well as being somewhat niche, but provides a nice functionality to those who’d want it. The target audience is pervasive travellers who would like to use the app to keep track of their journeys and make records for a scrapbook conveniently from their phone, rather than keeping a physical scrapbook with them at all times.
Above the personal side of the application, we aim to include a social aspect by allowing posts to be uploaded to a remote database. This side will use mostly the same data types as the core data, but be visible to any user of the app. Any post made is initially private, but can be uploaded by clicking a button on the details view page, and removed the same way. This not only gives an ‘influencer’ appeal, but also can serve as a way to search out attractions by seeing what people talk about. These posts can be viewed on a map to try to find attractions nearby. This gives the app a multi-purpose use for travellers while sticking to a consistent set of functionalities.
The app will, in total, have 3 main use cases; make posts, view your personal scrapbook, and view online posts, each of which will be accessible directly through the home menu, so they will not interfere with any other use case.




Division of roles
*The division of roles, both general and granular, are to ensure every task is covered and everyone can work individually to great success, building modularly and avoiding bottlenecks. These roles are not definitive, and group members are free to offer assistance in different layers or cooperate when general and granular responsibilities overlap.

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


Granular responsibilities
View / class task allocation

Firebase integration: Anh Phan
	Register app
	Config credentials
	Utility functions (read, write)
	Maintain remote database
	Firebase helper class

Core data structure: Michael Kempe
            Create data types
	Manage core data database
	Core data helper class

Home view: Kevin Tran
	Design
	Navigation view
	Placing the links to other views

Add / edit post: Michael Kempe
	Placing the input boxes and buttons
	Validate inputs
	Save data to core data

My posts: Michael Kempe
	Provide a summary of the posts information
	Allow uploading and removing of the post from the remote database.

My scrapbook: Anh Phan
	Listing the posts
	Sorting
	Searching
	Deleting
	Link to edit page

Trips view: Anh Phan
	List all different trips present in the core data
	Selecting a trip will link to the my posts page, filtered to only include posts from that trip
	
Maps: Kevin Tran
	Show pins on the locations that have posts associated with
	Click on pin to go “My scrapbook” view with the posts of that location

