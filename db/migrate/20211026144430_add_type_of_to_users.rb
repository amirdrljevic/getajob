class AddTypeOfToUsers < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE user_type AS ENUM ('employer', 'applicant');
    SQL
    add_column :users, :type_of, :user_type
    add_index :users, :type_of
  end

  def down 
    remove_column :users, :type_of
    execute <<-SQL
      DROP TYPE user_type;
    SQL
  end
end
