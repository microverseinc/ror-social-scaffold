# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
    {name:"Lucy",
      email:"lucy@gmail.com",
      password:"secret"
    },
    {name:"Rick",
      email:"Rick@gmail.com",
      password:"facebook"
    },
    {name:"Morty",
      email:"morty@gmail.com",
      password:"microverse",
  
  
    },
    {name:"jessica",
      email:"jessica@gmail.com",
      password:"jessica"
    },
    {
        name:"instagram",
        email:"instagram@gmail.com",
        password:"instagram"
    }
])



