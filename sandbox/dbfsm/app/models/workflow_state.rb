class WorkflowState < ApplicationRecord
  belongs_to :workflow
  belongs_to :details, polymorphic: true
end
