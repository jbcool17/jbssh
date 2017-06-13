require 'colorize'
require 'ruby-progressbar'
require 'thor'
require 'net/ssh'
require 'fileutils'
require 'csv'

require "jbssh/version"
require 'jbssh/cli'
require 'jbssh/ssh'
require 'jbssh/host_controller'


module Jbssh
  def self.message(node, m)
    puts "#{node}: ===> #{m}"
  end

  def self.main_dir
    Dir.home
  end

  def self.servers
    "#{Jbssh.main_dir}/.jbssh/servers.csv"
  end
  
  # def self.logger
  # @logger ||= Jbgit::Logger.new
  # end

end
