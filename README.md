# Scaffold for social media app with Ruby on Rails

> This repo includes intial code for social media app with basic styling. Its purpose is to be a starting point for Microverse students.

### Friendship

User can:

- See all users list.
  ![image](https://user-images.githubusercontent.com/60273425/117517945-6bcaad80-af63-11eb-8481-b57762dc1df1.png)
- See selected user page with their user name and all posts written by them (the most recent posts on the top).
  ![image](https://user-images.githubusercontent.com/60273425/117517957-843ac800-af63-11eb-9a7a-785961cd512d.png)
- Send a friendship invitation.
  ![image](https://user-images.githubusercontent.com/60273425/117518018-d2e86200-af63-11eb-9ce5-4727a4f47dde.png)
- “Invite to friendship” next to the name of user who is not my friend yet - on both users’ list and single user page.
  ![image](https://user-images.githubusercontent.com/60273425/117518044-e3004180-af63-11eb-8739-a82169ffa45d.png)

- See pending friendship invitations sent to me from other users.
  -- Pending invitation sent:
  ![image](https://user-images.githubusercontent.com/60273425/117518080-09be7800-af64-11eb-8287-a3a3e2ae74ae.png)
- Accept or reject friendships invitation.
  ![image](https://user-images.githubusercontent.com/60273425/117518122-396d8000-af64-11eb-9fd7-bd8011311c67.png)
- Create new posts (text only).
  ![image](https://user-images.githubusercontent.com/60273425/117518156-543ff480-af64-11eb-8568-e50de09acebf.png)

- Like/dislike posts (but I can like single post only once).
  ![image](https://user-images.githubusercontent.com/60273425/117518181-69b51e80-af64-11eb-9ed4-bf5787c2ee84.png)

- Add comments to posts.
  ![image](https://user-images.githubusercontent.com/60273425/117518203-789bd100-af64-11eb-8940-1de06ed7aa79.png)

- See “Timeline” page with posts (with number of likes and comments) written by me and all my friends (the most recent posts on the top).
  ![image](https://user-images.githubusercontent.com/60273425/117518256-aa149c80-af64-11eb-83e2-164372e2ca48.png)

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

```
    rpsec --format documentation
```

> Tests will be added by Microverse students. There are no tests for initial features in order to make sure that students write all tests from scratch.

### Deployment

TBA

## Authors

TBA

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

TBA

## 📝 License

TBA
