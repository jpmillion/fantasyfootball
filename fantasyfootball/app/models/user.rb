class User < ActiveRecord::Base

    has_secure_password
    has_many :leagues, through: :users_leagues
    has_many :teams, through: :leagues
    has_many :players, through: :teams

end