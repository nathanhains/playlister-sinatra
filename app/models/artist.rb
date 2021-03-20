
class Artist < ActiveRecord::Base 
    require_relative 'concerns/slugifiable'
    has_many :songs
    has_many :genres, through: :songs
    include Slugifiable
    extend Slugifiable::ClassMethods
end