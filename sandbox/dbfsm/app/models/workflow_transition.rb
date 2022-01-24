class WorkflowTransition < ApplicationRecord
  belongs_to :workflow

  belongs_to :source_state, class_name: 'WorkflowState'
  belongs_to :destination_state, class_name: 'WorkflowState'
end
