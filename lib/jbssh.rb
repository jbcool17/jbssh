require 'colorize'
require 'ruby-progressbar'
require 'thor'
require 'sqlite3'
require 'net/scp'
require 'net/ssh'

require "jbssh/version"
require 'jbssh/cli'
require 'jbssh/ssh'
require 'jbssh/scp'
require 'jbssh/remote_computer'


module Jbssh
  def self.message(node, m)
    puts "#{node}: ===> #{m}"
  end

  # def self.logger
  # @logger ||= Jbgit::Logger.new
  # end

end
