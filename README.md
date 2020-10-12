# Stay In Touch

This is a ruby on rails social media application. Registered users of this application can send friend requests amongst themselves as well as accept and reject these requests. The application also has like and comment features incorporated in the posts feature where registered users can write, like and comment on posts.

## Screenshots

Below are screenshots of the application index page and the data architecture illustration.

### Index Page Screenshot

![Screenshot](/app/assets/images/screenshot.png)

### Entity Relationship Diagram(ERD)

![ERD](/app/assets/images/social-site-ERD.png)

## Built With

- Ruby v2.7.0
- Ruby on Rails v5.2.4

## Live Demo

The social network site can be accessed on the [live demo link](https://quiet-hollows-17667.herokuapp.com/users/sign_in)


## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.6.3
Rails: 5.2.3
Postgres: >=9.5

### Setup

Instal gems with:

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
To run the rspec tests written in this repository, run either of the commands below in the terminal.

```
    rpsec --format documentation
``` 

or

```
    bundle exec rspec --format documentation
```

### Deployment

The social network site built was deployed to heroku by following the guide [here](https://devcenter.heroku.com/articles/git)

## ✒️ Authors

**Mworekwa Ezekiel**

- Github: [@vanheaven-ui](https://github.com/vanheaven-ui)
- Twitter: [@MworekwaE](https://twitter.com/MworekwaE)
- Linkedin: [@linkedin](https://www.linkedin.com/in/vanheaven/)
- Email: [ezekiel](mailto:vanheaven6@gmail.com)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- [Microverse](https://microverse.pathwright.com/library/fast-track-curriculum/69047/path/step/49736080/) <br />
- [Scaffold repository by Microverse](https://github.com/microverseinc/ror-social-scaffold)


