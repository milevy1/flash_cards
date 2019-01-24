require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/card'
require './lib/deck'
require './lib/round'
require './lib/card_generator'

class CardGeneratorTest < Minitest::Test

  def test_card_generator_can_open_file
    cards = CardGenerator.new('./data/cards.txt')

    assert_equal cards.filename, './data/cards.txt'
  end

end
