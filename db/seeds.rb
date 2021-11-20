# Generate unique job categories
20.times do 
  Category.create(
    category_name: Faker::Job.unique.field
  )
end