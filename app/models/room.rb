class Room < ApplicationRecord
  # associations
  has_many :votes, dependent: :destroy
  has_many :contributors, dependent: :destroy

  def status_created?
    status == 1
  end

  def status_estimation_stated?
    status == 2
  end

  def status_human
    {
      "0" => "Cree",
      "1" => "Estimation en cours",
      "2" => "Fermee"
    }[status.to_s]
  end

  def status_closed?
    status == 3
  end

  def moderator_name
    Moderator.find_by(current_room_uuid: uuid)&.name || "NO_NAME"
  end

  def empty_moderator_name
    Moderator.find_by(current_room_uuid: uuid)&.update(current_room_uuid: nil)
  end
end
