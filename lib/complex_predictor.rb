require_relative 'predictor'

class ComplexPredictor < Predictor
  def train!
    # We need no training.
  end

  def predict(str)
    # Always predict astronomy.
    :astronomy
  end
end

