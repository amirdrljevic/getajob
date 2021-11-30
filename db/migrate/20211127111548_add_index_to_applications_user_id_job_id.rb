class AddIndexToApplicationsUserIdJobId < ActiveRecord::Migration[6.1]
  def change
    add_index :applications, [:user_id, :job_id], unique: true 
  end
end
