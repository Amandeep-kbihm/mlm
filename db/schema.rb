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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180313183033) do

  create_table "conversions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "transaction_id"
    t.string   "company"
    t.string   "company_id"
    t.integer  "user_id"
    t.integer  "deal_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "offer_id"
    t.integer  "status"
    t.index ["deal_id"], name: "index_conversions_on_deal_id", using: :btree
    t.index ["offer_id"], name: "index_conversions_on_offer_id", using: :btree
    t.index ["user_id"], name: "index_conversions_on_user_id", using: :btree
  end

  create_table "deals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.integer  "downloaded",                                          default: 0
    t.string   "link"
    t.string   "logo"
    t.string   "name"
    t.text     "instructions", limit: 65535
    t.boolean  "active",                                              default: false
    t.decimal  "amount",                     precision: 10, scale: 4
    t.integer  "cap"
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.boolean  "reward_later",                                        default: false
  end

  create_table "ecpm_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "transaction_count"
    t.string   "transaction_category"
    t.float    "ecpm_value",           limit: 24
    t.float    "ecpm_min",             limit: 24
    t.float    "ecpm_max",             limit: 24
    t.float    "select_ecpm_value",    limit: 24
    t.date     "transaction_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "enquiries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "subject"
    t.text     "enquiry",    limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id"
    t.integer  "status",                   default: 0
    t.index ["user_id"], name: "index_enquiries_on_user_id", using: :btree
  end

  create_table "limits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "ppc",        default: 0
    t.integer  "ppv",        default: 0
    t.integer  "ppv2",       default: 0
    t.integer  "ppi",        default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_limits_on_user_id", using: :btree
  end

  create_table "manual_apps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "link"
    t.string   "user_attribute"
    t.integer  "caps"
    t.boolean  "active",         default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "nominees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "age"
    t.string   "gender"
    t.string   "relation"
    t.string   "address"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nominees_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "offers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.integer  "downloaded",                                          default: 0
    t.string   "link"
    t.string   "logo"
    t.string   "name"
    t.text     "instructions", limit: 65535
    t.boolean  "active",                                              default: false
    t.decimal  "amount",                     precision: 10, scale: 4
    t.integer  "cap",                                                 default: 0
    t.boolean  "reward_later",                                        default: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  create_table "payment_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "user_id"
    t.decimal  "amount",           precision: 15, scale: 8
    t.integer  "transaction_type"
    t.integer  "status"
    t.string   "pan_number"
    t.string   "mobile_number"
    t.string   "bank_account"
    t.string   "ifsc"
    t.string   "email"
    t.string   "state"
    t.string   "address"
    t.integer  "direction"
    t.integer  "wallet_id"
    t.string   "payment_type"
    t.string   "operator"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["user_id"], name: "index_payment_transactions_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "kind"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "category"
    t.decimal  "amount",                         precision: 15, scale: 8
    t.integer  "transaction_type"
    t.integer  "status"
    t.string   "pan_number"
    t.string   "mobile_number"
    t.string   "bank_account"
    t.string   "ifsc"
    t.string   "name"
    t.string   "state"
    t.string   "address"
    t.integer  "direction"
    t.boolean  "owner",                                                   default: false
    t.integer  "user_id"
    t.integer  "wallet_id"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.decimal  "percent",                        precision: 10, scale: 4
    t.integer  "from_id"
    t.text     "data",             limit: 65535
    t.index ["from_id"], name: "index_transactions_on_from_id", using: :btree
    t.index ["user_id"], name: "index_transactions_on_user_id", using: :btree
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id", using: :btree
  end

  create_table "user_actions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "category"
    t.integer  "user_id"
    t.boolean  "paid",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_user_actions_on_user_id", using: :btree
  end

  create_table "user_refers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "level",       default: 0
    t.integer  "refer_id"
    t.integer  "referred_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["refer_id"], name: "index_user_refers_on_refer_id", using: :btree
    t.index ["referred_id"], name: "index_user_refers_on_referred_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "email",                             default: ""
    t.string   "encrypted_password",                default: "",                         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,                          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",   limit: 30
    t.string   "sponsor_id"
    t.string   "refer_id"
    t.integer  "chain_count",                       default: 0
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.date     "dob"
    t.string   "mobile_number"
    t.string   "country"
    t.string   "real_sponsor_id"
    t.integer  "user_level",                        default: 0
    t.integer  "status",                            default: 0
    t.boolean  "boost",                             default: false
    t.string   "otp"
    t.boolean  "block",                             default: false
    t.datetime "otp_sent_on",                       default: -> { "CURRENT_TIMESTAMP" }
    t.integer  "refer_income",                      default: 0
    t.string   "fcm_token"
    t.string   "forgot_password_otp"
    t.string   "device_id"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["real_sponsor_id"], name: "index_users_on_real_sponsor_id", using: :btree
    t.index ["refer_id"], name: "index_users_on_refer_id", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["sponsor_id"], name: "index_users_on_sponsor_id", using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "wallets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.decimal  "balance",    precision: 15, scale: 8
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["user_id"], name: "index_wallets_on_user_id", using: :btree
  end

  add_foreign_key "conversions", "deals"
  add_foreign_key "conversions", "offers"
  add_foreign_key "conversions", "users"
  add_foreign_key "enquiries", "users"
  add_foreign_key "limits", "users"
  add_foreign_key "nominees", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "wallets"
  add_foreign_key "user_actions", "users"
end
