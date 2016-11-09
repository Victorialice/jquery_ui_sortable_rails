# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130408071612) do

  create_table "administrators", :force => true do |t|
    t.string   "name"
    t.string   "salted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrators", ["name"], :name => "index_administrators_on_name"

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.string   "encrypt_pwd"
    t.string   "salt"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campaign_award_users", :force => true do |t|
    t.integer  "campaign_id",   :null => false
    t.string   "username"
    t.string   "telphone"
    t.string   "mark_telphone"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "campaign_award_users", ["campaign_id"], :name => "index_campaign_award_users_on_campaign_id"

  create_table "campaign_records", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "campaign_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "postcode"
    t.string   "address2"
    t.string   "telphone"
    t.string   "name"
  end

  add_index "campaign_records", ["campaign_id", "user_id"], :name => "index_campaign_records_on_campaign_id_and_user_id"
  add_index "campaign_records", ["user_id", "campaign_id"], :name => "index_campaign_records_on_user_id_and_campaign_id"

  create_table "campaigns", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.date     "begin_date"
    t.date     "over_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "link"
  end

  create_table "caplico_datas", :force => true do |t|
    t.string "category"
    t.string "data"
  end

  create_table "caplicos", :force => true do |t|
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "job"
    t.string   "family"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "questionnaire7"
    t.string   "questionnaire8"
    t.string   "questionnaire9"
    t.string   "questionnaire10"
    t.string   "questionnaire11"
    t.string   "remarks"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.boolean  "is_public"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_notes", :id => false, :force => true do |t|
    t.string "note_id"
    t.string "category_id"
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :limit => 30,                   :null => false
    t.integer  "pref_id",                                    :null => false
    t.boolean  "is_public",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["pref_id"], :name => "index_cities_on_pref_id"

  create_table "districts", :force => true do |t|
    t.string   "name",       :limit => 30,                :null => false
    t.integer  "city_id",                                 :null => false
    t.integer  "is_public",                :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["city_id"], :name => "index_districts_on_city_id"
  add_index "districts", ["is_public"], :name => "index_districts_on_is_public"
  add_index "districts", ["name"], :name => "index_districts_on_name"

  create_table "divisions", :force => true do |t|
    t.integer  "division1id"
    t.string   "division1name"
    t.integer  "division2id"
    t.string   "division2name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "double_pletz_datas", :force => true do |t|
    t.string "category"
    t.string "data"
  end

  create_table "double_pletzs", :force => true do |t|
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "questionnaire7"
    t.string   "questionnaire8"
    t.string   "questionnaire9"
    t.string   "questionnaire10"
    t.string   "remarks"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "email_user_masters", :force => true do |t|
    t.string   "email"
    t.string   "user_name"
    t.boolean  "sex"
    t.datetime "birthday"
    t.string   "zip_code"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "phone_number"
    t.string   "cell_number"
    t.string   "fax_number"
    t.string   "language"
    t.string   "keyword"
    t.string   "remarks"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "subject"
    t.string   "sender"
    t.text     "body"
    t.text     "remarks"
    t.datetime "sent_at"
    t.datetime "deleted_at"
    t.datetime "send_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "send_on"
    t.integer  "status"
    t.text     "select_user_ids", :limit => 2147483647
  end

  create_table "kissful_dates", :force => true do |t|
    t.string   "category"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kissfuls", :force => true do |t|
    t.string   "from"
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "questionnaire7"
    t.string   "questionnaire8"
    t.string   "questionnaire9"
    t.string   "questionnaire10"
    t.string   "questionnaire11"
    t.string   "questionnaire12"
    t.string   "remarks"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "kittycps", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "pref"
    t.string   "city"
    t.string   "district"
    t.string   "postal"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "question1"
    t.string   "question2"
    t.string   "f"
    t.string   "ip"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecui_dates", :force => true do |t|
    t.string   "category"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecuis", :force => true do |t|
    t.string   "from"
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "questionnaire7"
    t.string   "questionnaire8"
    t.string   "questionnaire9"
    t.string   "questionnaire10"
    t.string   "questionnaire11"
    t.string   "questionnaire12"
    t.string   "remarks"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "login_logs", :force => true do |t|
    t.string   "ip"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "minikits", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "nickname"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "pref"
    t.string   "city"
    t.string   "district"
    t.string   "postal"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "question1"
    t.string   "question2"
    t.string   "f"
    t.string   "ip"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mousa_datas", :force => true do |t|
    t.string "category"
    t.string "data"
  end

  create_table "mousas", :force => true do |t|
    t.string   "from"
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "job"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mp_dates", :force => true do |t|
    t.string "category"
    t.string "data"
  end

  create_table "mps", :force => true do |t|
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "questionnaire7"
    t.string   "questionnaire8"
    t.string   "questionnaire9"
    t.string   "questionnaire10"
    t.string   "questionnaire11"
    t.string   "remarks"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "news", :force => true do |t|
    t.date     "date"
    t.string   "category"
    t.string   "title"
    t.text     "message"
    t.string   "link"
    t.boolean  "is_public",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "message"
    t.integer  "sort"
    t.boolean  "is_public"
    t.integer  "pictrue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "public_date", :default => '2010-09-15 03:10:25'
  end

  create_table "passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_code"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pejoy_questions", :force => true do |t|
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "questionnaire7"
    t.string   "questionnaire8"
    t.string   "questionnaire9"
    t.string   "questionnaire10"
    t.string   "questionnaire11"
    t.string   "remarks"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "score"
    t.string   "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["score"], :name => "index_players_on_score"

  create_table "prefs", :force => true do |t|
    t.string   "name",       :limit => 30,                   :null => false
    t.boolean  "is_public",                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prefs", ["name"], :name => "index_prefs_on_name"

  create_table "qiao2s", :force => true do |t|
    t.string   "from"
    t.string   "name"
    t.string   "nickname"
    t.string   "sex"
    t.string   "family"
    t.integer  "age"
    t.string   "professional"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_add"
    t.string   "company_phone"
    t.string   "self_phone"
    t.string   "question1"
    t.string   "question2"
    t.string   "question3"
    t.string   "question4"
    t.string   "question5"
    t.string   "question6"
    t.string   "question7"
    t.string   "question8"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qiao3s", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "adnum"
    t.string   "address"
    t.string   "postcode"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "agree"
    t.string   "food"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qiao4s", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "postcode"
    t.string   "pref"
    t.string   "city"
    t.string   "district"
    t.string   "address"
    t.string   "company_name"
    t.string   "mobile_phone"
    t.string   "agree"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qinzis", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "pref"
    t.string   "city"
    t.string   "district"
    t.string   "postal"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "question1"
    t.string   "question2"
    t.string   "f"
    t.string   "ip"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qq_users", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "figureurl"
    t.string   "image"
    t.string   "token"
    t.string   "expires"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questionnaires", :force => true do |t|
    t.string   "question1"
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "questionnaire1"
    t.string   "questionnaire2"
    t.string   "questionnaire3"
    t.string   "questionnaire4"
    t.string   "questionnaire5"
    t.string   "questionnaire6"
    t.string   "questionnaire7"
    t.string   "questionnaire8"
    t.string   "questionnaire9"
    t.string   "questionnaire10"
    t.text     "remarks"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "recruits", :force => true do |t|
    t.string   "title"
    t.string   "caption"
    t.text     "demand"
    t.text     "content"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "send_users", :force => true do |t|
    t.integer  "email_id"
    t.integer  "email_user_master_id"
    t.text     "remarks"
    t.text     "system_remarks"
    t.datetime "send_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "status"
  end

  create_table "sinkycps", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "sex"
    t.integer  "age"
    t.string   "family"
    t.string   "job"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "pref"
    t.string   "city"
    t.string   "district"
    t.string   "postal"
    t.string   "company_phone"
    t.string   "mobile_phone"
    t.string   "question1"
    t.string   "question2"
    t.string   "f"
    t.string   "ip"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "susu_dates", :force => true do |t|
    t.string   "category"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "susus", :force => true do |t|
    t.string   "from"
    t.string   "name"
    t.string   "sex"
    t.string   "family"
    t.integer  "age"
    t.string   "professional"
    t.string   "email"
    t.string   "company_name"
    t.string   "company_add"
    t.string   "company_phone"
    t.string   "self_phone"
    t.string   "question1"
    t.string   "question2"
    t.string   "question3"
    t.string   "question4"
    t.string   "question5"
    t.string   "question6"
    t.string   "question7"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spokesperson"
  end

  create_table "topimages", :force => true do |t|
    t.string   "image"
    t.string   "linkurl"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "position",     :default => 0
    t.boolean  "target_blank"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "nickname",                  :limit => 20
    t.date     "birthday"
    t.integer  "address1"
    t.integer  "address2"
    t.string   "like_snack",                :limit => 200
    t.boolean  "email_agreement",                          :default => true
    t.boolean  "is_admin"
    t.datetime "deleted_at"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.string   "reset_pwd_token"
    t.boolean  "reset_pwd_state",                          :default => false
    t.boolean  "gender"
    t.string   "job"
    t.string   "postcode"
    t.string   "detail_address"
    t.string   "telphone"
    t.string   "origin"
    t.string   "uid"
  end

  add_index "users", ["login"], :name => "index_users_on_login"

  create_table "visits", :force => true do |t|
    t.string   "fromvisit"
    t.string   "ipvisit"
    t.string   "urlvisit"
    t.text     "cookievisit"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weibo_users", :force => true do |t|
    t.string   "uid"
    t.string   "screen_name"
    t.string   "image"
    t.string   "image_small"
    t.string   "token"
    t.string   "expires"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "weibo_users", ["user_id"], :name => "index_weibo_users_on_user_id"

  create_table "widget_news", :force => true do |t|
    t.string   "title"
    t.text     "message"
    t.string   "link"
    t.boolean  "is_public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "widgets", :force => true do |t|
    t.integer  "user_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "xiaonei_users", :force => true do |t|
    t.string   "uid"
    t.string   "screen_name"
    t.string   "image"
    t.string   "image_small"
    t.string   "token"
    t.string   "expires"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
