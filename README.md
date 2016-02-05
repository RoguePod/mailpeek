# Mailpeek

## Installation

```
gem 'mailpeek', github: 'RoguePod/mailpeek', group: :development
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
