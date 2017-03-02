require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  host:     'localhost',
  database: 'your_database',
  username: 'your_username',
  password: 'your_password'
)


class SomeClass < ActiveRecord::Base
  def self.hi
    print "hi"
  end
end

# puts SomeClass.find :all
# some_class = SomeClass.new
