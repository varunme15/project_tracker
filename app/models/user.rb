class User < ActiveRecord::Base
require 'digest/md5'
attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
before_save :encrypt_password
validates :first_name,
  :presence => TRUE,
  :length => {
        :minimum => 2,
	:allow_blank => TRUE
	}

validates :last_name,
  :presence => TRUE,
  :length => {
        :minimum => 2,
	:allow_blank => TRUE
	}
validates :password,
  :presence => TRUE,
  :length => {
        :minimum => 6,
	:allow_blank => FALSE
	},
:confirmation => TRUE

validates :password_confirmation,
  :presence => TRUE

validates :email,
  :presence => TRUE,
  :uniqueness => TRUE
def encrypt_password
  self.salt = Digest::MD5.hexdigest("I have this salt #{DateTime.now}")
  self.password = Digest::MD5.hexdigest("#{self.salt} #{password}")
end

def self.validate_login(email, password)

user = User.find_by_email(email)

	if user && user.password == Digest::MD5.hexdigest("#{user.salt} #{password}")
	  user
	else
  	  nil
	end

end
end
