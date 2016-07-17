class RenamePublicColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :public, :publish
  end
end
