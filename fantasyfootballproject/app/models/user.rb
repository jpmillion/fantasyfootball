class User < ActiveRecord::Base

    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    has_many :teams, dependent: :destroy
    has_many :leagues, through: :teams
    has_many :players, through: :teams

    after_update do |user|
        puts "You have successfully updated your acount"
    end

    after_save do |user|
        puts "You have successfully saved your account"
    end

end