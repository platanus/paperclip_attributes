# Paperclip Attributes

Rails Engine built on top of [Paperclip](https://github.com/thoughtbot/paperclip) gem to add attributes, as columns in your models, related to your attachments.

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

That's it! the process to extract attributes will be done on `before_save` callback of your `ActiveRecord` model instances, if these models have **modified paperclip attachments.**

## Example

```
rails g paperclip_attributes User avatar dimensions color
```

Then, with an `User` instance, you be able to do something like this:

```ruby
user = User.new
user.avatar = some_file
user.save!

user.avatar_height = 200
user.avatar_width = 400
user.avatar_dominant_color = "#FF9900"

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
