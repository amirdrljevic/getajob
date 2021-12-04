class Job < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :applications, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :valid_until, presence: true

  #Check if the job post is valid
  def expired?
    DateTime.now.to_date <= self.valid_until
  end  
end
