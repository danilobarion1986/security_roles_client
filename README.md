# Security Roles Client

This is a generic client for use in conjunction with a security roles service/API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'security_roles_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install security_roles_client

## Usage

In order to use the client to verify if the user can access some resource,
you need to configure the permission mapping:

```ruby
SecurityRolesClient.config.permission_mapping = {
  permission_keys: [
    {
      key: :default, # identifier to group a list of access rights.
      accesses: {
        # <method, key> pair, relating a method from the application to a key
        # that is expected to return from the Security Roles Service
        index: :list
      }
    }
  ]
}
```

Then, you can verify some action with the following code:

```ruby
SecurityRolesClient::Authorizer.can_access?(permission_key: :default,
                                            action: :index,
                                            access_token: '<default_format_access_token>')
```

To allow the correct parsing of the `access_token`, you'll need to define a `access_token_parser`.
The value could be a lambda, class, module, or any object that responds to `.call`, and receives
only one parameters which is the raw `access_token`, as the example below:

```ruby
SecurityRolesClient.config.access_token_parser = -> (access_token) {
  # process the access_token here...
  your_method_to_parse(access_token)
}
```

If you have some code that needs to verify a different format of `access_token`, you can pass
a custom parser on each call like this:

```ruby
SecurityRolesClient::Authorizer.can_access?(permission_key: :default,
                                              action: :index,
                                              access_token: '<custom_format_access_token>',
                                              access_token_parser: CustomAccessTokenParser)
```

## Code Quality and Coverage

To verify the code quality, run `bundle exec rubycritic lib`.

To verify the test coverage, run `bundle exec simplecov` and open the `coverage/index.html` file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `gem build security_roles_client.gemspec`,
and add a new git tag with the updated gem version.
