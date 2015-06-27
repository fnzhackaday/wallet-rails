class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :recipient_email
      t.integer :amount

      t.timestamps null: false
    end
  end
end
