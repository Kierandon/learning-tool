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

ActiveRecord::Schema[8.0].define(version: 2025_02_18_225246) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "ordering"
  end

  create_table "matching_pairs", force: :cascade do |t|
    t.integer "matching_question_id", null: false
    t.text "term"
    t.text "definition"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matching_question_id"], name: "index_matching_pairs_on_matching_question_id"
  end

  create_table "matching_questions", force: :cascade do |t|
    t.text "success_message"
    t.text "failure_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progressions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.integer "current_step_id"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_progressions_on_course_id"
    t.index ["current_step_id"], name: "index_progressions_on_current_step_id"
    t.index ["user_id", "course_id"], name: "index_progressions_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_progressions_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "step_id", null: false
    t.text "prompt"
    t.integer "position"
    t.string "questionable_type", null: false
    t.integer "questionable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionable_type", "questionable_id"], name: "index_questions_on_questionable"
    t.index ["questionable_type", "questionable_id"], name: "index_questions_on_questionable_type_and_questionable_id"
    t.index ["step_id"], name: "index_questions_on_step_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "course_id", null: false
    t.string "title"
    t.string "step_type"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_steps_on_course_id"
  end

  create_table "true_false_questions", force: :cascade do |t|
    t.boolean "correct_answer", null: false
    t.text "success_message"
    t.text "failure_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.text "answer_data"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_user_answers_on_question_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login_hash", null: false
    t.string "type", default: "User", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login_hash"], name: "index_users_on_login_hash", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "matching_pairs", "matching_questions"
  add_foreign_key "progressions", "courses"
  add_foreign_key "progressions", "steps", column: "current_step_id"
  add_foreign_key "progressions", "users"
  add_foreign_key "questions", "steps"
  add_foreign_key "steps", "courses"
  add_foreign_key "user_answers", "questions"
  add_foreign_key "user_answers", "users"
end
