class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def word_with_guesses()
    display = ''
    @word.each_char {|letter|
      if @guesses.include?(letter)
        display = display + letter
      else
        display = display + '-'
      end
    }
    return display
  end

  def check_win_or_lose()
    if word_with_guesses() == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  def guess(iinput)
    if iinput.nil? or iinput.empty? or iinput.match(/[^a-zA-Z]/)
      raise ArgumentError
    end
    iinput = iinput.downcase
    if @word.include?(iinput)
      if @guesses.include?(iinput)
        return false
      else
        @guesses = @guesses + iinput
      end
    else
      if @wrong_guesses.include?(iinput)
        return false
      else 
        @wrong_guesses = @wrong_guesses + iinput
      end
    end
  end

  attr_accessor :word,:guesses,:wrong_guesses
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
