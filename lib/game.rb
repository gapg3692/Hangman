# frozen_string_literal: true

# require_relative 'display'
# class Game is were the magig happends
class Game
  attr_reader :messages

  include Display

  def initialize
    @word = generate_word.chomp
    @letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @fails = %w[]
    @good = %w[]
    @messages = ''
  end

  def play_game
    clear_screen
    @messages = ''
    round_screen while @fails.length < 10 && @good.length < @word.length && @messages != 'save'
    win_or_lose
  end

  def reset
    @word = generate_word
    @letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @fails = %w[]
    @good = %w[]
    @messages = ''
  end

  def win_or_lose
    if @good.length == @word.length
      show
      puts 'You win!!'
    elsif @messages == 'save'
      puts 'saving game ...'
    else
      show
      puts 'You lose!'
    end
  end

  def letters_selected
    puts "You have selected #{@good.to_s.green} good and #{@fails.to_s.red} bad"
  end

  def round(char)
    if char == 'save'
      'save'
    elsif @fails.to_s.include?(char) || @good.to_s.include?(char)
      "You selected #{char.red} before, select another one.."
    elsif !@letters.to_s.include?(char)
      'You can select that character'

    else
      @word.include?(char) ? @good.push(@letters.delete(char)) : @fails.push(@letters.delete(char))
      "You select #{char.green} now"
    end
  end

  def generate_word
    dictionary = File.open('google-10000-english-no-swears.txt', 'r')
    words = dictionary.select do |l|
      l = l.chomp
      l.length <= 12 && l.length >= 5 && /[[:lower:]]/.match(l[0])
    end
    dictionary.close
    words.sample
  end

  def show
    clear_screen
    puts "Select a letter or write #{"'save'".cyan} if you what to save the game and exit. You have #{(10 - @fails.length).to_s.cyan} lives."
    puts @word.gsub(/#{@letters}/, '_ ')
    puts @good.length == @word.length ? get_image('11') : get_image(@fails.length.to_s)
    letters_selected
    puts @messages
  end

  def round_screen
    show
    @messages = round(gets.downcase.chomp)
  end
end
