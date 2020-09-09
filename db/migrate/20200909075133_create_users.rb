class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email
      t.integer :total_score, default: 0
      t.integer :done_quiz_count, default: 0

      t.timestamps
    end
  end
end
