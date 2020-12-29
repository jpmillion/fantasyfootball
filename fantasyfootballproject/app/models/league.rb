class League < ActiveRecord::Base
    has_many :teams, dependent: :destroy
    has_many :users, through: :teams
    has_many :players, through: :teams
end