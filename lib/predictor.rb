require 'set'
require 'find'

class Predictor
  CATEGORIES = [:astronomy, :philosophy, :physics, :religion]

  # Hash of array of strings.
  #
  # {
  #   :philosophy => [[filename1, book1], ...],
  #   :physics => ...,
  #   ...
  # }
  attr_reader :all_books

  # opts - Options:
  #   :sample - Use sample dataset if true. Defaults to false.
  #
  # Returns new Predictor object.
  def initialize(opts={})
    @all_books = load_books(:training)
  end

  # Public: Trains the predictor on books in our dataset.
  #
  # Returns nothing.
  def train!
    raise "You must implement Predictor#train!."
  end

  # Public: Predicts category.
  #
  # str - A string.
  #
  # Returns a category.
  def predict(str)
    raise "You must implement Predictor#predict."
  end

  # opts - Options
  #   :debug - Defaults false.
  #
  # Returns nothing.
  def predict_test_set(opts={})
    right = 0
    wrong = 0

    all_books = load_books(:test)
    all_books.each do |category, books|
      books.each do |filename, book|
        prediction = predict(book)
        if prediction == category.to_sym
          right += 1
          puts "Correct! Predicted #{prediction}. #{filename}." if opts[:debug]
        else
          wrong += 1
          puts "Wrong.   Predicted #{prediction} instead of #{category}. #{filename}." if opts[:debug]
        end
      end
    end

    accuracy = right.to_f / (right + wrong)
    puts "Accuracy: #{accuracy}" if opts[:debug]
    accuracy
  end

  private

  def training_directory
    @sample ? "sample" : "training"
  end

  # dataset - The dataset to use: sample, training, test.
  #
  # Returns hash of category to books like this:
  #
  # {
  #   :philosophy => [[filename, book_content], ...]
  # }
  #
  def load_books(dataset)
    books = {}
    CATEGORIES.each do |category|
      Find.find("data/#{dataset}/#{category}") do |file|
        next if File.directory?(file)
        next if file.split("/").last[0] == "." # Ignore hidden files

        books[category] ||= []
        books[category] << [file, File.read(file)]
      end
    end
    books
  end
end

