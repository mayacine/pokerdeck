class Room < ApplicationRecord
  # associations
  has_many :votes
  has_many :contributors

  def status_created?
    status == 1
  end

  def status_estimation_stated?
    status == 2
  end

  def status_human
    { 
      '0' => "Cree",
      '1' => "Estimation en cours",
      '2' => "Fermee"
    }[status.to_s]
  end

  def status_closed?
    status == 3
  end
end
