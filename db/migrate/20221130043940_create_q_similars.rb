class CreateQSimilars < ActiveRecord::Migration[7.0]
  def change
    create_table :q_similars do |t|
      t.string :similar_word
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
