require 'thor'

module Jbssh
  class CLI < Thor
    desc "example FILE", "an example task"
    method_option :delete, :aliases => "-d", :desc => "Delete the file after parsing it"
    def example(file)
      puts "You supplied the file: #{file}"
      delete_file = options[:delete]
      if delete_file
        puts "You specified that you would like to delete #{file}"
      else
        puts "You do not want to delete #{file}"
      end
    end

    desc "version | -v | --version", "version"
    def version
      puts "Name: #{Jbssh.name}"
      puts "Version: #{VERSION}"
      puts "Info: CLI Utility for running commands on remote machines / downloading & uploading files via SSH/SCP"
    end
    map "-v" => 'version'
    map "--version" => 'version'


    desc "ssh_command IP USER PASSWORD COMMAND", "connect to and run command via ssh"
     method_option :command, :aliases => "-c", :desc => "run command"
    def ssh_command(ip='192.168.56.110', user='vagrant', password='vagrant', command='ls')
      command = options[:command] || command
      Jbssh::SSH.connect_to ip, user, password, command
    end

    desc "upload IP USER PASSWORD LOCAL_PATH REMOTE_PATH", "upload a local file"
    def upload(ip='192.168.56.110', user='vagrant', password='vagrant', file='/Users/webdev/Projects/Practice/jbssh/testsrc.mov', remote_path='/home/vagrant')
      Jbssh::SCP.upload ip, user, password, file, remote_path
    end

    desc "download IP USER PASSWORD REMOTE_PATH LOCAL_PATH", "download a remote file"
    def download(ip='192.168.56.110', user='vagrant', password='vagrant', remote_path='/home/vagrant/testsrc.mov', local_path='/Users/webdev/Projects/Practice/jbssh/testsrc1.mov')
      Jbssh::SCP.download ip, user, password, remote_path, local_path
    end
  end
end
