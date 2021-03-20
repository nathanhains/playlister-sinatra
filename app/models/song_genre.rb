class SongGenre < ActiveRecord::Base
    belongs_to :song
    belongs_to :genre
    include Slugifiable
    extend Slugifiable::ClassMethods
end