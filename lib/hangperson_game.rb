class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word,:guesses,:wrong_guesses, :word_with_guesses, :check_win_or_lose
  
  # Initialize the game
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    word.each_char do |i|
      # initially just all dashes
      @word_with_guesses << '-'
    end
    @check_win_or_lose = :play

  end

  # Grab a random word from the dictionary
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  
  # When a user makes a guess
  def guess(letter)
    throw 'Error: Nil guess not allowed' if letter.nil?
    throw 'Error: Empty guess' if letter == ''
    throw 'Error: Guess not a letter' if !letter.match(/[a-zA-Z]/)

    
    letter.downcase!
    
    if word.include? letter
      unless guesses.include? letter
        guesses << letter
        for i in 0..word.length
          if word[i] == letter
            word_with_guesses[i] = letter
            @check_win_or_lose = :win if guesses.chars.sort == word.chars.sort
          end
        end
        return true
      end
    else
      unless wrong_guesses.include? letter
        wrong_guesses << letter
        if wrong_guesses.size >= 7
          @check_win_or_lose = :lose
        end
        return true
      end
    end
    return false
  end

end
