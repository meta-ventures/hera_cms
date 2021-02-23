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
<!-- app/views/pages/home.html.erb  -->
<!-- ... -->

<%= hera_link 'home-link-main' %>

<!-- ... -->

```

Alternatively, you can create links passing a block, similar to the link_to rails helper

```erb
<!-- app/views/pages/home.html.erb  -->
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
<!-- app/views/pages/home.html.erb  -->
<!-- ... -->

<%= hera_text 'home-description', html_tag: :p %>

<!-- ... -->

```

### Images

Coming soon...

## Production Database

In order to facilitate you not have to duplicate all of your created records from development to production, we use a YAML file to store all record's information from development, located at db/hera_cms/hera_database_seed.yml

After you finish developing your application and want to build it in production, you can just run this command in production to replicate your created Hera Links, Texts and Images to your production database

```bash
rails hera_cms:populate_database
```

## Contributing

---- GEM STILL IN DEVELOPMENT ----

If you want to contribute, feel free to open an issue or contact me at rayan@hortatech.com.br

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
