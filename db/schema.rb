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

ActiveRecord::Schema[8.0].define(version: 2025_02_08_210100) do
  create_table "choices", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "content"
    t.boolean "is_correct"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "ordering"
  end

  create_table "matchings", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "item_type"
    t.string "content"
    t.integer "pair_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_matchings_on_question_id"
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
    t.string "question_type"
    t.text "question_text"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "user_answer_choices", force: :cascade do |t|
    t.integer "user_answer_id", null: false
    t.integer "choice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_user_answer_choices_on_choice_id"
    t.index ["user_answer_id"], name: "index_user_answer_choices_on_user_answer_id"
  end

  create_table "user_answer_matchings", force: :cascade do |t|
    t.integer "user_answer_id", null: false
    t.integer "matching_id", null: false
    t.integer "matched_with_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matching_id"], name: "index_user_answer_matchings_on_matching_id"
    t.index ["user_answer_id"], name: "index_user_answer_matchings_on_user_answer_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.boolean "is_correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_user_answers_on_question_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "font_size"
    t.string "colour_scheme"
    t.boolean "high_contrast"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login_hash", null: false
    t.string "type", default: "User", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login_hash"], name: "index_users_on_login_hash", unique: true
  end

  add_foreign_key "choices", "questions"
  add_foreign_key "matchings", "questions"
  add_foreign_key "progressions", "courses"
  add_foreign_key "progressions", "steps", column: "current_step_id"
  add_foreign_key "progressions", "users"
  add_foreign_key "questions", "steps"
  add_foreign_key "steps", "courses"
  add_foreign_key "user_answer_choices", "choices"
  add_foreign_key "user_answer_choices", "user_answers"
  add_foreign_key "user_answer_matchings", "matchings"
  add_foreign_key "user_answer_matchings", "user_answers"
  add_foreign_key "user_answers", "questions"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_preferences", "users"
end
