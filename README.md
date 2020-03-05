# Pollynomial

Pollynomial is simple AWS Polly wrapper. It enables to text to speech with AWS Polly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pollynomial'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pollynomial

## Usage

```rb
synthesizer = Pollynomial::Synthesizer.new(options)
synthesizer.synthesize(text, file_name: output)
```

There is a executable command `text2mp3`. You can use as following.
It is assumed to set AWS credentials in environmental variables.

```
Usage:
  text2mp3 -h | --help
  text2mp3 [--voiceid=<voiceid>] [--region=<region>] [-o <outfile>] [-s <rate>] <path>

Options:
  -h, --help                Show this help
  --voiceid=<voiceid>       Voice ID of AWS Polly
  -r, --region <region> AWS region name [dfault: us-east-1]
  -o, --output <outfile>    Output file name [default: tmp.mp3]
  -s, --samplerate <rate>   Sampling rate of output file [default: 16000]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chezou/ollynomial.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

