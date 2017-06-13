module Jbssh
  class CLI < Thor
    desc "version | -v | --version", "version"
    def version
      puts "Name: #{Jbssh.name}"
      puts "Version: #{VERSION}"
      puts "Info: CLI Utility for running commands on remote machines / downloading & uploading files via SSH/SCP"
    end
    map "-v" => 'version'
    map "--version" => 'version'

    desc "com [COMPUTER-NAME] -c [COMMAND]", "connect to and run command via ssh"
    method_option :command, :aliases => "-c", :desc => "command"
    method_option :quiet, :aliases => "-q", :desc => "quiet"
    def com(name)
      command = options[:command]
      computer = Jbssh::HostController.get_computer name
      if options[:quiet]
        Jbssh::SSH.run_command_quiet computer[0][1], computer[0][2], command
      else
        Jbssh::SSH.run_command_loud computer[0][1], computer[0][2], command
      end
    end

    desc "init", "initialize config & storage"
    def init
      Jbssh::HostController.initialize_computers_storage
    end

    desc "list", "list all computers"
    def list
      Jbssh::HostController.get_list.each { |r| puts r }
    end

    desc "add [NAME] [IP] [USER]", "add computer"
    def add(name, ip, user)
      Jbssh::HostController.add_computer(name, ip, user)
    end

    desc "update [NAME] [FIELD] [NEW_VALUE]", "update computer"
    def update(name, field, new_value)
      puts "Needs Implementation."
    end

    desc "delete [NAME]", "delete computer"
    def delete(name)
      Jbssh::HostController.delete(name)
    end
  end
end
