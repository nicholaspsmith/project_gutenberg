require_relative 'predictor'

class ComplexPredictor < Predictor
  # Public: Trains the predictor on books in our dataset. This method is called
  # before the predict() method is called.
  #
  # Returns nothing.
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
  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    # Always predict astronomy.
    :astronomy
  end
end

