# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create(name: "Mike", email: "m@m.com", password: "m", admin: true)

# Post.create(title: "test", url: "www.google.com", description: "testing it out", user_id: 1)

# Comment.create(reply: "testing this out", post_id: 1, user_id: 1)
# Comment.create(reply: "fingers crossed", post_id: 1, user_id: 2)
# Comment.create(reply: "ughhhhhhh", post_id: 1, user_id: 5)
# Comment.create(reply: "testing this out for post 1", post_id: 1, user_id: 1)

Community.create(category: "news")
Community.create(category: "US politics")
Community.create(category: "world politics")
Community.create(category: "memes")
Community.create(category: "world news")

