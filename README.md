# Social Media Project
> In this project, we first designed an [ERD diagram](https://github.com/evansinho/ror-social-scaffold/pull/1) which visually displays the database schema and structure.
> We then added a friendship functionality using self-referencial relationships to the forked repositry.Database query improvements were made ontop of the friendship funtionality
> Friends can be added via a request. A request can be cancelled by user or rejected/confirmed by friend.
>  tests are run using rspec unit tests for the models, rspec controller tests and then capybara integration tests.
## Built With
- Ruby v2.7
- Ruby on Rails v6.0.3
- Gems used for testing: Capybara, Rspec-Rails, Shoulda-matchers and FactoryBot
## Live Demo
[Heroku App Link]()
## Getting Started
To get a local copy up and running follow these steps:
### Prerequisites
- Ruby: 2.7
- Rails: 6.0.3
- Postgres: >=9.5
- Git
### Usage
- Fork/Clone this project to your local machine
- Open folder in your local enviroment and run these lines of code to get started:
Install gems with:
```Ruby
    bundle install
```
Setup database with:
```Ruby
   rails db:create
   rails db:migrate
```
Start server with:
```Ruby
    rails server
```
Then open a web page and go to [port 3000 on your local machine.](http://localhost:3000)
### Running tests
```Ruby
    rspec
```
### Deployment
The application was deployed on heroku.
To deploy your own copy, you can follow the following [steps:](https://devcenter.heroku.com/articles/git)
## Authors

👤 **Mupa M'mbetsa Nzaphila**

- Github: [@mupa1](https://github.com/Mupa1)
- Twitter: [@mupa_mmbetsa](https://twitter.com/mupa_mmbetsa)
- Linkedin: [mupa-mmbetsa](https://www.linkedin.com/in/mupa-mmbetsa)

👤 **Taiwo Coker**

- Github: [@taiwocoker](https://github.com/taiwocoker)
- Twitter: [@SelloCoker](https://twitter.com/SelloCoker)
- Linkedin: [taiwo-coker](https://linkedin.com/in/taiwo-coker)
## 🤝 Contributing
Contributions and feature requests are welcome!
Start by:
- Forking the project
- Cloning the project to your local machine
- `cd` into the project directory
- Run `git checkout -b your-branch-name`
- Make your contributions
- Push your branch up to your forked repository
- Open a Pull Request with a detailed description to the development(or master if not available) branch of the original project for a review
## Show your support
Give a ⭐️ if you like this project!
## Acknowledgments
Microverse for the [skeleton repository](https://github.com/microverseinc/ror-social-scaffold) which this project was built on.
