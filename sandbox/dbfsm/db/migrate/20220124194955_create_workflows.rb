class CreateWorkflows < ActiveRecord::Migration[7.0]
  def change
    create_table :workflows do |t|
      t.references :initial_state, foreign_key: { to_table: :workflow_states}, null: false

      t.timestamps
    end
  end
end
