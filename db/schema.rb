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

ActiveRecord::Schema.define(:version => 20120916211302) do

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  add_index "leagues", ["code"], :name => "index_leagues_on_code", :unique => true
  add_index "leagues", ["user_id"], :name => "index_leagues_on_user_id"

  create_table "matchups", :force => true do |t|
    t.integer  "season_id"
    t.integer  "week_id"
    t.datetime "game_time"
    t.string   "away_team_name"
    t.string   "away_team_logo_url"
    t.string   "home_team_name"
    t.string   "home_team_logo_url"
    t.integer  "team_score_away"
    t.integer  "team_score_home"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "nfl_game_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["league_id"], :name => "index_memberships_on_league_id"
  add_index "memberships", ["user_id", "league_id"], :name => "index_memberships_on_user_id_and_league_id", :unique => true
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "picks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.integer  "season_id"
    t.integer  "week_id"
    t.integer  "matchup_id"
    t.boolean  "away"
    t.boolean  "home"
    t.string   "team_name"
    t.boolean  "win"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "picks", ["league_id"], :name => "index_picks_on_league_id"
  add_index "picks", ["matchup_id"], :name => "index_picks_on_matchup_id"
  add_index "picks", ["user_id", "league_id", "matchup_id"], :name => "index_picks_on_user_id_and_league_id_and_matchup_id", :unique => true
  add_index "picks", ["user_id"], :name => "index_picks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "name"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
