# Scaffold for social media app with Ruby on Rails

> This repo includes intial code for social media app with basic styling. Its purpose is to be a starting point for Microverse students. In addition, I designed the Entity Relationship Diagram (ERD) for the database tables and the associations between them; Using the ERD, I modelled a many-to-many relationship between the user and frienship model. I also added the friendship functionality to the app, which enabled logged in users to send, accept or reject friendship invitation from other users. The app was also developed with testing in view using Rspec with shoulda-matchers and Capybara. Finally, a version of the app was deployed to heroku.

## Built With

- Ruby v2.7.0
- Ruby on Rails v5.2.4
- Rspec

## Live Demo

[Stay-In-Touch](https://stark-waters-40080.herokuapp.com/posts)


## Getting Started

To get a local copy up and running follow these simple steps.

- To get a local copy of this project, run
`git clone https://github.com/francisuloko/stay-in-touch.git`

- Change into the project directory, run
`cd stay-in-touch`

### Prerequisites

Ruby: 2.6.3
Rails: 5.2.3
Postgres: >=9.5

### Setup
Install webpacker with:

```
rails webpacker:instal
```

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

### API endpoints

The app allows a number of API calls using curl or your favorite API client, such as postman or VS Code's Thunder ClientYou must be logged in first to access protected content

***Endpoints:***

#### /api/login
- Action: Authenticate user.
- Method: POST
- Headers:
  - Accept: application/json
  - Content-Type: application/json
- Body:
  ```json
  {
    "api_user": {
      "email":"name@email.com",
      "password":"the password"
    }
  }
  ```
- Response:
    - status: 200 OK
    - body: jwt secret (Copy this to authenticate protected content access)

#### /api/posts.json
- Action: Get posts.
- Method: GET
- Headers:
  - Accept: application/json
  - Content-Type: application/json
  - Authorization: Bearer **\<JWT TOKEN\>**
- Response:
  - status: 200 OK
  - body:
    ```json
      [
        {
          "id": 15,
          "user_id": 50,
          "content": "Example post 1",
          "created_at": "2021-10-07T16:45:18.580Z",
          "updated_at": "2021-10-07T16:45:18.580Z"
        },
        {
          "id": 14,
          "user_id": 51,
          "content": "Example post 2",
          "created_at": "2021-10-07T16:44:25.442Z",
          "updated_at": "2021-10-07T16:44:25.442Z"
        }
      ]

    ```

#### /posts/:post_id/comments.json
- Action: Get post comments.
- Method: GET
- Headers:
  - Accept: application/json
  - Content-Type: application/json
  - Authorization: Bearer **\<JWT TOKEN\>**
- Response:
  - status: 200 OK
  - body:
    ```json
      [
        {
          "id": 15,
          "user_id": 51,
          "post_id": 15,
          "content": "Example post comment",
          "created_at": "2021-10-07T16:46:52.875Z",
          "updated_at": "2021-10-07T16:46:52.875Z"
        }
      ]
    ```

#### /posts/:post_id/comments.json
- Action: Add comment.
- Method: POST
- Headers:
  - Accept: application/json
  - Content-Type: application/json
  - Authorization: Bearer **\<JWT TOKEN\>**
- Body:
  ```json
    {
      "comment": {
        "content":"Your comment."
      }
    }
  ```
- Response:
  - status: 201 Created
  - body: `Message created successfully`

### Run tests

```
    rpsec --format documentation
```


## Authors

👤 **Francis Uloko**

- [Github](https://github.com/francisuloko)
- [Twitter](https://twitter.com/francisuloko)
- [LinkedIn](https://linkedin.com/in/francisuloko)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/francisuloko/stay-in-touch/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- The Microverse ror-social-scaffold Team

## 📝 License

This project is [MIT](https://mit-license.org) licensed.
