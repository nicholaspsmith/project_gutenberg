require_relative 'predictor'

class SimplePredictor < Predictor
  def train!
    # We need no training.
  end

  def predict(str)
    # Always predict astronomy.
    :astronomy
  end
end

