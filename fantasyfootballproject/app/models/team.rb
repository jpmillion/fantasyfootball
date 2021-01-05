class Team < ActiveRecord::Base

    belongs_to :user 
    belongs_to :league
    has_many :players, dependent: :destroy_all
    validates :name, presence: true
end