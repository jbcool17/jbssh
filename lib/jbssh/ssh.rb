module Jbssh
  class SSH
    def self.run_command_quiet(ip, user, command)
      Net::SSH.start(ip, user) do |ssh|
        channel = ssh.open_channel do |ch|
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
          end
        end
        channel.wait
      end
    end

    def self.run_command_loud(ip, user, command)
      Net::SSH.start(ip, user) do |ssh|
        Jbssh.message name, "Logged in to #{ssh.exec!('hostname')}".strip.blue
        channel = ssh.open_channel do |ch|
          Jbssh.message name, "Running command: #{command}".strip.blue
          ch.request_pty
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

          end
          ch.wait
          # loop until ctrl-C is pressed
          # int_pressed = false
          # trap("INT") { int_pressed = true }
          # ssh.loop(0.1) { not int_pressed }
        end
        channel.wait
        Jbssh.message name, "Logging out of #{ssh.exec!('hostname')}".strip.blue
      end
    end
  end
end
