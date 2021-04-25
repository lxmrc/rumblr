# Rumblr

A Tumblr-like microblogging application made with Ruby on Rails. Initially an attempt at recreating the microblogging application from [Michael Hartl's Rails Tutorial](https://railstutorial.org) from scratch while referring to the tutorial as little as possible in order to solidify my understanding. 

Once the basic "micropost" functionality was in place I decided to add likes, comments and reblogs (a.k.a.: retweets/quote tweets).

## User stories

### Authentication and user profiles

- [x] Users can create an account and login.
- [x] Users can upload a profile picture.
- [x] Users can update their bio.
- [x] Users can change their username.

### Text posts

- [x] Users can create text posts.
- [x] Users can edit text posts.
- [x] Users can delete text posts.

### Likes and comments

- [x] Users can like and unlike posts.
- [x] Users can comment on a post.
- [x] Users can delete their own comments.
- [x] Users can delete comments on their posts.

### Followers and feed

- [x] Users can follow and unfollow other users.
- [x] Users can see how many people a user follows and is followed by.
- [x] Users can see a feed of posts from users they follow.

### Image posts

- [ ] Users can attach images to their posts.

### Reblogging

- [x] Users can reblog posts from other users.
- [x] Users can add text and images underneath posts they reblog.

## Challenges

The first two were relatively straightforward but reblogs turned out to be somewhat more complicated than anything else I'd done in Rails before.

### Hierarchical data models

Reblogs are essentially posts that are associated with other posts. Each reblog has one parent and any number of children, each of which can represent a new branch of the reblog tree or graph. I would later learn that this is called a [hierarchical database model](https://en.wikipedia.org/wiki/Hierarchical_database_model). I struggled to implement this with basic ActiveRecord associations.

Eventually I discovered the [Ancestry gem](https://github.com/stefankroes/ancestry) was the most straightforward way of implementing this. With a simple database migration and the addition of the `has_ancestry` method to my `Post` model I now had "all the standard tree structure relations (ancestors, parent, root, children, siblings, descendants), allowing all of them to be fetched in a single SQL query".

### Reverse polymorphic associations

Once I had reblogs in place I wanted to be able to display all of the "notes" associated with a post, meaning all of its likes, comments and reblogs together. It seemed like what I was trying to do was create a "polymorphic association" but all of the examples online weren't quite what I was looking for. For instance, the Rails guides provide this example:

>With polymorphic associations, a model can belong to more than one other model, on a single association. For example, you might have a picture model that belongs to either an employee model or a product model.

I struggled to adapt various examples to my specific situation until I figured out that what I was trying to do was the reverse of most examples: rather than a model that can belong to more than one other model on a single association, I needed a model that could "have many" different kinds of models through the same association.

Eventually I came across [this post](http://www.99linesofcode.com/polymorphic-associations-in-ruby-on-rails-part-2-reverse-polymorphic-associations/) which finally allowed me to set up the associations I needed.
