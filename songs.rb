require_relative 'my_enumerable'

class Song
    attr_reader :name, :artist, :duration
  
    def initialize(name, artist, duration)
      @name = name
      @artist = artist
      @duration = duration
    end
  
    def play
      puts "Playing '#{name}' by #{artist} (#{duration} mins)..."
    end
  
    def each_filename
      basename = "#{name}-#{artist}".gsub(" ", "-").downcase
      extensions = [".mp3", ".wav", ".aac"]
      extensions.each { |ext| yield basename + ext }
    end
  end
  
  song1 = Song.new("High Hopes", "Panic! At the Disco", 3)
  song2 = Song.new("Mayonaka no Door", "Miki Matsubara", 5)
  song3 = Song.new("Leave the Door Open", "Silk Sonic", 4)

  class Playlist
  #  include Enumerable
  include MyEnumerable

    def initialize(name)
      @name = name
      @songs = []
    end
  
    def add_song(song)
      @songs << song
    end
  
    def each
      @songs.each { |song| yield song }
    end
  
    def play_songs
      each { |song| song.play }
    end
  
    def each_tagline
      @songs.each { |song| yield "#{song.name} - #{song.artist}" }
    end
  
    def each_by_artist(artist)
      my_select { |s| s.artist == artist }.each { |song| yield song }
    end
  end
  
  playlist = Playlist.new("Stuff I Like!!")
  playlist.add_song(song1)
  playlist.add_song(song2)
  playlist.add_song(song3)
  
  playlist.each { |song| song.play }
  
  playlist.play_songs
  
  okie_songs = playlist.my_select { |song| song.name =~ /High Hopes/ }
  p okie_songs
  
  non_okie_songs = playlist.my_reject { |song| song.name =~ /High Hopes/ }
  p non_okie_songs
  
  p playlist.my_any? { |song| song.artist == "Miki Matsubara" }
  p playlist.my_detect { |song| song.artist == "Miki Matsubara" }
  
  song_labels = playlist.my_map { |song| "#{song.name} - #{song.artist}" }
  p song_labels
  
  total_duration = playlist.my_reduce(0) { |sum, song| sum + song.duration }
  p total_duration
  
  playlist.each_tagline { |tagline| puts tagline }
  
  song1.each_filename { |filename| puts filename }
  
  playlist.each_by_artist("Silk Sonic") { |song| song.play }
  
  playlist.each_by_artist("Panic! At the Disco") { |song| song.play }
  