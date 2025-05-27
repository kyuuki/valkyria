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

ActiveRecord::Schema[7.0].define(version: 2025_05_27_100716) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "postmeta", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "meta_key"
    t.string "meta_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_postmeta_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "posted_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ulid"
  end

  create_table "posts_sites", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "site_id", null: false
    t.index ["post_id", "site_id"], name: "index_posts_sites_on_post_id_and_site_id"
    t.index ["site_id", "post_id"], name: "index_posts_sites_on_site_id_and_post_id"
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
    t.index ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id"
    t.index ["tag_id", "post_id"], name: "index_posts_tags_on_tag_id_and_post_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "host"
    t.string "name"
    t.string "template"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "catch"
    t.text "about"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "postmeta", "posts"
end
