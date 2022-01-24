class Workflow < ApplicationRecord
  has_many :workflow_states, class_name: 'WorkflowState'
  has_many :workflow_transitions, class_name: 'WorkflowTransition'

  belongs_to :initial_state, class_name: 'WorkflowState'
end
