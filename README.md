# capistrano/ext/ol

Custom [Capistrano][capistrano] tasks abstracted from various [Object Lateral][ol] deploys

## Installation

Add this line to your application's Gemfile:

    gem "capistrano-ext-ol", require: false, github: "objectlateral/capistrano-ext-ol"

And then execute:

    $ bundle

## Usage

You can pull in specific types of tasks by manually requirig the files at the
top of your `config/deploy.rb`:

    require "capistrano/ext/ol/config"
    require "capistrano/ext/ol/db"
    # et cetera

Or, if you want the whole kit-and-kaboodle, require like this:

    require "capistrano/ext/ol"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[capistrano]:https://github.com/capistrano/capistrano
[ol]:http://objectlateral.com
