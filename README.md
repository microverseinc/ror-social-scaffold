# README

# Rails Social Media Website Project Overview

This project entails building a social media application with ruby on rails using all the process of MVC. This project comprises the application of model, controller, view, routes, associations, partials and styling knowledge in building a rails app. A user need to create an account to be able to log into the application and test all features.

## Features 
- User can sign up into the app.
- User can log in after sign up. 
- User can Add a friend.
- User can Accept or reject friend request.
- User can see list of pending friend request.
- Logged in Users can see all users that have signed up in the app.
- User can make a post.
- User can make a comment.
- Mutual friendship with two rows implemented.

## Live Demo

To see a preview of the actual project, check out the [Live Demo Link](https://gentle-earth-18966.herokuapp.com/users/sign_in)
## Project SetUp/Installation

Get a local copy of the file. Clone with HTTPS using the command below.

```
git clone https://github.com/Zubenna/ror-social-scaffold 
```
Access project folders 
```
cd ror-social-scaffold
```
Install all the dependencies
```
bundle install
```

Create the database with the following command
```
rails db:create
```
Migrate the database with the following command
```
rails db:migrate
```
Populate the database with the following command
```
rails db:seed
```
Run Application test while on the project root with the following command
## Please run tests separately as indicated below to avoid ambiguity
```
rspec spec/features/authentication_spec.rb => to test authentication features

rspec spec/features/comment_spec.rb => to test comment features

rspec spec/features/friendship_spec.rb => to test friendship features

rspec spec/features/like_spec.rb => to test like features

rspec spec/features/post_spec.rb => to test post features

rspec spec/models/friendship_spec.rb  => to test friendship associations and validations

rspec spec/models/user_spec.rb  => to test User validations
```

## Run the server
- While in the project root, start rails server with the command rails server.
- In your browser, type http://localhost:3000 to access the app.
- You can now sign up or Log in,to test all features.
- Example; Log in with email, b.email@example.com and password, secretpass.

## Built With
- Ruby, Ruby on Rails
- RSpec, Capybara 

## Authors
👤 **Umair Arshad**

- Github: [@umairarshadbutt](https://github.com/umairarshadbutt)
- Twitter: [@its_UmairArshad](https://twitter.com/its_UmairArshad)
- Linkedin: [umair-arshad-butt](https://www.linkedin.com/in/umair-arshad-butt/)

👤 **Nnamdi Emelu**
- Github: [@zubenna](https://github.com/zubenna)
- Twitter: [@zubenna](https://twitter.com/zubenna)
- Linkedin: [nnamdi-emelu](https://www.linkedin.com/in/nnamdi-emelu/)

##  Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Zubenna/ror-social-scaffold/issues)

## Show your support

Give a star if you like this project!

## Acknowledgments

- Project originally taken from The Odin Project
- Project inspired by Microverse Program
