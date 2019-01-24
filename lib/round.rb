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

end
