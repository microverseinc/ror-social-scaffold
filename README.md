# Stay In Touch
In this project we built the MVP for a social media app called “Stay in touch”.

## Features

As a guest user:
<ul>
    <li>Guest is able to create account/log in.</li>
    <li>Guest can see only “Sign in” and “Sign out” page.</li>
</ul>

As a logged-in user:
<ul>
    <li>A user is able to see all users list.</li>
    <li>A user is able to see selected user page with their user name and all posts written by them (the most recent posts on the top).</li>
    <li>A user is able to send a friendship invitation.</li>
    <li>A user is able to see a button “Invite to friendship” next to the name of user who is not a friend yet - on both users’ list and single user page.</li>
    <li>A user is able to see pending friendship invitations sent from other users.</li>
    <li>A user is able to accept or reject friendships invitation.</li>
    <li>A user is able to create new posts (text only).</li>
    <li>A user is able to like/dislike posts (but can like single post only once).</li>
    <li>A user is able to add comments to posts.</li>
    <li>A user is able to see “Timeline” page with posts (with number of likes and comments) written by him and all his friends (the most recent posts on the top).</li>
</ul>

Timeline page should be the root page of the app.


## Endpoints covered in this project
  ## users & sessions
  - POST localhost:3000 /users/sign_up  - For Signing up a new client.
  - POST localhost:3000 /users/sign_in - For logging in a user.
  - GET localhost:3000 /users/id - For viewing a users profile.
  - POST localhost:3000 /users/sign_out - For signing out a user.

## Posts
  - GET localhost:3000 /posts  - For creating a new post, comments and likes.

## Friendships
  - GET localhost:3000 /friendships - For accepting friendship requests from other users.

## Installation
  - Make sure to have [PostgreSQL](https://www.postgresql.org/) installed and configured as the database.
  - Ensure the project dependencies are installed.
  - Clone the repo locally with the command `git clone git@github.com:dansantander/stay-in-touch.git`.
  - Navigate to the project folder.
  - run `bundle` or `bundle install`.

## Getting Started
  - Head over to your server on localhost:3000.
  - Create a new User using the Signup form and start a session by Signing in.
  - Create a new Post with a content.
  - Send a Friendship Request to other Users.
  - Accept friend request from other users inside the "Friend Requests" Tab.

## Built With

  - Ruby 2.6.5 <br>
  - Ruby on Rails 5.2 <br>
  - Devise gem
  - Git, Github and VScode <br>
  - PostgreSQL <br>

## Authors

👤 **Daniel Santander**

- Github: [@dansantander](https://github.com/dansantander)
- Linkedin: [Daniel Santander](https://www.linkedin.com/in/daniel-santander)
- Twitter: [@dansantandr](https://twitter.com/dansantandr)

👤 **Alfred Ezaka**

- Github: [@codecell](https://github.com/codecell)
- Twitter: [@the_codecell](https://twitter.com/the_codecell)
- Linkedin: [ezaka alfred](https://www.linkedin.com/in/alfrednoble/)

### Contributing

Contributions, issues and feature requests are welcome! [issues page](issues/).

### License

<strong>Creative Commons • June 2020</strong>