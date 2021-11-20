class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.references :category, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :valid_until

      t.timestamps
    end
  end
end
