# HeraCms
Hera aims to enable you to easily add Content Managment to your Rails projects, with a very friendly user interface.

## Usage
We use some tables to store the editable content of your website, in order for it to be updatable dynamically by the website owner.

## Installation

1. Add this line to your application's Gemfile:
```ruby 
gem 'hera_cms' 
```
2. Execute:
```bash
$ bundle
```

3. The Hera Installer will generate some migrations, that you need to run:
```bash
$ rails hera_cms:install
$ rails db:migrate
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

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
