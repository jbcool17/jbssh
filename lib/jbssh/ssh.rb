module Jbssh
  class SSH
    def self.run_command_quiet(ip, user, password, command)
      Jbssh.message name, "Connecting to #{ip}...".blue

      Net::SSH.start(ip, user, :password => password) do |ssh|
        Jbssh.message name, "Logged in to #{ssh.exec!('hostname')}".strip.blue
        Jbssh.message name, "Running command: #{command}".strip.blue
        channel = ssh.open_channel do |ch|
          ch.exec command do |ch, success|
            raise "could not execute command" unless success

            # "on_extended_data" is called when the process writes something to stderr
            ch.on_extended_data do |c, type, data|
              $stderr.print data
            end
          end
        end
        channel.wait
        Jbssh.message name, "Logging out of #{ssh.exec!('hostname')}".strip.blue
      end
    end

    def self.run_command_loud(ip, user, password, command)
      Net::SSH.start(ip, user, :password => password) do |ssh|
        Jbssh.message name, "Logged in to #{ssh.exec!('hostname')}".strip.blue
        channel = ssh.open_channel do |ch|
          Jbssh.message name, "Running command: #{command}".strip.blue
          ch.exec command do |ch, success|
            raise "could not execute command" unless success

            # "on_data" is called when the process writes something to stdout
            ch.on_data do |c, data|
              $stdout.print data
            end

            # "on_extended_data" is called when the process writes something to stderr
            ch.on_extended_data do |c, type, data|
              $stderr.print data
            end

            # ch.on_close { puts "done!" }
          end
        end
        channel.wait
        Jbssh.message name, "Logging out of #{ssh.exec!('hostname')}".strip.blue
      end
    end
  end
end
