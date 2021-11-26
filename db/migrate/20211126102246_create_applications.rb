class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.text :cover_letter
      t.string :education
      t.string :telephone
      t.date :date_of_birth
      t.string :address

      t.timestamps
    end
  end
end
