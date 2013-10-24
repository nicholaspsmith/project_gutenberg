require_relative 'predictor'

class AnswerPredictor < Predictor
  def train!
    # @data looks like:
    #
    # {
    #   astronomy: {
    #     counts: {
    #       "stars" => 100,
    #       "galaxy" => 80
    #     },
    #     total: 180,
    #   },
    #   physics: {
    #     ...
    #   }
    # }
    @data = {}

    @all_books.each do |category, books|
      @data[category] = {
        counts: Hash.new(0), # Counts for each word
        total: 0             # Total number of words
      }

      books.each do |filename, book|
        tokens = tokenize(book)
        counts = 0
        tokens.each do |token|
          next unless good_token?(token)
          counts += 1
          @data[category][:counts][token] += 1
        end
        @data[category][:total] = counts
      end
    end
  end

  def predict(str)
    matches = {}
    CATEGORIES.each do |category|
      matches[category] = 0
    end

    tokens = tokenize(str)
    tokens.each do |token|
      @data.each do |category, data|
        counts = data[:counts][token]
        if counts > 0
          # Each matched word is worth relative to number of words for that
          # category.
          matches[category] += counts.to_f / data[:total]
        end
      end
    end

    # grouped = matches.group_by { |k, v| v }
    # sorted = grouped.to_a.sort_by { |counts, category_counts| counts }
    # highest_count_categories = sorted.first.last
    # highest_count_categories.first.first

    # If there are ties, pick arbitrary.
    winner = matches.to_a.sort_by { |category, count| -count }.first
    winner.first
  end

  # Interesting experiment: only allow big words to be used as tokens.
  # def good_token?(token)
  #   !STOP_WORDS.include?(token) && token.size > 10
  # end
end


