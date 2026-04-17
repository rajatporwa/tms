class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.references :house, null: false, foreign_key: true
      t.string :expense_type
      t.decimal :amount
      t.text :description
      t.date :expense_date

      t.timestamps
    end
  end
end
