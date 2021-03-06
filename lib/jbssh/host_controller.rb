module Jbssh
  class HostController
      class << self
        def initialize_computers_storage
          data_dir = "#{Jbssh.main_dir}/.jbssh"
          if !Dir.exists? data_dir
            Dir.mkdir data_dir
            puts "Directory created..."
          end

          if !File.exists? Jbssh.servers
            CSV.open(Jbssh.servers, "wb") do |csv|
              csv << ["name", "ip", "user"]
            end
            File.chmod(0700,Jbssh.servers)
            puts "File created..."
          end
        end

        def get_computer(name)
          table = CSV.table(Jbssh.servers)

          table.select { |row| "#{row[:name]}" == "#{name}" }
        end

        def add_computer(name, ip, user)

          if check_uniq("#{name}")
            CSV.open(Jbssh.servers, "a+") do |csv|
              # bcrypt for pass store
              csv << ["#{name}", ip, user]
            end
            puts "Computer has been added."
          else
            puts "Name is not unique."
          end

        end

        def delete(name)
          table = CSV.table(Jbssh.servers)

          table.delete_if do |row|
            "#{row[:name]}" == "#{name}"
          end

          File.open(Jbssh.servers, 'w') do |f|
            f.write(table.to_csv)
          end

          puts "#{name} has been deleted."
        end

        def get_list
          get_csv_hash
        end

        def check_uniq(name)
          get_csv_hash.each do |r|
            return false if "#{r[:name]}" == name
          end

          true
        end

        def get_csv_hash
          data = CSV.read(Jbssh.servers,  { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
          
          data.map { |d| d.to_hash }
        end
    end
  end
end
