require 'open-uri'

demo = User.create(username:"demo",
            email: "demo@rumblr.com",
            password: "demo_password",
            password_confirmation: "demo_password",
            bio: "I'm a demo user.")

demo.profile_picture.attach(io: File.open(Rails.root.join("app/assets/images/wahoo.jpg")), filename: "wahoo.jpg")

["Alice", 
 "Bob", 
 "Carol",
 "Dave", 
 "Erin", 
 "Frank"].each do |name|
  user = User.create(username: name.downcase,
              email: "#{name}@rumblr.com",
              password: "#{name}_password",
              password_confirmation: "#{name}_password",
              bio: "I'm #{name}.")
  user.profile_picture.attach(io: URI.open("https://loremflickr.com/300/300/cats"), filename: "#{name}.jpg")
end

users = User.all.where.not(username: "demo")

users.each do |user|
  users.sample(rand(6) + 1).each do |other_user|
    user.follow(other_user) unless user.following?(other_user)
  end
end

10.times do
  user = users.sample
  post = user.posts.create(content: Faker::Lorem.paragraph(sentence_count: rand(12) + 1))

  users.sample(rand(6)).each do |liker|
    post.likes.create(user: liker) unless liker == user
  end

  rand(3).times do
    if rand(1) == 1
      post.comments.create(body: Faker::Lorem.paragraph(sentence_count: rand(6)), author: users.sample)
    else
      original_post = Post.all.sample
      reblog = original_post.children.create(content: Faker::Lorem.paragraph(sentence_count: rand(12) + 1), author: users.sample)
      PostNote.create(post_id: original_post.root.id, note_id: reblog.id, note_type: "Post")
    end
  end
end
