class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.integer :score
      t.references :user, null: false, foreign_key: true
      t.boolean :is_propose

      t.timestamps
    end
  end
end
