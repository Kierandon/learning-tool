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

ActiveRecord::Schema[8.0].define(version: 2025_03_10_150521) do
  create_table "achievements", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "achievement_type", null: false
    t.integer "threshold"
    t.string "icon_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_type"], name: "index_achievements_on_achievement_type"
  end

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

  create_table "badges", force: :cascade do |t|
    t.integer "course_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_badges_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "ordering"
    t.integer "standard_id"
    t.index ["standard_id"], name: "index_courses_on_standard_id"
  end

  create_table "daily_quests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "quest_type"
    t.integer "target_count"
    t.integer "current_count"
    t.integer "reward_points"
    t.boolean "completed"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_quests_on_user_id"
  end

  create_table "learning_objective_associated_sections", force: :cascade do |t|
    t.integer "learning_objective_id", null: false
    t.integer "standard_section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_objective_id"], name: "idx_on_learning_objective_id_ee27f52397"
    t.index ["standard_section_id"], name: "idx_on_standard_section_id_8b38238b9a"
  end

  create_table "learning_objective_steps", force: :cascade do |t|
    t.integer "learning_objective_id", null: false
    t.integer "step_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_objective_id"], name: "index_learning_objective_steps_on_learning_objective_id"
    t.index ["step_id"], name: "index_learning_objective_steps_on_step_id"
  end

  create_table "learning_objectives", force: :cascade do |t|
    t.integer "standard_section_id", null: false
    t.string "objective_id", null: false
    t.string "description", null: false
    t.string "completion_criteria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["standard_section_id"], name: "index_learning_objectives_on_standard_section_id"
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
    t.string "matching_style", default: "dropdown"
  end

  create_table "motor_alert_locks", force: :cascade do |t|
    t.integer "alert_id", null: false
    t.string "lock_timestamp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id", "lock_timestamp"], name: "index_motor_alert_locks_on_alert_id_and_lock_timestamp", unique: true
    t.index ["alert_id"], name: "index_motor_alert_locks_on_alert_id"
  end

  create_table "motor_alerts", force: :cascade do |t|
    t.integer "query_id", null: false
    t.string "name", null: false
    t.text "description"
    t.text "to_emails", null: false
    t.boolean "is_enabled", default: true, null: false
    t.text "preferences", null: false
    t.bigint "author_id"
    t.string "author_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "motor_alerts_name_unique_index", unique: true, where: "deleted_at IS NULL"
    t.index ["query_id"], name: "index_motor_alerts_on_query_id"
    t.index ["updated_at"], name: "index_motor_alerts_on_updated_at"
  end

  create_table "motor_api_configs", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.text "preferences", null: false
    t.text "credentials", null: false
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "motor_api_configs_name_unique_index", unique: true, where: "deleted_at IS NULL"
  end

  create_table "motor_audits", force: :cascade do |t|
    t.string "auditable_id"
    t.string "auditable_type"
    t.string "associated_id"
    t.string "associated_type"
    t.bigint "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.bigint "version", default: 0
    t.text "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "motor_auditable_associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "motor_auditable_index"
    t.index ["created_at"], name: "index_motor_audits_on_created_at"
    t.index ["request_uuid"], name: "index_motor_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "motor_auditable_user_index"
  end

  create_table "motor_configs", force: :cascade do |t|
    t.string "key", null: false
    t.text "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_motor_configs_on_key", unique: true
    t.index ["updated_at"], name: "index_motor_configs_on_updated_at"
  end

  create_table "motor_dashboards", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.text "preferences", null: false
    t.bigint "author_id"
    t.string "author_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "motor_dashboards_title_unique_index", unique: true, where: "deleted_at IS NULL"
    t.index ["updated_at"], name: "index_motor_dashboards_on_updated_at"
  end

  create_table "motor_forms", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "api_path", null: false
    t.string "http_method", null: false
    t.text "preferences", null: false
    t.bigint "author_id"
    t.string "author_type"
    t.datetime "deleted_at"
    t.string "api_config_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "motor_forms_name_unique_index", unique: true, where: "deleted_at IS NULL"
    t.index ["updated_at"], name: "index_motor_forms_on_updated_at"
  end

  create_table "motor_note_tag_tags", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "note_id", null: false
    t.index ["note_id", "tag_id"], name: "motor_note_tags_note_id_tag_id_index", unique: true
    t.index ["tag_id"], name: "index_motor_note_tag_tags_on_tag_id"
  end

  create_table "motor_note_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "motor_note_tags_name_unique_index", unique: true
  end

  create_table "motor_notes", force: :cascade do |t|
    t.text "body"
    t.bigint "author_id"
    t.string "author_type"
    t.string "record_id", null: false
    t.string "record_type", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "author_type"], name: "motor_notes_author_id_author_type_index"
    t.index ["record_id", "record_type"], name: "motor_notes_record_id_record_type_index"
  end

  create_table "motor_notifications", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "recipient_id", null: false
    t.string "recipient_type", null: false
    t.string "record_id"
    t.string "record_type"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id", "recipient_type"], name: "motor_notifications_recipient_id_recipient_type_index"
    t.index ["record_id", "record_type"], name: "motor_notifications_record_id_record_type_index"
  end

  create_table "motor_queries", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "sql_body", null: false
    t.text "preferences", null: false
    t.bigint "author_id"
    t.string "author_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "motor_queries_name_unique_index", unique: true, where: "deleted_at IS NULL"
    t.index ["updated_at"], name: "index_motor_queries_on_updated_at"
  end

  create_table "motor_reminders", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "author_type", null: false
    t.bigint "recipient_id", null: false
    t.string "recipient_type", null: false
    t.string "record_id"
    t.string "record_type"
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "author_type"], name: "motor_reminders_author_id_author_type_index"
    t.index ["recipient_id", "recipient_type"], name: "motor_reminders_recipient_id_recipient_type_index"
    t.index ["record_id", "record_type"], name: "motor_reminders_record_id_record_type_index"
    t.index ["scheduled_at"], name: "index_motor_reminders_on_scheduled_at"
  end

  create_table "motor_resources", force: :cascade do |t|
    t.string "name", null: false
    t.text "preferences", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_motor_resources_on_name", unique: true
    t.index ["updated_at"], name: "index_motor_resources_on_updated_at"
  end

  create_table "motor_taggable_tags", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.bigint "taggable_id", null: false
    t.string "taggable_type", null: false
    t.index ["tag_id"], name: "index_motor_taggable_tags_on_tag_id"
    t.index ["taggable_id", "taggable_type", "tag_id"], name: "motor_polymorphic_association_tag_index", unique: true
  end

  create_table "motor_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "motor_tags_name_unique_index", unique: true
  end

  create_table "multiple_choice_options", force: :cascade do |t|
    t.integer "multiple_choice_question_id", null: false
    t.string "text", null: false
    t.boolean "correct", default: false, null: false
    t.text "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiple_choice_question_id"], name: "index_multiple_choice_options_on_multiple_choice_question_id"
  end

  create_table "multiple_choice_questions", force: :cascade do |t|
    t.boolean "allow_multiple_answers", default: false, null: false
    t.string "success_message"
    t.string "failure_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ordering_items", force: :cascade do |t|
    t.integer "ordering_question_id", null: false
    t.text "content", null: false
    t.integer "correct_position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ordering_question_id"], name: "index_ordering_items_on_ordering_question_id"
  end

  create_table "ordering_questions", force: :cascade do |t|
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

  create_table "standard_certificates", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "standard_id", null: false
    t.date "issue_date", null: false
    t.string "certificate_number", null: false
    t.string "competency_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["standard_id"], name: "index_standard_certificates_on_standard_id"
    t.index ["user_id", "standard_id"], name: "index_standard_certificates_on_user_id_and_standard_id", unique: true
    t.index ["user_id"], name: "index_standard_certificates_on_user_id"
  end

  create_table "standard_sections", force: :cascade do |t|
    t.integer "standard_id", null: false
    t.integer "parent_section_id"
    t.string "name", null: false
    t.string "section_id", null: false
    t.string "url"
    t.date "published_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_section_id"], name: "index_standard_sections_on_parent_section_id"
    t.index ["standard_id", "section_id"], name: "index_standard_sections_on_standard_id_and_section_id", unique: true
    t.index ["standard_id"], name: "index_standard_sections_on_standard_id"
  end

  create_table "standards", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visibility", default: true, null: false
    t.index ["code"], name: "index_standards_on_code", unique: true
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

  create_table "user_achievements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "achievement_id", null: false
    t.datetime "awarded_at", null: false
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id", "achievement_id"], name: "index_user_achievements_on_user_id_and_achievement_id", unique: true
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.text "answer_data"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "progression_id"
    t.index ["progression_id"], name: "index_user_answers_on_progression_id"
    t.index ["question_id"], name: "index_user_answers_on_question_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_badges", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "badge_id", null: false
    t.datetime "awarded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id", "badge_id"], name: "index_user_badges_on_user_id_and_badge_id", unique: true
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login_hash", null: false
    t.string "type", default: "User", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points", default: 0
    t.integer "current_streak", default: 0
    t.date "last_answer_date"
    t.integer "highest_streak", default: 0
    t.index ["login_hash"], name: "index_users_on_login_hash", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "badges", "courses"
  add_foreign_key "courses", "standards"
  add_foreign_key "daily_quests", "users"
  add_foreign_key "learning_objective_associated_sections", "learning_objectives"
  add_foreign_key "learning_objective_associated_sections", "standard_sections"
  add_foreign_key "learning_objective_steps", "learning_objectives"
  add_foreign_key "learning_objective_steps", "steps"
  add_foreign_key "learning_objectives", "standard_sections"
  add_foreign_key "matching_pairs", "matching_questions"
  add_foreign_key "motor_alert_locks", "motor_alerts", column: "alert_id"
  add_foreign_key "motor_alerts", "motor_queries", column: "query_id"
  add_foreign_key "motor_note_tag_tags", "motor_note_tags", column: "tag_id"
  add_foreign_key "motor_note_tag_tags", "motor_notes", column: "note_id"
  add_foreign_key "motor_taggable_tags", "motor_tags", column: "tag_id"
  add_foreign_key "multiple_choice_options", "multiple_choice_questions"
  add_foreign_key "ordering_items", "ordering_questions"
  add_foreign_key "progressions", "courses"
  add_foreign_key "progressions", "steps", column: "current_step_id"
  add_foreign_key "progressions", "users"
  add_foreign_key "questions", "steps"
  add_foreign_key "standard_certificates", "standards"
  add_foreign_key "standard_certificates", "users"
  add_foreign_key "standard_sections", "standard_sections", column: "parent_section_id"
  add_foreign_key "standard_sections", "standards"
  add_foreign_key "steps", "courses"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "user_answers", "progressions"
  add_foreign_key "user_answers", "questions"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
end
