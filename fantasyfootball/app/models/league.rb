class League < ActiveRecord::Base
    has_many :users_leagues
    has_many :users, through: :users_leagues
    has_many :teams
end