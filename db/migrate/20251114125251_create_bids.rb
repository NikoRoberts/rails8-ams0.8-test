class CreateBids < ActiveRecord::Migration[8.1]
  def change
    create_table :bids do |t|
      t.decimal :amount
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
