class RemoveContentFromSteps < ActiveRecord::Migration[8.0]
  def change
    remove_column :steps, :content, :text
  end
end
