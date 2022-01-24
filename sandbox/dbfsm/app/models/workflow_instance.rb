class WorkflowInstance < ApplicationRecord
  belongs_to :workflow

  def initialize(*)
    super
    machine
  end

  def transitions
    workflow.workflow_transitions.all.map do |t|
      h = { t.source_state.label => t.destination_state.label, on: t.label }
      h[:if] = ->() { t.source_state.send(t.guard) } if t.guard.present?
      h
    end
  end

  def machine
    instance = self
    @machine ||= Machine.new(instance, initial: workflow.initial_state.label, action: :save) do
      instance.transitions.each do |t|
        transition(t)
      end
    end
  end

  # Generic class for building machines
  class Machine
    def self.new(object, *args, &block)
      machine_class = Class.new
      machine = machine_class.state_machine(*args, &block)
      attribute = machine.attribute
      action = machine.action

      # Delegate attributes
      machine_class.class_eval do
        define_method(:definition) { machine }
        define_method(attribute) { object.send(attribute) }
        define_method("#{attribute}=") {|value| object.send("#{attribute}=", value) }
        define_method(action) { object.send(action) } if action
      end

      machine_class.new
    end
  end
end
