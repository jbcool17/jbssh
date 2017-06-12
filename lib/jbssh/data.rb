module Jbssh
  class Data
      class << self
        def initialize_computers_storage
          data_dir = "#{Jbssh.main_dir}/.jbssh"
          if !Dir.exists? data_dir
            Dir.mkdir data_dir
            puts "Directory created..."
          end

          if !File.exists? Jbssh.servers
            CSV.open(Jbssh.servers, "wb") do |csv|
              csv << ["name", "ip", "user", "password"]
            end
            File.chmod(0700,Jbssh.servers)
            puts "File created..."
          end
        end

        def add_computer(name, ip, user, password)
          nametest = name.to_s
          if check_uniq(nametest)
            CSV.open(Jbssh.servers, "a+") do |csv|
              csv << [nametest, ip, user, password]
            end
            puts "Computer has been added."
          else
            puts "Name is not unique."
          end

        end

        def remove_computer(name)
          puts "Computer has been deleted."
        end

        def get_list
          puts get_csv_hash
        end

        def check_uniq(name)
          data = get_csv_hash

          if data.collect { |a| a[:name] }.index(name).nil?
            return true
          end

          false
        end

        def get_csv_hash
          data = CSV.read(Jbssh.servers,  { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
          hashed_data = data.map { |d| d.to_hash }

          hashed_data
        end
    end
  end
end
