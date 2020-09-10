class AddIsAnswerToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :is_answer, :boolean, default: false
  end
end
