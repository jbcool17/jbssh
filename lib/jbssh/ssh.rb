require 'net/ssh'

module Jbssh
  class SSH
    def self.connect_to(ip, user, password, command)
      Jbssh.message name, "Connecting to #{ip}...".blue

      Net::SSH.start(ip, user, :password => password) do |ssh|
        Jbssh.message name, "Logged in to #{ssh.exec!('hostname')}".strip.blue
        Jbssh.message name, "Running command: #{command}".strip.blue
        Jbssh.message name, "#{ssh.exec!(command)}".strip.green
        Jbssh.message name, "Logging out of #{ssh.exec!('hostname')}".strip.blue
      end
    end
  end
end
