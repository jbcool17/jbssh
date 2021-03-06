# Jbssh
- Learning about Gems and CLI Applications

CLI Utility for running commands on remote machines via SSH

## Installation

Install Dependencies:

    $ bundle

Run Locally:

    $ bundle exec jbssh

Or install it yourself as:

    $ rake build
    $ rake install

## Usage

Initialize, Add Computer & Run Commands
```
# Initialize config - this command setups .jbssh folder in your home directory
$ jbssh init

# store frequently used remote computers to the db
            [NAME] [IP]           [USER]   
$ jbssh add master 192.168.56.110 vagrant

# Run command
            [NAME]    [COMMAND]
$ jbssh com master -c ls
$ jbssh com master -c 'ls -lah'

```

```
Name: Jbssh
Version: 0.2.0
Info: CLI Utility for running commands on remote machines / downloading & uploading files via SSH/SCP

Commands:
  jbssh init                                                 # add computer
  jbssh add [NAME] [IP] [USER]                               # add computer
  jbssh com [COMPUTER-NAME] -c [COMMAND]                     # connect to and run command via ssh
  jbssh delete [NAME]                                        # delete computer
  jbssh help [COMMAND]                                       # Describe available commands or one specific command
  jbssh list                                                 # list all computers
  jbssh update [NAME] [FIELD] [NEW_VALUE]                    # update computer
  jbssh version | -v | --version                             # version
```

### Notes/TODO
- create .pub key copy / install public key

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jbcool17/jbssh.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
