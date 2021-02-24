# HeraCms

Hera aims to enable you to easily add Content Managment to your Rails projects, with a very friendly user interface.

## Installation

1. Add this line to your application's Gemfile:
```ruby 
gem 'hera_cms' 
```
2. Execute:
```bash
bundle
```

3. The Hera Installer will generate some migrations, that you need to run:
```bash
rails g hera_cms:install
rails db:migrate
```

## Configuration

First, you need to add the Hera routes. Its highly recommended that you add some authentication logic (with devise or another library) to the routes level. Example with Devise:

```ruby
# config/routes.rb
authenticate :user, lambda { |u| u.admin? } do
    mount HeraCms::Engine => "/hera_cms"
end

```

Then, you need to add the Hera navbar to your layout. Here is also highly recommended to add authentication logic, in order to restrict who is able to update the content of your website. Example with Devise:

```html
# app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
  <head>
    <!-- ... -->
  </head>

  <body>
    <!-- ... -->
    <% if current_user&.admin? %>
        <%= hera_admin_navbar %>
    <% end %>
    <%= yield %>
    <!-- ... -->
  </body>
</html>


```

## Usage
We use hera_cms tables to store the editable content of your website, in order for it to be updatable dynamically by the website owner.

There are 3 types of editable content you can use: Links, Texts and Images

### Links

To add an editable link to the view, you first need to create it in the rails console

```ruby
# rails console
pry(main)> HeraCms::Link.create(identifier: 'home-link-main', inner_text: "HortaTech", path: 'https://www.hortatech.com.br')

```

Then you can just add it to the view using the Hera Link Helper, passing the correct identifier

```erb
<!-- ... -->

<%= hera_link 'home-link-main' %>

<!-- ... -->

```

Alternatively, you can create links passing a block, similar to the link_to rails helper

```erb
<!-- ... -->

<%= hera_link 'home-link-main', class: 'main-link' do %>
  <div class="card">
    <p>Lorem ipsum</p>
  </div>
<% end %>

<!-- ... -->

```


### Texts

To add an editable text to the view, it is exactly like addings links. You first need to create it in the rails console

```ruby
# rails console
pry(main)> HeraCms::Text.create(identifier: 'home-description', inner_text: "These are not the droids you're looking for")

```

Then you can just add it to the view using the Hera Text Helper, passing the correct identifier

```erb
<!-- ... -->

<%= hera_text 'home-description', html_tag: :p %>

<!-- ... -->

```

### Images

To use images that the owner can edit the SRC URL that will be displayed, it's almost the same as the other models

First you create the image in the rails console

```ruby
# rails console
pry(main)> HeraCms::Image.create(identifier: 'tutorial-01', url: 'https://picsum.photos/200/300')

```

Then you add it to the view using the Hera Image Helper, passing the correct identifier

```erb
<!-- ... -->

<%= hera_image 'tutorial-01' %>

<!-- ... -->

```

#### Image uploads

Hera currently has support for Image uploads with Active Storage.
To enable the owner to change the editable Images by uploading new images, you first need to configure Active Storage properly, according to the [Active Storage Documentation](https://edgeguides.rubyonrails.org/active_storage_overview.html)

After Active Storage is properly set, you will need to update the HeraCms config file

```ruby
# config/initializers/hera.rb
HeraCms.setup do |config|
  config.image_upload = true
  config.upload_service = :active_storage
end

```

And create an image with upload in the rails console

```ruby
# rails console
pry(main)> image = HeraCms::Image.new(identifier: 'tutorial-02')
pry(main)> image.upload.attach(io: File.open(Rails.root.join('app/assets/images/logo.jpg')), filename: 'logo.jpg')
pry(main)> image.save
```

## Production Database

In order to facilitate you not have to duplicate all of your created records from development to production, we use a YAML file to store all record's information from development, located at db/hera_cms/hera_database_seed.yml

After you finish developing your application and want to build it in production, you can just run this command in production to replicate your created Hera Links, Texts and Images to your production database

```bash
rails hera_cms:populate_database
```

For the image uploads, you will have to re-attach your image files to your populated production images

## Contributing

If you want to contribute, feel free to open an issue or contact me at rayan@hortatech.com.br

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
