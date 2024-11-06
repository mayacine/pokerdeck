class Vote < ApplicationRecord
  belongs_to :contributor
  belongs_to :room
  # Validations
  validates :contributor_id, :room_id, :estimation, presence: true
  # ##########
end
