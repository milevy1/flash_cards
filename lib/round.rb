class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @turns = []
  end

  def current_card
    @deck.cards[@turns.length]
  end

  def take_turn(guess)
    turn_temp = Turn.new(guess, current_card)
    @turns << turn_temp
    return turn_temp
  end

  def number_correct
    @turns.count{ |turn| turn.correct? }
  end

  def number_correct_by_category(category)
    @turns.count{ |turn| turn.correct? && turn.card.category == category }
  end

  def percent_correct
    number_correct.to_f / turns.length.to_f * 100
  end

  def turns_in_category(category)
    @turns.count{ |turn| turn.card.category == category}
  end

  def percent_correct_by_category(category)
    number_correct_by_category(category).to_f / turns_in_category(category).to_f * 100
  end

end
