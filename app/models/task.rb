class Task < ApplicationRecord
  belongs_to :user

  def completed?
    !self.completed_at.blank?
  end
end
