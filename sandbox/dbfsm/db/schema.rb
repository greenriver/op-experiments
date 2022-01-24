# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_24_195041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "workflow_instances", force: :cascade do |t|
    t.bigint "workflow_id", null: false
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workflow_id"], name: "index_workflow_instances_on_workflow_id"
  end

  create_table "workflow_states", force: :cascade do |t|
    t.string "label"
    t.bigint "workflow_id"
    t.string "details_type"
    t.bigint "details_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["details_type", "details_id"], name: "index_workflow_states_on_details"
    t.index ["label", "workflow_id"], name: "index_workflow_states_on_label_and_workflow_id", unique: true
    t.index ["workflow_id"], name: "index_workflow_states_on_workflow_id"
  end

  create_table "workflow_transitions", force: :cascade do |t|
    t.bigint "workflow_id"
    t.string "label"
    t.string "guard"
    t.bigint "source_state_id", null: false
    t.bigint "destination_state_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_state_id"], name: "index_workflow_transitions_on_destination_state_id"
    t.index ["source_state_id"], name: "index_workflow_transitions_on_source_state_id"
    t.index ["workflow_id"], name: "index_workflow_transitions_on_workflow_id"
  end

  create_table "workflows", force: :cascade do |t|
    t.bigint "initial_state_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["initial_state_id"], name: "index_workflows_on_initial_state_id"
  end

  add_foreign_key "workflow_transitions", "workflow_states", column: "destination_state_id"
  add_foreign_key "workflow_transitions", "workflow_states", column: "source_state_id"
  add_foreign_key "workflows", "workflow_states", column: "initial_state_id"
end
