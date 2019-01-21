require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true

     table_col = DB[:conn].execute("PRAGMA table_info(#{self.table_name})")
    col_names = []

     table_col.each do |col|
      col_names << col["name"]
    end
    col_names.compact
 end
end
