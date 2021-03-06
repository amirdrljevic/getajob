class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum type_of: { employer: "employer", applicant: "applicant" }
  has_many :jobs, dependent: :destroy
  has_many :applications, dependent: :destroy

end
