class AddNumToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :num, :integer
  end
end
