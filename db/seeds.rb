# Create a main sample user.
User.create!( name:  "Samrood",
              email: "example1@social.org",
              password:              "passpass",
              password_confirmation: "passpass",
            )
User.create!( name:  "Samreena",
              email: "example2@social.org",
              password:              "passpass",
              password_confirmation: "passpass",
            )
User.create!( name:  "Sanjeed",
              email: "example3@social.org",
              password:              "passpass",
              password_confirmation: "passpass",
            )
            
User.create!( name:  "Jean",
              email: "example4@social.org",
              password:              "passpass",
              password_confirmation: "passpass",
            )

User.create!( name:  "Leon",
              email: "example5@social.org",
              password:              "passpass",
              password_confirmation: "passpass",
            )

Friendship.create!(
              user_id:1,
              friend_id: 2,
              confirmed: true
)

Friendship.create!(
              user_id:1,
              friend_id: 3,
              confirmed: false
)
Friendship.create!(
                  user_id:5,
                  friend_id:1,
                  confirmed: false
)
