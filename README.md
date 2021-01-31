# Json Schema Generator

Json Schema Generator is to describe the structure and validation constraints of your JSON documents. There are many json-schema validators, but only few generators. This library is intended to provide Ruby with an interface for validating JSON objects against a JSON schema conforming to JSON Draft7.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_schema_transformer', '~> 0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_schema_transformer

## Usage

```
input = {name: 'naren', role:[{id: 1, name: 'backend'}, {id: 2, name: 'frontend'}]} // provide JSON input
JsonSchema.generate(input)

Output:
{"title"=>"The root schema", "description"=>"The root schema comprises the entire JSON document.", "$schema"=>"http://json-schema.org/draft-07/schema", "type"=>"object", "required"=>["name", "role"], "properties"=>{"name"=>{"type"=>"string"}, "role"=>{"type"=>"array", "items"=>{"type"=>"object", "required"=>["id", "name"], "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}}}}}}
```
## Optional Parameters:

Array validations
```
Input:
{:data=>[{:id=>"1", :type=>"type1", :attributes=>{:message=>"Message", :status=>"pending"}}, {:id=>"2", :something=>"typ2", :attributes=>{:name=>"Name1", :activity=>"None"}}]} 

```
## To return array first element Schema:
```
To return Array first element's Schema:
JsonSchema.generate(input, array_validations: :first_element)

Output: {"title"=>"The root schema", "description"=>"The root schema comprises the entire JSON document.", "$schema"=>"http://json-schema.org/draft-07/schema", "type"=>"object", "required"=>["data"], "properties"=>{"data"=>{"type"=>"array", "items"=>{"type"=>"object", "required"=>["id", "type", "attributes"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}, "attributes"=>{"type"=>"object", "required"=>["message", "status"], "properties"=>{"message"=>{"type"=>"string"}, "status"=>{"type"=>"string"}}}}}}}}
```
## To return Entire Array Schema:

```

JsonSchema.generate(input, array_validations: :any_of)

Output: {"title"=>"The root schema", "description"=>"The root schema comprises the entire JSON document.", "$schema"=>"http://json-schema.org/draft-07/schema", "type"=>"object", "required"=>["data"], "properties"=>{"data"=>{"type"=>"array", "items"=>{"anyOf"=>[{"type"=>"object", "required"=>["id", "type", "attributes"], "properties"=>{"id"=>{"type"=>"string"}, "type"=>{"type"=>"string"}, "attributes"=>{"type"=>"object", "required"=>["message", "status"], "properties"=>{"message"=>{"type"=>"string"}, "status"=>{"type"=>"string"}}}}}, {"type"=>"object", "required"=>["id", "something", "attributes"], "properties"=>{"id"=>{"type"=>"string"}, "something"=>{"type"=>"string"}, "attributes"=>{"type"=>"object", "required"=>["name", "activity"], "properties"=>{"name"=>{"type"=>"string"}, "activity"=>{"type"=>"string"}}}}}]}}}} 


```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Narendranvel/json_schema. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JsonSchema project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Narendranvel/json_schema/blob/master/CODE_OF_CONDUCT.md).
