# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    name: 'User001',
    email: 'user001@example.com',
    gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
    password: 'Secret1',
    password_confirmation: 'Secret1'
  },
  {
    name: 'User002',
    email: 'user002@example.com',
    gravatar_url: 'https://www.w3schools.com/howto/img_avatar2.png',
    password: 'Secret1',
    password_confirmation: 'Secret1'
  },
  {
    name: 'User003',
    email: 'user003@example.com',
    gravatar_url: 'https://www.w3schools.com/w3images/avatar2.png',
    password: 'Secret1',
    password_confirmation: 'Secret1'
  },
  {
    name: 'User004',
    email: 'user004@example.com',
    gravatar_url: 'https://www.w3schools.com/w3images/avatar6.png',
    password: 'Secret1',
    password_confirmation: 'Secret1'
  }
])

Post.create([
  {
    user_id: User.first.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Aut totam ut amet quasi quidem numquam ipsam delectus illo error explicabo officia odio in modi incidunt, reprehenderit, expedita dolore impedit fugiat iusto eaque? Ex inventore minus quaerat iure eius obcaecati quibusdam dolore totam? Praesentium est nihil enim! Esse ad dolor similique, asperiores veniam, cupiditate fugiat nostrum ipsam unde cumque enim pariatur et eaque. Modi sint enim, nostrum maiores id atque nisi facere eius soluta consequatur consequuntur officia? Voluptatem dolorum quidem eligendi distinctio, dolore fuga mollitia non iste voluptas repudiandae quaerat, quis fugiat perferendis assumenda nisi deserunt quibusdam laboriosam minus libero eveniet. Placeat quos blanditiis, et tempora, exercitationem totam obcaecati similique quibusdam quis impedit deserunt recusandae aspernatur labore ratione, delectus optio debitis laboriosam consequuntur voluptas.'
  },
  {
    user_id: User.second.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Aut totam ut amet quasi quidem numquam ipsam delectus illo error explicabo officia odio in modi incidunt, reprehenderit, expedita dolore impedit fugiat iusto eaque?'
  },
  {
    user_id: User.second.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius voluptatum dignissimos nesciunt, ipsum doloribus soluta assumenda nihil, repellendus corrupti ducimus facere molestiae earum quos sint quidem praesentium ipsa repellat commodi molestias harum voluptate dolorem, deserunt optio. Voluptatem culpa aliquid rem corporis possimus blanditiis, fugit, quae sunt dolores, assumenda quam ab?'
  },
  {
    user_id: User.third.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Aut totam ut amet quasi quidem numquam ipsam delectus illo error explicabo officia odio in modi incidunt, reprehenderit, expedita dolore impedit fugiat iusto eaque? Ex inventore minus quaerat iure eius obcaecati quibusdam dolore totam? Praesentium est nihil enim! Esse ad dolor similique, asperiores veniam, cupiditate fugiat nostrum ipsam unde cumque enim pariatur et eaque. Modi sint enim, nostrum maiores id atque nisi facere eius soluta consequatur consequuntur officia? Voluptatem dolorum quidem eligendi distinctio, dolore fuga mollitia non iste voluptas repudiandae quaerat, quis fugiat perferendis assumenda nisi deserunt quibusdam laboriosam minus libero eveniet. Placeat quos blanditiis, et tempora, exercitationem totam obcaecati similique quibusdam quis impedit deserunt recusandae aspernatur labore ratione, delectus optio debitis laboriosam consequuntur voluptas.'
  },
  {
    user_id: User.third.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestiae, exercitationem? Maiores alias accusantium error, illum distinctio repellat voluptas cupiditate adipisci dolores ipsum expedita, ab sed?'
  }
])

Comment.create([
  {
    user_id: User.fourth.id,
    post_id: Post.first.id,
    content: 'Lorem ipsum dolor sit amet.'
  },
  {
    user_id: User.second.id,
    post_id: Post.first.id,
    content: 'Lorem ipsum dolor sit amet. (2x)'
  },
  {
    user_id: User.first.id,
    post_id: Post.second.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Et, quaerat.'
  },
  {
    user_id: User.third.id,
    post_id: Post.third.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit.'
  },
  {
    user_id: User.third.id,
    post_id: Post.fourth.id,
    content: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Lorem ipsum dolor sit amet.'
  },
  {
    user_id: User.third.id,
    post_id: Post.fifth.id,
    content: 'Lorem ipsum dolor sit amet.'
  }
])

Like.create([
  {
    user_id: User.second.id,
    post_id: Post.first.id
  },
  {
    user_id: User.third.id,
    post_id: Post.first.id
  },
  {
    user_id: User.fourth.id,
    post_id: Post.first.id
  },
  {
    user_id: User.first.id,
    post_id: Post.second.id
  },
  {
    user_id: User.third.id,
    post_id: Post.second.id
  },
  {
    user_id: User.fourth.id,
    post_id: Post.second.id
  },
  {
    user_id: User.first.id,
    post_id: Post.third.id
  },
  {
    user_id: User.third.id,
    post_id: Post.third.id
  },
  {
    user_id: User.first.id,
    post_id: Post.fourth.id
  },
  {
    user_id: User.fourth.id,
    post_id: Post.fourth.id
  }
])

Friendship.create([
  {
    user_id: User.first.id,
    friend_id: User.second.id,
    status: true
  },
    {
    user_id: User.second.id,
    friend_id: User.first.id,
    status: true
  },
  {
    user_id: User.second.id,
    friend_id: User.third.id,
    status: true
  },
  {
    user_id: User.third.id,
    friend_id: User.second.id,
    status: false
  },
  {
    user_id: User.third.id,
    friend_id: User.first.id,
    status: true
  },
  {
    user_id: User.first.id,
    friend_id: User.third.id,
    status: true
  },
  {
    user_id: User.fourth.id,
    friend_id: User.second.id,
    status: true
  },
  {
    user_id: User.second.id,
    friend_id: User.fourth.id,
    status: true
  },
  {
    user_id: User.fourth.id,
    friend_id: User.third.id,
    status: true
  },
  {
    user_id: User.third.id,
    friend_id: User.fourth.id,
    status: false
  }
])
