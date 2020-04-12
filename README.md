# Mailpeek

Mailpeek provides a web interface to view emails sent out when developing in Rails.

## Installation

Add to your Gemfile:

```
gem 'mailpeek', group: %i[development test]
```

## Setup

In your `config/environments/development.rb` file:

```
config.action_mailer.delivery_method = :mailpeek
```

Then add a file called `config/initializers/mailpeek.rb` with this:

```
Mailpeek.configure do |config|
  config.location = Rails.root.join('tmp/mailpeek')
end
```

Finally in your `routes.rb` file add this line:

```
mount Mailpeek::Web => '/mailpeek' if Rails.env.development?
```

## Use

Once an email is sent in a Rails project, either via `deliver_now` or `deliver_later`.  You can then view the email by visiting:

```
http://localhost:3000/mailpeek
```
