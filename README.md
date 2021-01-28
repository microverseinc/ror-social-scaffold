# SOCIAL MEDIA APP PROJECT

This repo includes initial code for social media app with basic styling. It's purpose is to be a starting point for Microverse students.
 
<br />
<p align="center">
  <a href="https://github.com/guirecordon/ror-social-scaffold">
    <img src="app\assets\images\microverse-logo.webp" alt="Logo" width="100" height="100">
  </a>

  <h3 align="center">Linter</h3>

  <p align="center">
    This is a collaborative project as part of the Microverse Ruby on Rails curriculum
    <br />
    <a href="https://github.com/guirecordon/ror-social-scaffold"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/guirecordon/ror-social-scaffold/issues">Report Bug</a>
    ·
    <a href="https://github.com/guirecordon/ror-social-scaffold/issues">Request Feature</a>
  </p>
</p>


* Ruby version 2.7.1

## Table of Contents

* [About](#about)
* [Usage](#usage)
* [Development](#development)
  * [Built With](#built-with)
* [Author](#author)
* [Show Support](#show-your-support)
* [Acknowledgements](#acknowledgements)


## About

This project creates an application that allows new users to sign up,an existing user can sign in, see all users, send a friend request, cancel request approve or reject a request, create post(s), comment on his/her post(s) as well as others, like his/her post(s) plus for others.We used many-to-many relationships.

, 
We started the project by setting up the following. 

* Modeled the data for the application, including the necessary tables.
* Built and migrated the Friendship model with associations and all requested features for friendships.
* Made a logged-in user to be able to do the following:
    * see all users lists
    * select user page with their user name and all posts written by them (the most recent posts on the top
    * able to send a friendship invitation.
    * able to see a button “Invite to friendship” next to the name of user who is not my friend yet - on both users’ list and single user page.
    * able to see pending friendship invitations sent to me from other users.
    * able to accept or reject friendships invitation.
    * able to create new posts (text only).
    * able to like/dislike posts (but I can like single post only once).
    * able to add comments to posts.
    * able to see “Timeline” page with posts (with number of likes and comments) written by me and all my friends (the most recent posts on the top).
        Timeline page should be the root page of the app.

## Usage

### Installing Ruby

You shoudld have Ruby installed in your computer to run this project.

If you're not sure wether or not you have Ruby, type the following in your command line:<br>
`ruby -v`
That should return the version of Ruby that's running on your computer. 

If you need to install Ruby, follow the instructions in this [webpage](https://www.ruby-lang.org/en/documentation/installation/).

### Installing Rails

You should also have Rails installed in your computer.

Follow the instructions in this tutorial to install Rails [webpage](https://www.theodinproject.com/courses/ruby-on-rails/lessons/your-first-rails-application-ruby-on-rails)

### Clone the repo

Go ahead and clone the repo.

## Development

After cloning the repo, you should fire up a server. Open a command line terminal and paste the following command:

- Clone the repository : `git clone <https://github.com/guirecordon/members-only>`
- Drop the database : `rails db:drop`
- Create the database: `rails db:create`
- Run migration: rails `db:migrate`
- Then serve, `rails serve` or `rails s`

After that, open your browser and type the following in your address bar: 

`http://localhost:3000`

That will take you to the main form where you can create a new user. Fill out all the fields. If they pass validation, the form should be emptied out. Otherwise, you should get an error message on top of your form.


### Built With
* Ruby
* Rails
* Git
* Rubocop
* Bootstrap

## Authors

👤 **Jocylin Magero** 

- Twitter: [@magero_jocyline](https://twitter.com/magero_jocyline) 
- Github: [Jmagero](https://github.com/Jmagero)
- LinkedIn: [jocyline-magero](https://www.linkedin.com/in/jocyline-magero-9592b0145/)

👤 **Guilherme Recordon** 

- Twitter: [@guirecordon](https://twitter.com/RecordonG) 
- Github: [guirecordon](https://github.com/guirecordon)
- LinkedIn: [GuilhermeRecordon](www.linkedin.com/in/gui-recordon-marketingmba/)

## Show your support

Give a ⭐️ if you like this project!
