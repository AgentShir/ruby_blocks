class DatabaseDriver
    def initialize(database, user, password)
      @database = database
      @user = user
      @password = password
      @connected = false
    end
  
    def self.open(database, user, password)
      driver = self.new(database, user, password)
      driver.connect
  
      return driver unless block_given?
  
      begin
        yield(driver)
      ensure
        driver.disconnect
      end
    end
  
    def connect
      # connects to database
      @connected = true
      puts "Connected to #{@database} as #{@user}."
    end
  
    def disconnect
      # disconnects from database
      puts "Disconnected."
    end
  
    def execute(sql)
      raise "Not connected!" unless @connected
      puts "Executing #{sql}..."
    end
  end
  
  # db = DatabaseDriver.new("my_database", "admin", "secret")
  # db.connect
  # db.execute("SELECT * FROM ORDERS")
  # db.execute("SELECT * FROM USERS")
  # db.disconnect
  
  DatabaseDriver.open("my_database", "admin", "secret") do |db|
    db.execute("SELECT * FROM ORDERS")
    db.execute("SELECT * FROM USERS")
  end
  
  driver = DatabaseDriver.open("my_database", "admin", "secret")
  driver.execute("SELECT * FROM ORDERS")
  driver.execute("SELECT * FROM USERS")
  driver.disconnect
  
  begin
    DatabaseDriver.open("my_database", "admin", "secret") do |driver|
      driver.execute("DELETE * FROM ORDERS")
      raise "Boom!"
      driver.execute("DELETE * FROM USERS")
    end
  rescue Exception => e
    puts e.message
  end
  
  
  