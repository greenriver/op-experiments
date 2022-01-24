class CreateWorkflowInstances < ActiveRecord::Migration[7.0]
  def change
    create_table :workflow_instances do |t|
      t.references :workflow, null: false
      t.string :state

      t.timestamps
    end
  end
end
