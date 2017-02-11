require 'colorize'
require 'ruby-progressbar'

require "jbssh/version"
require 'jbssh/cli'
require 'jbssh/ssh'
require 'jbssh/scp'


module Jbssh
  def self.message(node, m)
    puts "#{node}: ===> #{m}"
  end

  # def self.logger
  # @logger ||= Jbgit::Logger.new
  # end

  #----------------------------------------------------
  # SSH/SCP
  #----------------------------------------------------

  # def self.connect_to(ip, user, password, command)
  #
  #   status = ''
  #
  #   message name, "Connecting to #{ip}...".blue
  #
  #   Net::SSH.start(ip, user, :password => password) do |ssh|
  #     message name, "Logged in to #{ssh.exec!('hostname')}".strip.blue
  #     message name, "Running command: #{command}".strip.blue
  #     status = ssh.exec!(command)
  #     message name, "OUTPUT: #{status}".strip.green
  #     message name, "Logging out of #{ssh.exec!('hostname')}".strip.blue
  #   end
  #
  #   message name, " "
  #
  #   status
  # end
  #
  # def self.upload(ip, user, password, local_path, remote_path)
  #   progressbar = ProgressBar.create(title: "#{name}: TRANSFER ===>", length: 100, format: "%t |%B| %P%%",:progress_mark  => '#')
  #   Net::SCP.upload!(ip, user, local_path, remote_path, :ssh => { :password => password }) do |ch, name, sent, total|
  #     progressbar.progress = sent.fdiv(total) * 100
  #   end
  #
  #   # 100.0
  #   progressbar.progress
  # end
  #
  # def self.download(ip, user, password, remote_path, local_path)
  #   # remote_path = "/home/vagrant/output/#{remote_file}"
  #   # node = self.encoders[name.to_sym]
  #   progressbar = ProgressBar.create(title: "#{name}: TRANSFER ===>", length: 100, format: "%t: |%B| %P%%", :progress_mark  => '#')
  #
  #   Net::SCP.download!(ip, user, remote_path, local_path, :ssh => { :password => password }) do |ch, name, sent, total|
  #     progressbar.progress = sent.fdiv(total) * 100
  #   end
  #
  #   # 100.0
  #   progressbar.progress
  # end

  # def run_command(name, command)
  #   node = self.encoders[name.to_sym]
  #   Net::SSH.start(node.ip, node.user, :password => node.pass) do |ssh|
  #     channel = ssh.open_channel do |ch|
  #       message name, "Running command: #{command}".strip.blue
  #       ch.exec command do |ch, success|
  #         raise "could not execute command" unless success
  #
  #         # "on_data" is called when the process writes something to stdout
  #         ch.on_data do |c, data|
  #           $stdout.print data
  #         end
  #
  #         # "on_extended_data" is called when the process writes something to stderr
  #         ch.on_extended_data do |c, type, data|
  #           $stderr.print data
  #         end
  #
  #         # ch.on_close { puts "done!" }
  #       end
  #     end
  #     channel.wait
  #   end
  #
  #   "COMMAND: #{command}"
  # end


end
