# Paperclip Attributes [![Gem Version](https://badge.fury.io/rb/paperclip_attributes.svg)](https://badge.fury.io/rb/paperclip_attributes) [![Build Status](https://travis-ci.org/platanus/paperclip_attributes.svg?branch=master)](https://travis-ci.org/platanus/paperclip_attributes) [![Coverage Status](https://coveralls.io/repos/github/platanus/paperclip_attributes/badge.svg)](https://coveralls.io/github/platanus/paperclip_attributes)

Rails Engine built on top of [Paperclip](https://github.com/thoughtbot/paperclip) gem to add attributes, as columns in your models, related to your attachments.

## Paperclip Attributes is no longer maintained.

- We will leave the Issues open as a discussion forum only.
- We do not guarantee a response from us in the Issues.
- We are no longer accepting pull requests.

## Installation

Add to your Gemfile:

```ruby
gem "paperclip_attributes"
```

```bash
bundle install
```

## Usage

To add new attributes, you need to run the following generator:

```
rails g paperclip_attributes Model attachment recipe1 recipe2
```

* `Model`: is the Active Record model containing the attachment you want to add attributes.
* `attachment`: is the paperclip's attachment name on given model.
* `recipes (recipe1 recipe2)`: is a list of recipes to extend the attachment. A recipe represents one or more attributes related to the attachment param. You can see a full list of recipes on the section below.

The generator, will only create migrations to extend your attachments. So, after run it, you need to do:

```
rake db:migrate
```

Then, to enable the functionality in your model, you need to add the recipes to the attachment definition:

```ruby
class MyModel < ActiveRecord::Base
  has_attached_file :attachment, attributes: [:recipe1, :recipe2]
end
```

That's it!

The process to extract attributes will be done on `before_save` callback.

## Example

```
rails g paperclip_attributes User avatar dimensions color
```

In `User` model:

```ruby
class User < ActiveRecord::Base
  has_attached_file :avatar, attributes: [:dimensions, :color]
end
```

Then, with an `User` instance, you'll be able to do something like this:

```ruby
user = User.new
user.avatar = some_file
user.save!

user.avatar_height #=> 200
user.avatar_width #=> 400
user.avatar_dominant_color #=> "#FF9900"

```

## Recipes

### For images:

#### `dimensions`:

* `[attachment]_width`: the original width of the image.
* `[attachment]_height`: the original height of the image.

#### `color`:

* `[attachment]_dominant_color`: the predominant color of the image.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/paperclip_attributes/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

Paperclip Attributes is maintained by [platanus](http://platan.us).

## License

Paperclip Attributes is © 2016 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
