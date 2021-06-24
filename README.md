# Scaffold for social media app with Ruby on Rails

> This repo includes intial code for social media app with basic styling. Its purpose is to be a starting point for Microverse students. Add frienship model.

![ssm](https://user-images.githubusercontent.com/42869046/123082742-0a35a400-d428-11eb-82b4-6390ee90764f.JPG)

## Built With

- Ruby v2.7.3
- Ruby on Rails v6.1.3.2

## Live Demo

[Live Demo Link](https://stay-in-touch-vikita.herokuapp.com/)

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7.3
Rails: 6.1.3.2
Postgres: >=9.5

## Getting Started

- Ensure you have rails installed by running 'rails -v'. Otherwise run 'gem install rails'
- Click on the `Code` green button
- By the right end of the read-only input containing the repository link click the clipboard icon to copy the link
- In your local PC, open your terminal in the folder you would like to clone the repository into
- Clone the repository with the command: `git clone (copied link)`; like so: `git clone https://github.com/vikitaotiz/ror-social-scaffold.git`
- After the clone, type in the command `cd ror-social-scaffold` to access the app directory on the terminal
- Then run 'bundle install' to install all the required dependencies
- Then run 'npm install' to avoid this error 'Webpacker::Manifest::MissingEntryError in posts#index'
- Run 'rails db:create db:migrate'
- Run 'rails server' to spin up a development server
- Once the server is up, open this link 'http://127.0.0.1:3000' on your browser

### Github Actions

To make sure the linters' checks using Github Actions work properly, you should follow the next steps:

1. On your recently forked repo, enable the GitHub Actions in the Actions tab.
2. Create the `feature/branch` and push.
3. Start working on your milestone as usual.
4. Open a PR from the `feature/branch` when your work is done.

### Run tests

- Navigate into the app directory, `cd ror-social-scaffold`
- Then run `rails db:migrate db:test:prepare`
- Then run `rspec --format doc`. This will display detailed information about models and test results.

## Authors

:bust_in_silhouette: **Victor Otieno**

- GitHub: [@githubhandle](https://github.com/vikitaotiz)
- Twitter: [@twitterhandle](https://twitter.com/victoro29641869)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/victor-otieno-oluoch/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse Team
