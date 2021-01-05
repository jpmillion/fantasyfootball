class Team < ActiveRecord::Base

    belongs_to :user 
    belongs_to :league
    has_many :players, dependent: :delete_all
    validates :name, presence: true
end