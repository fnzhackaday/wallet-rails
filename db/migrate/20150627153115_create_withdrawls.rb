class CreateWithdrawls < ActiveRecord::Migration
  def change
    create_table :withdrawls do |t|
      t.integer :amount
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
