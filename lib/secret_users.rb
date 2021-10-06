# frozen_string_literal: true

require 'singleton'
require 'sqlite3'

class SecretUsers
  include Singleton

  def create(hash)
    if hash.is_a?(Hash)
      db_connection.execute('INSERT INTO secret_users(phone,method,reason) VALUES(?,?,?)', hash[:phone], hash[:method], hash[:reason])
      true
    else
      false
    end
  rescue StandardError => e
    puts e.message
    false
  end

  def find_by_params(params, method)
    phone = JSON.parse(params)['phone']
    puts phone
    result = db_connection.execute('SELECT * FROM secret_users WHERE phone = ?', phone)
    # result = db_connection.execute('SELECT * FROM secret_users WHERE phone = ? AND method = "?"', phone, method)
    if result.empty?
      nil
    else
      id, phone, method, reason = result.first
      { id: id, phone: phone, method: method, reason: reason }
    end
  rescue StandardError => e
    puts e.message
  end

  def self.method_missing(method_name, *arguments, &block)
    if instance.respond_to?(method_name)
      instance.send(method_name, *arguments)
    else
      super
    end
  end

  def self.respond_to_missing?(method_name)
    %w[create find_by_phone].include?(method_name) || super
  end

  private

  def db_connection
    @db_connection ||= SQLite3::Database.open('secret_users.db')
  end
end

