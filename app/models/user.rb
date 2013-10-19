class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  has_many :projects
  
  def self.new_guest
    new do |u| 
      u.guest = true
      u.email = 'guest@example.com'
      u.encrypted_password = 'pwd'
    end
  end

  def email
    guest ? "Guest" : email
  end
end
