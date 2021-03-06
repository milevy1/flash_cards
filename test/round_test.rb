require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

class RoundTest < Minitest::Test

  def setup
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @round = Round.new(@deck)
  end

  def test_round_exists
    assert_instance_of Round, @round
  end

  def test_round_has_a_deck
    assert_equal @deck, @round.deck
  end

  def test_round_starts_with_turns_empty_array
    assert_equal [], @round.turns
  end

  def test_round_current_card_returns_first_card_at_start_of_round
    assert_equal @card_1, @round.current_card
  end

  def test_round_take_turn_method_returns_a_turn
    new_turn = @round.take_turn("Juneau")

    assert_equal Turn, new_turn.class
  end

  def test_round_take_turn_has_turn_correct_method
    new_turn = @round.take_turn("Juneau")

    assert_equal true, new_turn.correct?
  end

  def test_round_turns_returns_array_of_turns_after_taking_a_turn
    new_turn = @round.take_turn("Juneau")

    assert_equal [new_turn], @round.turns
  end

  def test_round_number_correct_returns_1
    new_turn = @round.take_turn("Juneau")

    assert_equal 1, @round.number_correct
  end

  def test_round_current_card_changes_after_taking_a_turn
    @round.take_turn("Juneau")

    assert_equal @card_2, @round.current_card
  end

  def test_round_turns_count_is_2_after_taking_2_turns
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    assert_equal 2, @round.turns.count
  end

  def test_round_turns_feedback_returns_incorrect
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    assert_equal "Incorrect.", @round.turns.last.feedback
  end

  def test_round_number_correct_is_still_1
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    assert_equal 1, @round.number_correct
  end

  def test_round_number_correct_by_category
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    assert_equal 1, @round.number_correct_by_category(:Geography)
    assert_equal 0, @round.number_correct_by_category(:STEM)
  end

  def test_round_percent_correct
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    assert_equal 50.0, @round.percent_correct
  end

  def test_round_percent_correct_by_category
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    assert_equal 100.0, @round.percent_correct_by_category(:Geography)
  end

  def test_round_current_card_is_card_3
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    assert_equal @card_3, @round.current_card
  end

end
