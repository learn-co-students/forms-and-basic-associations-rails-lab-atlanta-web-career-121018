class Song < ActiveRecord::Base

    has_many :notes
    belongs_to :artist
    belongs_to :genre

    # sets the genre to the genre of the specified name
    def genre_name=(name)
        self.genre = Genre.find_or_create_by(name: name)
    end

    # returns the genre name
    def genre_name
        # self.genre.name
        self.genre ? self.genre.name : ''
    end

    # sets the artist to the artist of the specified name
    def artist_name=(name)
        self.artist = Artist.find_or_create_by(name: name)
    end

    # returns the artist name
    def artist_name
        # self.artist.name
        self.artist ? self.artist.name : ''
    end

    # returns the content of all notes as an array
    def note_contents
        self.notes.collect do |note|
            note.content
        end
    end

    # sets notes for a song
    # adds to existing notes
    # ignores blank notes
    def note_contents=(contents)
        contents.each do |content|
            if !content.empty?
                note = Note.find_or_create_by(content: content)
                self.notes << note
            end
        end
    end
end

# < f.label :notes %>
# <input name='song[note_contents][]' id='song_notes_1'>
# <input name='song[note_contents][]' id='song_notes_2'>
# <br />
