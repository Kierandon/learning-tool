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

ActiveRecord::Schema[8.0].define(version: 2025_02_16_201256) do
  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "ordering"
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
    t.text "content"
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

  add_foreign_key "progressions", "courses"
  add_foreign_key "progressions", "steps", column: "current_step_id"
  add_foreign_key "progressions", "users"
  add_foreign_key "questions", "steps"
  add_foreign_key "steps", "courses"
  add_foreign_key "user_answers", "questions"
  add_foreign_key "user_answers", "users"
end
