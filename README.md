# Social media app

> In this project, users can sign up and create posts. Moreover it inherits the core functionality of social media sites
> such as facebook.com. Users can send request to one another and view the posts written by the user or from the user's
> friend list.

## Features

- Allow users to send a friend request to other users
- Multiple request states, such as,
  - Invite to friendship
  - Accept friendship
  - Reject friendship
  - Cancel friend request sent
  - Remove friend from the list
- Show posts written by the user and by the user's friends
- List all mutual friends of a user
- Followed TDD
- End to end testing

## Concept of mutual friendship

A mutual friend is an individual who has established a friendship with two
people. When those two people meet, they learn that they share the same friend;
that friend they have in common is their mutual friend. If the two people become
friends, a circle of friendship develops between the mutual friend and the other
individuals - from [oel](https://oureverydaylife.com/mutual-friend-mean-10031289.html#:~:text=A%20mutual%20friend%20is%20an,common%20is%20their%20mutual%20friend.&text=Mutual%20friendships%20are%20commonplace%20in,other%20by%20a%20mutual%20friend.)

## Built With

- Ruby v2.7.2
- Ruby on Rails v5.2.4

## Live Demo

TBA

## Getting Started

- Clone the repo `https://github.com/abeidahmed/ror-social-scaffold.git`
- `cd` into the project
- Run `git pull origin friendship-v1`
- Run `bundle install`
- Setup your `db` in the `database.yml` and run `rails db:setup`
- Run `rails s` and visit `localhost:3000`

### Prerequisites

Ruby: 2.6.3
Rails: 5.2.3
Postgres: >=9.5

### Github Actions

To make sure the linters' checks using Github Actions work properly, you should follow the next steps:

1. On your recently forked repo, enable the GitHub Actions in the Actions tab.
2. Create the `feature/branch` and push.
3. Start working on your milestone as usual.
4. Open a PR from the `feature/branch` when your work is done.

### Run tests

- Run `bundle exec rspec` to run all the tests, or
- Run `bundle exec guard` to start the guard server. The tests run when the test files are saved.

### Deployment

TBA

## Authors

### Abeid Ahmed

- GitHub: [@abeidahmed](https://github.com/abeidahmed)
- Twitter: [@iamhawaabi](https://twitter.com/iamhawaabi)
- LinkedIn: [Abeid Ahmed](https://www.linkedin.com/in/abeidahmed/)

## 🤝 Contributing

- Fork the project
- Create your feature branch `git checkout -b awesome-feature`
- Commit your changes `git commit -m 'Awesome feature'`
- Push it `git push -u origin awesome-feature`
- Open a pull request using this branch

## Show your support

Give a ⭐️ if you like this project!
