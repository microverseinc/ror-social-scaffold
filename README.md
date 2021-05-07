![](https://img.shields.io/badge/Microverse-blueviolet)

# Scaffold for social media app with Ruby on Rails

> This repo includes intial code for social media app with basic styling. Its purpose is to be a starting point for Microverse students.

># [Collaborative project] - [Stay in Touch]
>Here is a description of business requirements for your app:


We need to build a social media app called “Stay in touch”.

As a guest user:

I want to be able to create account/log in.
I can see only “Sign in” and “Sign out” page.

As a logged-in user:


I want to be able to see all users list.
I want to be able to see selected user page with their user name and all posts written by them (the most recent posts on the top).
I want to be able to send a friendship invitation.
I want to see a button “Invite to friendship” next to the name of user who is not my friend yet - on both users’ list and single user page.
I want to be able to see pending friendship invitations sent to me from other users.
I want to be able to accept or reject friendships invitation.
I want to be able to create new posts (text only).
I want to be able to like/dislike posts (but I can like single post only once).
I want to be able to add comments to posts.
I want to be able to see “Timeline” page with posts (with number of likes and comments) written by me and all my friends (the most recent posts on the top).
Timeline page should be the root page of the app. A project completed as part of  the Microverse Ruby on Rails Pathwright [Find project specifications here](https://microverse.pathwright.com/library/fast-track-curriculum/69047/path/step/49736080/).

## Built With

- Ruby v2.7.0
- Ruby on Rails v5.2.4

## Live Demo

TBA


## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.6.3
Rails: 5.2.3
Postgres: >=9.5

### Setup

Install gems with:

```
bundle install
```

Setup database with:

```
   rails db:create
   rails db:migrate
```

### Github Actions

To make sure the linters' checks using Github Actions work properly, you should follow the next steps:

1. On your recently forked repo, enable the GitHub Actions in the Actions tab.
2. Create the `feature/branch` and push.
3. Start working on your milestone as usual.
4. Open a PR from the `feature/branch` when your work is done.


### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

```
    rpsec --format documentation
```

> Tests will be added by Microverse students. There are no tests for initial features in order to make sure that students write all tests from scratch.

## Project Structure

    ├── README.md
    ├── bundle
    │   └── main.rb
    └── .github\workflows
        └── linters.yml
    └── app
        └── assets
        └── channels
        └── controllers
        └── helpers
        └── jobs
        └── mailers
        └── models
        └── views    
    └── bin
    └── config
    └── db
    └──log
    └── bin
    └── public
    └── storage
    └──test

## Deployment
1) Git clone this repo (https://github.com/errea/ror-social-scaffold.git)  and cd the to the `ror-social-scaffold` directory.
2) Run `rails server` in command line to open the application server in your browser via http://localhost:3000 or something similar
3) Run `heroku start`.
4) heroku run
5) heroku run rails db:migrate
6) git push heroku main
7) heroku run console

## Authors

👤 **Eri**

- Github: [@errea](https://github.com/errea)
- Twitter: [@Erreakay](https://github.com/errea)
- Linkedin: [Eri Okereafor](https://www.linkedin.com/in/eri-ngozi-okereafor/)
  
 👤 **Julius**

- Github: [@Mihndim2020](https://github.com/Mihndim2020)
- Twitter: [@mihndim](https://github.com/mih-julius) 
- Linkedin: [Mih Julius](https://www.linkedin.com/mih-julius)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page]

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse

## 📝 License

This project is [MIT](./MIT.md) licensed.

