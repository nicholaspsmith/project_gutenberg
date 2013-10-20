require 'set'
require 'find'

# They need to write:

class Predictor
  CATEGORIES = [:astronomy, :philosophy, :physics, :religion]

  # Hash of array of strings.
  #
  # {
  #   :philosophy => [book1, book2, ...],
  #   :physics => [book1, book2, ...],
  #   ...
  # }
  attr_reader :books

  # opts - Options:
  #   :sample - Use sample dataset if true. Defaults to false.
  #
  # Returns new Predictor object.
  def initialize(opts={})
    @sample = opts[:sample] || false
    load_books!

    # TODO: We need some data structure(s) here.
  end

  # TODO Implement.
  #
  # Public: Trains the predictor on books in our dataset.
  #
  # Returns nothing.
  def train!
  end

  # TODO: Implement.
  #
  # Public: Predicts category.
  #
  # str - A string.
  #
  # Returns a category.
  def predict(str)
  end

  # TODO: Alternative project. Implement.
  #
  # Public: Prints out the n most-mentioned words in each category.
  #
  # n - Integer.
  #
  # Returns nothing.
  def top_words(n)
  end

  private

  def training_directory
    @sample ? "sample" : "training"
  end

  def load_books!
    @books = {}
    CATEGORIES.each do |category|
      Find.find("data/#{training_directory}/#{category}") do |file|
        next if File.directory?(file)
        next if file.split("/").last[0] == "." # Ignore hidden files

        @books[category] ||= []
        @books[category] << File.read(file)
      end
    end
  end
end

puts "Loading books..."
start_time = Time.now
predictor = Predictor.new()
puts "Loading books took #{Time.now - start_time} seconds."


puts "Training..."
start_time = Time.now
predictor.train!
puts "Training took #{Time.now - start_time} seconds."

puts predictor.predict("philosophy")
