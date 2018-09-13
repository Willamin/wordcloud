require "./hashtable"
require 'pp'

class WordCloud
  def initialize(input)
    @paragraph = input.downcase
  end

  def strip_punctuation!
    @paragraph = @paragraph.delete(",./<>?!\"\';:()-")
  end

  def tokenize!
    @tokens = @paragraph.split(" ")
  end

  def strip_inconsequential!
    @tokens = @tokens - %w(the and was had that this said)
    @tokens = @tokens.select do |t|
      t.size > 2
    end
  end

  def count!
    @ht ||= HashTable.new
    @tokens.each do |token|
      count = ht[token]
      if count.nil?
        count = 0
      end
      count += 1
      ht[token] = count
    end
  end

  def ht
    @ht
  end

  def self.top(x, input)
    wc = WordCloud.new(input)
    wc.strip_punctuation!
    wc.tokenize!
    wc.strip_inconsequential!
    wc.count!

    h = wc.ht
    words_list = h.sort.reverse.take(x)
    max_size = h[words_list[0]]

    words = []
    words_list.each do |word|
      words << Word.new(word, percent(h[word], max_size))
    end

    words
  end
end

class Word
  def initialize(word, size)
    @word = word
    @size = size
  end

  def word
    @word
  end

  def size
    @size
  end
end

def percent(numerator, denominator)
  ((1.0 * numerator / denominator) * 100).round
end
