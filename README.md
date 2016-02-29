# Mailpeek

Mailpeek provides a web interface to view emails sent out when developing in Rails.

## Installation

Add to your Gemfile:

```
gem 'mailpeek', group: :development
```

## Setup

In your `config/environments/development.rb` file:

```
config.action_mailer.delivery_method = :mailpeek
```

Then in your `routes.rb` file add this line:

```
mount Mailpeek::Engine => '/mailpeek' if Rails.env.development?
```
