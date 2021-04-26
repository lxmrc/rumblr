# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

demo = User.create(username: "demo",
                  password: "password",
                  password_confirmation: "password",
                  bio: "Demo user.")

demo.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/wahoo.jpg')),
                  filename: 'wahoo.jpg')

alice = User.create(username: "alice",
            email: "alice@rumblr.com",
            password: "alice's password",
            password_confirmation: "alice's password",
            bio: "I'm Alice.")

alice.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/red.png')),
                  filename: 'red.png')

bob = User.create(username: "bob",
            email: "bob@rumblr.com",
            password: "bob's password",
            password_confirmation: "bob's password",
            bio: "I'm Bob.")

bob.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/orange.png')),
                  filename: 'orange.png')

carol = User.create(username: "carol",
            email: "carol@rumblr.com",
            password: "carol's password",
            password_confirmation: "carol's password",
            bio: "I'm Carol.")

carol.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/yellow.png')),
                  filename: 'yellow.png')

dave = User.create(username: "dave",
            email: "dave@rumblr.com",
            password: "dave's password",
            password_confirmation: "dave's password",
            bio: "I'm Dave.")

dave.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/green.png')),
                  filename: 'green.png')

erin = User.create(username: "erin",
            email: "erin@rumblr.com",
            password: "erin's password",
            password_confirmation: "erin's password",
            bio: "I'm Erin.")

erin.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/blue.png')),
                  filename: 'blue.png')

frank = User.create(username: "frank",
            email: "frank@rumblr.com",
            password: "frank's password",
            password_confirmation: "frank's password",
            bio: "I'm Frank.")

frank.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/purple.png')),
                  filename: 'purple.png')

alice.follow(bob)
alice.follow(carol)
alice.follow(dave)
alice.follow(erin)
alice.follow(frank)

bob.follow(alice)
bob.follow(carol)
bob.follow(erin)

carol.follow(alice)
carol.follow(bob)
carol.follow(dave)
carol.follow(erin)

dave.follow(erin)
dave.follow(frank)

erin.follow(bob)
erin.follow(carol)
erin.follow(dave)

post1 = alice.posts.create(content: Faker::Lorem.paragraph(sentence_count: 8))
post2 = carol.posts.create(content: Faker::Lorem.paragraph(sentence_count: 12))
post3 = frank.posts.create(content: Faker::Lorem.paragraph(sentence_count: 6))

post1.likes.create(user: bob)
post1.likes.create(user: carol)

post2.likes.create(user: alice)
post2.likes.create(user: bob)
post2.likes.create(user: dave)
post2.likes.create(user: frank)

post3.likes.create(user: alice)
post3.likes.create(user: bob)
post3.likes.create(user: carol)
post3.likes.create(user: dave)
post3.likes.create(user: erin)

reblog1 = post1.children.create(content: Faker::Lorem.sentences(number: 6).join, author: dave)
reblog2 = post1.children.create(content: Faker::Lorem.sentences(number: 4).join, author: carol)

reblog3 = reblog1.children.create(content: Faker::Lorem.sentences(number: 4).join, author: erin)
reblog4 = reblog3.children.create(content: Faker::Lorem.sentences(number: 6).join, author: frank)

reblog5 = post2.children.create(author: bob)
reblog6 = post3.children.create(author: alice)

# post1 = alice.posts.create(content: "I'm blogging.")
# post1.likes.create(user: bob)
# post1.likes.create(user: carol)
# 
# reblog1 = post1.children.create(content: "Me too!", author: bob)
# PostNote.create(post_id: post1.id, note_id: reblog1.id, note_type: "Post")
# 
# post1.comments.create(author: dave, body: "I'm not.")
# 
# reblog2 = reblog1.children.create(content: "Great job.", author: carol)
# PostNote.create(post_id: reblog1.root.id, note_id: reblog2.id, note_type: "Post")
# 
# reblog2 = post1.children.create(content: "I'm blogging as well.", author: dave)
# reblog2.likes.create(user: alice)
# reblog2.likes.create(user: carol)
# 
# reblog3 = reblog2.children.create(content: "No you're not.", author: alice)
# PostNote.create(post_id: reblog2.root.id, note_id: reblog3.id, note_type: "Post")
