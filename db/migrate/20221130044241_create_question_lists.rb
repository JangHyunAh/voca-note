class CreateQuestionLists < ActiveRecord::Migration[7.0]
  def change
    create_table :question_lists do |t|
      t.references :question, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
