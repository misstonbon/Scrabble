module Scrabble
  class Scoring
    SCORE_HASH = {

      %w(A E I O U L N R S T) => 1,
      %w(D G) => 2,
      %w(B C M P) => 3,
      %w(F H V W Y) => 4,
      %w(K) => 5,
      %w(J X) => 8,
      %w(Q Z) => 10
    }  #letter_arr , letter_score

    def self.score(word)
      raise ArgumentError.new "Input must be a String class." if word.class != String
      raise ArgumentError.new "Word must be one to seven letters long." if word.length == 0 || word.length > 7
      raise ArgumentError.new "Word must contain only regular ASCII letters." if !word.match(/^[A-Z]+$/i)

      letters = word.upcase.split("")
      word_score = 0

      letters.each do |letter|
        SCORE_HASH.each do |letter_arr, letter_score|
          if letter_arr.include? letter
            word_score += letter_score
          end
        end
      end

      if word.length == 7
        word_score += 50
      end
      return word_score
    end #end self.score

    def self.highest_score_from(array_of_words)
      raise ArgumentError.new "argument must be an Array" if array_of_words.class != Array
      raise ArgumentError.new "input Array cannot be empty" if array_of_words.length == 0

      words_hash = {}
      array_of_words.each do |word|
        words_hash[word] = Scrabble::Scoring.score(word)
      end

      winners = words_hash.reject!{|word,value| value < (words_hash.values.max)}

      if  winners.length == 1
        winner = winners.key(words_hash.values.max)
      else
        winners.each do |word, value|
          if word.length == 7
            winner = word
            return winner
          end
        end

        winner = winners.keys.min_by{|word| word.length}
      end
    end
  end #end class
end #end module

# winner = Scrabble::Scoring.highest_score_from(%w(qzzzzj to the ok hi aaaaaad))
# p winner
