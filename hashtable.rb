class HashTable
  PRIMES = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199]

  def initialize
    size = 15_485_863
    @list = Array.new(size)
    size.times do |i|
      @list[i] = nil
    end
    @keys = Array.new
  end

  def [](key)
    # get
    h = hash(key)
    @list[h % @list.size]
  end

  def []=(key, value)
    # set
    @keys << key
    @keys = @keys.uniq
    h = hash(key)

    @list[h % @list.size] = value
  end

  def hash(key)
    unless key.is_a?(String)
      raise "`#{key}` is not a string!"
    end

    sum = 0
    key.bytes.each_with_index do |b, index|
      prime = PRIMES[index]
      raise "missing prime `#{index}`" if prime.nil?
      sum += b * prime
    end
    sum
  end

  def to_s
    s = ""
    s += "{"
    s += @keys.map do |key|
      "\"#{key}\": #{self[key]}"
    end.join(",")
    s += "}"
    s
  end

  def sort
    keys_remaining = @keys.uniq.sort
    output = []

    @list.compact.sort.each do |value|
      keys_remaining.each do |key|
        next if key.nil?
        next if value.nil?
        next if self[key].nil?

        if value == self[key]
          output << key
          keys_remaining = keys_remaining - [key]
        end
      end  
    end

    output
  end
end
