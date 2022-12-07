class AddListIdToQuizzes < ActiveRecord::Migration[7.0]
  def change
    add_reference :quizzes, :list, foreign_key: true
  end
end
