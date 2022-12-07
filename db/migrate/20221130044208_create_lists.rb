class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.references :quiz, null: false, foreign_key: true
      t.integer :answer_number
      t.boolean :is_answer
      t.integer :right_answer
      t.integer :question_number
      t.integer :quiz_answer

      t.timestamps
    end
  end
end
