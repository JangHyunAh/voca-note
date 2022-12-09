class RemoveListsFromQuizzes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :quizzes, :list, null: false, foreign_key: true
  end
end
