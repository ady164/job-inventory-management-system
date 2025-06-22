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

ActiveRecord::Schema[8.0].define(version: 2025_06_22_142732) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipments", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.string "brand"
    t.string "model"
    t.string "serial_number"
    t.string "equipment_type"
    t.date "purchase_date"
    t.string "remarks"
    t.date "last_calibration_date"
    t.integer "calibration_frequency_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.string "product_number"
    t.text "description"
    t.string "category"
    t.integer "quantity"
    t.integer "alert_quantity"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand"
    t.string "image_path"
    t.decimal "unit_cost"
  end

  create_table "inventory_logs", force: :cascade do |t|
    t.bigint "inventory_id", null: false
    t.bigint "user_id", null: false
    t.integer "quantity"
    t.string "status"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "operation_type"
    t.bigint "job_id"
    t.index ["inventory_id"], name: "index_inventory_logs_on_inventory_id"
    t.index ["job_id"], name: "index_inventory_logs_on_job_id"
    t.index ["user_id"], name: "index_inventory_logs_on_user_id"
  end

  create_table "job_measurement_references", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.json "diameter"
    t.json "length"
    t.json "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_measurement_references_on_job_id"
  end

  create_table "job_process_logs", force: :cascade do |t|
    t.bigint "job_process_id", null: false
    t.bigint "user_id", null: false
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.json "measurement_data"
    t.json "process_parameter"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_index"
    t.index ["job_process_id"], name: "index_job_process_logs_on_job_process_id"
    t.index ["user_id"], name: "index_job_process_logs_on_user_id"
  end

  create_table "job_process_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sequence_index"
  end

  create_table "job_processes", force: :cascade do |t|
    t.bigint "job_process_type_id", null: false
    t.bigint "job_id", null: false
    t.integer "order_index"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "equipment_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.json "measurements"
    t.bigint "user_id"
    t.index ["equipment_id"], name: "index_job_processes_on_equipment_id"
    t.index ["job_id"], name: "index_job_processes_on_job_id"
    t.index ["job_process_type_id"], name: "index_job_processes_on_job_process_type_id"
    t.index ["user_id"], name: "index_job_processes_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "job_reference_number"
    t.string "vessle_name"
    t.date "required_date"
    t.string "part_type"
    t.string "part_model"
    t.string "base_material"
    t.string "notes"
    t.string "status"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "part_name"
    t.string "filler_material"
    t.index ["customer_id"], name: "index_jobs_on_customer_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_logs", force: :cascade do |t|
    t.string "login_email"
    t.bigint "user_id"
    t.boolean "success"
    t.string "message"
    t.datetime "attempted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.string "pin_hash"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "man_hour_rate"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "inventory_logs", "inventories"
  add_foreign_key "inventory_logs", "jobs"
  add_foreign_key "inventory_logs", "users"
  add_foreign_key "job_measurement_references", "jobs"
  add_foreign_key "job_process_logs", "job_processes"
  add_foreign_key "job_process_logs", "users"
  add_foreign_key "job_processes", "equipments"
  add_foreign_key "job_processes", "job_process_types"
  add_foreign_key "job_processes", "jobs"
  add_foreign_key "job_processes", "users"
  add_foreign_key "jobs", "customers"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "user_logs", "users"
  add_foreign_key "users", "roles"
end
