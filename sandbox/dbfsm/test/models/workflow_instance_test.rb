require "test_helper"

class WorkflowInstanceTest < ActiveSupport::TestCase
  test 'simple state machine' do
    instance = WorkflowInstance.new(workflow_id: workflows(:simple).id)
    assert_equal 'initial', instance.state
    instance.machine.trigger
    assert_equal  'final', instance.state
    assert_equal  ['final'], WorkflowInstance.pluck(:state)
  end
end
