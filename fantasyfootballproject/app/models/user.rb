class User < ActiveRecord::Base

    has_secure_password
    has_many :user_leagues
    has_many :teams, dependent: :destroy
    has_many :leagues, through: :teams
    has_many :players, through: :teams

end