module Jbssh
  class RemoteComputer
    class << self
      def initialize_computers_db
        `mkdir db`
        db = SQLite3::Database.new "db/jbssh.db"
        db.execute <<-SQL
          create table computers (
            id int,
            name varchar(50),
            ip varchar(50),
            user varchar(50),
            password varchar(50)
          );
        SQL
      end

# ----------------------------------------------
# INDEX
      def get_all_computers
        hash = {}
        db = SQLite3::Database.new "db/jbssh.db"
        db.execute( "select * from computers" ) do |row|
          # Name      = {id, ip, user, password}
          hash[row[1]] = { id: row[0], ip: row[2], user: row[3], password: row[4] }
        end

        hash
      end

# ----------------------------------------------
# SHOW
      def get_computer(name)
        db = SQLite3::Database.new "db/jbssh.db"
        get_all_computers[name]
      end

# ----------------------------------------------
# CREATE/NEW
      def add_computer(name, ip, user, password)
        if !File.exists? 'db/jbssh.db'
          initialize_computers_db
        end
        db = SQLite3::Database.new "db/jbssh.db"
        count = get_all_computers.count + 1
        db.execute("INSERT INTO computers (id,name,ip,user,password)
                    VALUES (?, ?, ?, ?, ?)", [count, name, ip, user, password])

        puts "Computer #{name} has been created."
      end

# ----------------------------------------------
# UPDATE
      def update_computer(name,field, new_value)
        db = SQLite3::Database.new "db/jbssh.db"
        db.execute("UPDATE computers SET #{field}=\'#{new_value}\' WHERE name=\'#{name}\';")
        puts "Computer #{name} has been updated."
      end

# ----------------------------------------------
# DELETE
      def delete_all_rows
        db = SQLite3::Database.new "db/jbssh.db"
        db.execute("DELETE FROM computers;")
        puts "All Computers #{name} have been deleted."
      end

      def delete_computer(name)
        db = SQLite3::Database.new "db/jbssh.db"
        db.execute("DELETE FROM computers WHERE name=\'#{name}\';")
        puts "Computer #{name} has been deleted."
      end

    end
  end
end
