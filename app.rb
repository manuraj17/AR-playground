#!/usr/bin/env ruby

require 'active_record'
require 'pp'
require 'sqlite3'

class SomeError < StandardError; end

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :owners, force: true do |t|
    t.string :name
  end
  create_table :pets, force: true do |t|
    t.string :name
    t.references :owner
  end
end

# Set up model classes
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
class Owner < ApplicationRecord
  has_many :pets
end
class Pet < ApplicationRecord
  belongs_to :owner
end

owner = Owner.create(name: "Jay")
owner.pets.create(name: "Max")
owner.pets.create(name: "Chai")
p Owner.first.pets
p Owner.first
puts "Fin"
