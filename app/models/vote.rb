class Vote < ApplicationRecord
  belongs_to :contributor
  belongs_to :room
  # Validations
  validates :contributor_id, :room_id, :estimation, presence: true

  # ##########
  def status_hidden?
    status == 1
  end

  def status_revealed?
    status == 2
  end
end
