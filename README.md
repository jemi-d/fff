# fff

fff - Flutter project name
My own learning things about flutter are in this project.

Description - The project contain basic UI elements, API calls(GET,POST), local DB storage, cloud firestore using firebase, 
basic chat screen, time counter using state management, user authentication management in login and getting user profile using access token.


Features:
User authentication - Access token
State Management - provider(In Api calls, needed areas)
Local DB - Drift
Cloud Firestore - to store the chat list
Mixin - to access multiple inheritance
Stream - Single subscription stream
Animation class 
UI - Bottom sheet, image picker

Module demoAPI (repo_list_module): (For get repo list i use my own github name - jemi-d)
If network is there call repository list from API and handle the offline caching, display local list and perform add, edit, delete operations.

Module demoAPI (users_list_module): (credential username: emilys, password: emilyspass)
Api call and get the user list using GET method, here i using mixin for API call and handle the loading data.

Module demoAPI (postApiTokenAuth):
Login user and get the access token using POST method, handle the access token expire and use the refresh token api call to get the new token 
for the user security purpose. 

Module chat_firestore:
initialize the firebase in main, and using cloud firestore i store the chatting message.

Module local:
it have the local DB drift, and generated database.g file.

Module basic_concepts:
Bottom sheet UI is mostly used for mobile, handle the platform checking and stream data process. Timer count with start, pause, reset, resume 
operations.





