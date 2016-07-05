class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :department, index: true, foreign_key: true
      t.belongs_to :position, index: true, foreign_key: true
      t.boolean :fired
      t.boolean :hr_manager
      t.float :salary

      t.timestamps null: false
    end
  end
end
