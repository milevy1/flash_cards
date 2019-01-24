class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @turns = []
  end

  def start
    puts "Welcome! You're playing with #{deck.count} cards."
    puts "-------------------------------------------------"

    # This loops until turns == deck card count
    while(@turns.length != @deck.count)
      puts "This is card number #{@turns.length + 1} out of #{deck.count}."
      puts "Question: #{current_card.question}"
      guess_user = gets.chomp
      turn_temp = take_turn(guess_user)
      puts turn_temp.feedback
    end

    puts "****** Game over! ******"
    puts "You had #{number_correct} correct guesses out of #{@turns.length} for a total score of #{percent_correct}%."

    array_of_unique_categories.each{ |category|
      puts "#{category} - #{percent_correct_by_category(category)}% correct"
    }

  end

  def array_of_unique_categories
    # This shuffles all the categories in the deck into an array
    # then removes any duplicates with the uniq method
    categories_array = []
    @deck.cards.each{ |card| categories_array << card.category }
    return categories_array.uniq
  end

  def current_card
    # Current card will always be the deck.cards array
    # with index == how many turns have been taken
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
    (number_correct.to_f / turns.length.to_f * 100).round(2)
  end

  def turns_in_category(category)
    @turns.count{ |turn| turn.card.category == category}
  end

  def percent_correct_by_category(category)
    (number_correct_by_category(category).to_f / turns_in_category(category).to_f * 100).round(2)
  end

end
