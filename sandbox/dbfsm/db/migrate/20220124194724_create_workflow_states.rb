class CreateWorkflowStates < ActiveRecord::Migration[7.0]
  def change
    create_table :workflow_states do |t|
      t.string :label
      t.belongs_to :workflow
      t.references :details, polymorphic: true

      t.index [:label, :workflow_id], unique: true
      t.timestamps
    end
  end
end
