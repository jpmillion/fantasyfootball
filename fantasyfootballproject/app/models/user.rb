class User < ActiveRecord::Base

    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    has_many :teams, dependent: :delete_all
    has_many :leagues, through: :teams
    has_many :players, through: :teams

end