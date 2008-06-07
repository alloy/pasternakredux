require 'digest/sha1'

class User < ActiveRecord::Base
  before_save :digest_password
  
  class << self
    def digest_password(password)
      Digest::SHA1.hexdigest(password)
    end
    
    def authenticate(username, password)
      find :first, :conditions => { :username => username, :password => digest_password(password) }
    end
  end
  
  private
  
  def digest_password
    write_attribute :password, self.class.digest_password(password)
  end
end
