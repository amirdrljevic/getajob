class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job
  validates :job_id, uniqueness: { scope: :user_id, message: "User has already applied to this job." }
end
