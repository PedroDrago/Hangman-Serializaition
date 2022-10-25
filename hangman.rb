require 'oj'

class Game
  attr_accessor :dictionary_file, :word, :progress, :fails, :guess, :all_guesses, :save_choice, :should_end

  def initialize
    @dictionary_file = open('google-10000-english.txt', 'r')
    @word = '123456789101112'
    until @word.length > 5 && @word.length < 12
      @word = File.readlines(@dictionary_file).sample.split('')
    end
    @word.pop
    @progress = Array.new(@word.length, '_')
    @fails = 0
    @guess = ''
    @all_guesses = []
    @save_choice
  end


  def take_guess
    puts 'make your guess:'
    @guess = gets.chomp
    if @guess == 'quit'
      @save_choice = true
    else
      if @all_guesses.include? @guess
        until @all_guesses.include? @guess == false
          puts 'You already made that guess, be smarter. Try again: ' #this is not working
          @guess = gets.chomp
        end
        @all_guesses.push @guess
      end
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
    end
  end

end


puts 'Would you like to load a saved game? [y/n]'
load_choice = gets.chomp
if load_choice == 'y'
  save_file = File.open('save.txt', 'r')
  save = save_file.read
  new_game = Oj::load save, :indent =>2
elsif load_choice == 'n'
new_game = Game.new
end

p new_game.progress
new_game.should_end?
puts '-----------------------------'
until new_game.should_end? == true
  new_game.take_guess
  if new_game.guess == 'quit'
    break
  end
  new_game.resolve_round
  new_game.should_end?
  p new_game.progress
  puts "Fails: #{new_game.fails}"
  puts '-----------------------------'
end
if new_game.save_choice == true
  save = Oj::dump new_game, :indent => 2
  save_file = File.open('save.txt', 'w')
  save_file.puts save
end

if new_game.progress == new_game.word
  puts 'you guessed right, you won!'
  File.open('save.txt', 'w') {}
elsif new_game.fails == 5
  puts 'You failed 5 times, you lost.'
  puts "The word was: #{new_game.word.join('')}"
  File.open('save.txt', 'w') {}
end
