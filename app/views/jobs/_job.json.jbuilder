json.extract! job, :id, :title, :description, :category_id, :user_id, :valid_until, :created_at, :updated_at
json.url job_url(job, format: :json)
