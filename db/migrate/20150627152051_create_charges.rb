class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :amount
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
