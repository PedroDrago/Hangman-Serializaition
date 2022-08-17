require 'json'

class Game
  attr_accessor :dictionary_file, :word, :progress, :fails, :guess, :all_guesses
  def initialize
    @dictionary_file = open('google-10000-english.txt', 'r')
    @word = '123456789101112'
    until @word.length > 5 && @word.length < 12
      @word = File.readlines('google-10000-english.txt').sample.split('')
    end
    @word.pop
    @progress = Array.new(@word.length, '_')
    @fails = 0
    @guess = ''
    @all_guesses = []
  end

  def take_guess
    puts 'make your guess:'
    @guess = gets.chomp
    if @all_guesses.include? @guess
      until @all_guesses.include? @guess == false
        puts 'You already made that guess, be smarter. Try again: ' #this is not working
        @guess = gets.chomp
      end
      @all_guesses.push @guess
    end
  end

  def resolve_round
    result = @word.include? @guess
    if result == false
      puts 'wrong guess'
      @fails += 1
    elsif result == true
      @word.each_with_index do |letter, index|
        if letter == @guess
          @progress[index] = @guess
        end
      end
    end
  end

  def should_end?
    if @fails == 5
      true
    elsif @progress == @word
      true
    else
      false
    end
  end

  def save_game
      


end

new_game = Game.new
p new_game.progress
until new_game.should_end?
  new_game.take_guess
  new_game.resolve_round
  p new_game.progress
  p new_game.fails
end