# Dev.org (iOS)

The Project Plan document should contain the following information:

- **Your team's name:**  
Dev.org  

- **Your team's members names:**  
	- iOS: 
		- Jay Balderas
		- Robert Hatfield
	- JavaScript
		- Kaylee Alvarado
		- Chris Closser
		- Carlo Santos
		- James Thomas

- **Your project's overview and concept:**  
Build on / extend [DeVolunteer](https://github.com/Devolunteer/DEVolunteer), to connect volunteer software developers with non-profit organizations requesting assistance.

- **A diagram or overview of your project's model layer**  
[Sample JSON](sample.json)

- User
	- Username
	- City
	- State
	- Phone
	- Email
	- Website
	- Photo
	- isDev (Boolean, use to determine class when initializing)

- User subclasses	
	- Developer
		- Languages
		- Services / skills
		- isAvailable (Boolean)
		- Projects
	- Organization
		- Organization name
		- Projects

- Project
	- Organization ("owner" of project objects)
	- Developers (array)
	- Services / skills requested
	- Rating
	- Description

- **Sketches/wireframes of your project's pages**  
[Sketches](sketches.pdf)

- **Any Frameworks and Libraries you foresee needing**  
	- Accounts / Social (to share projects)
	- Core Location / MapKit (to find projects or developers in your area)
	- MessageUI (to compose email in app)
	- SafariServices (to view a web page in app)

- **A detailed overview of the features needed to meet MVP(Minimum Viable Product)**  
- Developers can search for projects matching their skills and offer their services.
- Organizations can search for developers and request assistance.
- Organizations can place project requests in the "pool" for developers to find.

- **A detailed overview of the stretch goals you want to implement given a completed MVP.**  
	- Comments on projects
	- In app communication (user to user)
	- Location based search / filtering (using CoreLocation)
	- Social sharing

- **Which task management system will you use for tracking feature implementation?**  
GitHub Projects
