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
      computer = Jbssh::Data.get_computer name
      puts computer[0][1]
      if options[:quiet]
        Jbssh::SSH.run_command_quiet computer[0][1], computer[0][2], computer[0][3], command
      else
        Jbssh::SSH.run_command_loud computer[0][1], computer[0][2], computer[0][3], command
      end
    end

    desc "upload [COMPUTER-NAME] [LOCAL_PATH] [REMOTE_PATH]", "upload a local file"
    method_option :remote_path, :aliases => "-r", :desc => "add remote_path"
    method_option :local_path, :aliases => "-l", :desc => "add local_path"
    def upload(name, local_path='/Users/webdev/Projects/Practice/jbssh/testsrc.mov', remote_path='/home/vagrant')
      remote_path = options[:remote_path] || remote_path
      local_path = options[:local_path] || local_path
      computer = Jbssh::RemoteComputer.get_computer name

      Jbssh::SCP.upload computer[:ip], computer[:user], computer[:password], local_path, remote_path
    end

    desc "download [COMPUTER-NAME] [REMOTE_PATH] [LOCAL_PATH]", "download a remote file"
    method_option :remote_path, :aliases => "-r", :desc => "add remote_path"
    method_option :local_path, :aliases => "-l", :desc => "add local_path"
    def download(name, remote_path='/home/vagrant/testsrc.mov', local_path="#{`pwd`}")
      remote_path = options[:remote_path] || remote_path
      local_path = options[:local_path] || local_path
      computer = Jbssh::RemoteComputer.get_computer name

      Jbssh::SCP.download computer[:ip], computer[:user], computer[:password], remote_path, local_path
    end

    desc "init", "initialize config & storage"
    def init
      Jbssh::Data.initialize_computers_storage
    end

    desc "list", "list all computers"
    def list
      Jbssh::Data.get_list.each { |r| puts r }
    end

    desc "add [NAME] [IP] [USER] [PASSWORD]", "add computer"
    def add(name, ip, user, password)
      Jbssh::Data.add_computer(name, ip, user, password)
    end

    desc "update [NAME] [FIELD] [NEW_VALUE]", "update computer"
    def update(name, field, new_value)
      puts "Needs Implementation."
    end

    desc "delete [NAME]", "delete computer"
    def delete(name)
      Jbssh::Data.delete(name)
    end
  end
end
