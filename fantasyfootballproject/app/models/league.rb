class League < ActiveRecord::Base
    has_many :user_leagues
    has_many :users, through: :user_leagues
    has_many :teams
end