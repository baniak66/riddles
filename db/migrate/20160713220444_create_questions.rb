class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.integer :time
      t.text :comment
      t.boolean :public
      t.boolean :other_answer

      t.timestamps
    end
  end
end
