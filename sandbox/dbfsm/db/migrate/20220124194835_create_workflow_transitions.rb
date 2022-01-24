class CreateWorkflowTransitions < ActiveRecord::Migration[7.0]
  def change
    create_table :workflow_transitions do |t|
      t.belongs_to :workflow

      t.string :label
      t.string :guard

      t.references :source_state, foreign_key: { to_table: :workflow_states }, null: false
      t.references :destination_state, foreign_key: { to_table: :workflow_states }, null: false

      t.timestamps
    end
  end
end
