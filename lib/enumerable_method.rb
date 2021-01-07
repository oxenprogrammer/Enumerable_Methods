module Enumerable
  # my_each
  def my_each(&block)
    return enum_for(:my_each) unless block_given?

    each do |item|
      block.call item
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    each do |data|
      yield data, i

      i += 1
    end
  end

  # my_select function
  def my_select
    # filters a given array
    #  given a filter, return the modified array
    return to_enum(:my_select) unless block_given?

    array = []
    each do |item|
      array << item if yield(item)
    end
    array
  end

  # my_all function
  def my_all?(param = nil)
    if param.nil?
      if block_given?
        each do |item|
          return false unless yield(item)
        end

        true
      else
        y = 0
        each do |x|
          y += 1 unless x == false || x.nil?
        end
        y == size
      end
    else
      each do |item|
        return false unless item.is_a?(parameter)
      end

      true
    end
  end

  # my_any?
  def my_any?; end

  # my_none?
  def my_none?; end

  # my_count
  def my_count
    count = 0
    my_each do |item|
      if block_given?
        count += 1 if yield item
      else
        count += 1
      end
    end
  end

  # my_map
  def my_map; end

  # my_inject
  def my_inject; end
end

#### test normal select
# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

# puts /t/.class
# my_array = %w[ant bear cat]
# # p [nil, true, 99].my_all?{|block| block.length >= 1}
# p [false].my_all?

p [1, 2, 3, 4].count
