class CardGenerator
  attr_reader :filename, :cards, :filedata, :card_counter

  def initialize(filename)
    @filename = filename
    @cards = []
    # Read in data, split by new lines, then map to array split by the commas
    @filedata = File.open(filename, 'r').read.split(/\n/).map{ |card_string| card_string.split(',') }
    # Then shuffle each elemeet of the array into the cards
    @filedata.each{ |card|
      @cards << Card.new(card[0], card[1], card[2])
    }
  end

end
