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

    # TODO: We need some internal representation here.
    puts @books
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

predictor = Predictor.new(sample: true)
start_time = Time.now
puts "Training..."
predictor.train!
puts "Training took #{Time.now - start_time} seconds."

puts predictor.predict("philosophy")
