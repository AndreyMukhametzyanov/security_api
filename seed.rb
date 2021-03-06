# frozen_string_literal: true

require_relative './lib/secret_users'
require 'sqlite3'

phone_list = [
  { phone: 79000000000, method: 'GET', reason: 'Это телефон того кого нельзя называть' },
  { phone: 79999999999, method: 'POST', reason: 'Это телефон жены того кого нельзя называть' },
  { phone: 79555555555, method: 'PUT', reason: 'Это телефон тебе лучше не знать' },
  { phone: 79177861370, method: 'DELETE', reason: 'Этот телефон сам тебе позвонит если захочет' }
]

db = SQLite3::Database.open('secret_users.db')
phone_list.each { |el| SecretUsers.create(el) }
db.close
