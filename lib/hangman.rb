class Game
  def initialize
    @dictionary_file = File.open('google-10000-english.txt', 'r')
    @word
    @progress
    @fails
    @guess
  end
end