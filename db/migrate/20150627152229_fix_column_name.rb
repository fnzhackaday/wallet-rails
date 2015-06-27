class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :transactions, :recipient_email, :recipient_id
  end
end
