class Category < ApplicationRecord
  has_many :jobs
  validates :category_name,  presence: true, uniqueness: true
end
