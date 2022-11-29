# frozen_string_literal: true

require_relative 'display'
require_relative 'game'
require_relative 'color'
require 'yaml'

def presentation_text
  system('clear') || system('cls')
  puts "Welcome to the Hangman game! \n\nSelect an option:\n 1-Play a new game.\n 2-Continue a saved game.\n"
  case gets.chomp
  when '1'
    true
  when '2'
    false
  else
    presentation_text
  end
end

def new_game?
  puts 'Do you want to play a new game? Select y (Yes) or n (No)'
  case gets.chomp
  when 'y'
    true
  when 'n'
    puts 'Good bye. Thanks for playing a Hangman'
    false
  else
    puts 'Wrong answer'
    new_game?
  end
end

def save_game(current_game)
  filename = prompt_name
  return false unless filename

  dump = YAML.dump(current_game)
  File.open(File.join(Dir.pwd, "/saved/#{filename}.yaml"), 'w') { |file| file.write dump }
end

def prompt_name
  filenames = Dir.glob('saved/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  puts 'Enter name for saved game'
  filename = gets.chomp
  raise "#{filename} already exists." if filenames.include?(filename)

  filename
rescue StandardError => e
  puts "#{e} Are you sure you want to rewrite the file? (Yes/No)".red
  answer = gets[0].downcase
  until %w[y n].include?(answer)
    puts "Invalid input. #{e} Are you sure you want to rewrite the file? (Yes/No)".red
    answer = gets[0].downcase
  end
  answer == 'y' ? filename : nil
end

def load_game
  filename = choose_game
  saved = File.open(File.join(Dir.pwd, filename), 'r')
  loaded_game = YAML.safe_load(saved, permitted_classes: [Game])
  saved.close
  loaded_game
end

def choose_game
  puts "Here are the current saved games. Please choose the number which you'd like to load."
  filenames = Dir.glob('saved/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  filenames.each_index { |index| puts "#{index + 1} #{filenames[index]}" }
  filename = filenames[gets.chomp.to_i - 1]
  raise 'That number does not exits. Please pick another one'.red unless filenames.include?(filename)

  puts "#{filename} loaded..."
  puts
  "/saved/#{filename}.yaml"
rescue StandardError => e
  puts e
  retry
end

loop do
  game = presentation_text ? Game.new : load_game
  p game
  game.play_game
  puts 'Your game has been saved. Thanks for playing!' if game.messages == 'save' && save_game(game)
  break unless new_game?
end
