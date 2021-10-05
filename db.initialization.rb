# frozen_string_literal: true

require 'sqlite3'

db = SQLite3::Database.open('secret_users.db')
db.execute 'CREATE TABLE IF NOT EXISTS secret_users(id INTEGER PRIMARY KEY,phone INTEGER NOT NULL UNIQUE,method TEXT NOT NULL,reason TEXT NOT NULL)'
db.close
