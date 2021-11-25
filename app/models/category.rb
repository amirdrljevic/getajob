class Category < ApplicationRecord
  has_many :jobs, dependent: :destroy
  validates :category_name,  presence: true, uniqueness: true
end
