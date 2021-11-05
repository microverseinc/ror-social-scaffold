# Scaffold for social media app with Ruby on Rails

> This repository includes an application with API endpoint for posts and Comments, as well as adding a session start functionality. Its purpose is to train Microverse students in API creation.

## Built With

- Ruby v2.7.2
- Ruby on Rails v5.2.4

## Live Demo

[Live Demo Link](https://evening-beach-95970.herokuapp.com/users/sign_in)


## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7.2
Rails: 5.2.6
Postgres: >=9.5

### Setup

Instal gems with:

```
bundle install
```

Setup database with:

```
   rails db:setup
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
    rspec --format documentation
```

> Tests will be added by Microverse students. There are no tests for initial features in order to make sure that students write all tests from scratch.

## API Endpoints

Use the token from the authorization response headers to sign in.

### Sign up

#### Method: `POST`
#### Endpoint: `/users`
#### Header: `{ "Content-Type": "application/json", "Accept": "application/json" }`
#### Body: `{"user": {"name": "Yuvraj", "email": "Yuvraj@fakemail.com", "password": "abc123", "password_confirmation": "abc123"}}`

### Sign in

#### Method: `POST`
#### Endpoint: `/users/sign_in`
#### Header: `{ "Content-Type": "application/json", "Accept": "application/json" }`
#### Body: `{"user": {"email": "Yuvraj@fakemail.com", "password": "abc123"}}`

### Sign out

#### Method: `DELETE`
#### Endpoint: `/users/sing_out`
#### Header: `{ "Content-Type": "application/json", "Accept": "application/json", "Authorization": JWT token }`

### Add post

#### Method: `POST`
#### Endpoint: `/posts`
#### Header: `{ "Content-Type": "application/json", "Accept": "application/json", "Authorization": JWT token }`
#### Body: `{"content": "Hello!"}`

### View post

#### Method: `GET`
#### Endpoint: `/posts`
#### Header: `{ "Content-Type": "application/json", "Accept": "application/json", "Authorization": JWT token }`

### Add comment

#### Method: `POST`
#### Endpoint: `/posts/:post_id/comments`
#### Header: `{ "Content-Type": "application/json", "Accept": "application/json", "Authorization": JWT token }`
#### Body: `{"content": "Hi!"}`

### View comments

#### Method: `GET`
#### Endpoint: `/posts/:post_id/comments`
#### Header: `{ "Content-Type": "application/json", "Accept": "application/json", "Authorization": JWT token }`

## Authors

👤 **Author**
Arístides José Molina Pérez

- GitHub: [@aristides1000](https://github.com/aristides1000)
- Twitter: [@aristides_1000](https://twitter.com/@aristides_1000)
- LinkedIn: [aristides jose molina perez](https://www.linkedin.com/in/aristides-jose-molina-perez-09b0579a)

👤 **Author**
Yuvraj Manoo

- GitHub: [@YuvrajM108](https://github.com/YuvrajM108)
- Twitter: [@YuvrajM108](https://twitter.com/@YuvrajM108)
- LinkedIn: [Yuvraj Manoo](https://www.linkedin.com/in/yuvraj-manoo/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Ariel Camus CEO Microverse: For letting us start this journey.
- Google: For letting us find crucial information in order to create this project.

## 📝 License

This project is [CC0-1.0](LICENSE) licensed.

