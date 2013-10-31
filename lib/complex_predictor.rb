require_relative 'predictor'
require 'pry'

class ComplexPredictor < Predictor
  # Public: Trains the predictor on books in our dataset. This method is called
  # before the predict() method is called.
  #
  # Returns nothing.
  def train!
    @data = {}

    @all_books.each do |category, books|
      @data[category]={  }
      books.each do |filename, tokens|
        tokens.each do |token|
          if good_token?(token)
            @data[category][token] ||= 0
            @data[category][token] += 1
          end
        end
        @data[category].keep_if do |key, value|
          value > 50
        end
      end
    end
    # puts @data
    @data
  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    results = {}
    winner = {}
    list_of_words ={}

    tokens.each do |token|
      # loop through tokens list
      # create a hash to keep track of how many times word appears in token list
      if good_token?(token)
        list_of_words[token] ||= 0
        list_of_words[token] += 1
      end
      # compare it with your data   
    end#tokens.each

    @data.each do |symbol, pairs|
      results[symbol] = 0
      pairs.keys.each do |key|
        if list_of_words.include?(key)
          results[symbol] += 1
        end
      end

    end#@data.each

    max = results.values.max
    binding.pry
    results.each do |key, value|
      if value == max
        return key
      end
    end

  end#predict
end#class

