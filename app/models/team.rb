class Team < ApplicationRecord
  has_many :users
  has_many :tasks, through: :users
end