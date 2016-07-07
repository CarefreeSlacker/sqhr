class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :type
      t.belongs_to :user, index: true, foreign_key: true
      t.string :old_value
      t.string :new_value
      t.string :attribute_name
      t.date :date

      t.timestamps null: false
    end
  end
end
