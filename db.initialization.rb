# frozen_string_literal: true

require 'sqlite3'

db = SQLite3::Database.open('secret_users.db')
db.execute 'CREATE TABLE IF NOT EXISTS secret_users(id INTEGER PRIMARY KEY,phone INTEGER NOT NULL UNIQUE, comment TEXT NOT NULL)'
db.close
