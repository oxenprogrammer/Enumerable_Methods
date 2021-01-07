module Enumerable
 # my_each
  def my_each
    return enum_for(:my_each) unless block_given?
    each do |param|
      yield param
    end
  end

  #my_each_with_index
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
      array << item  if yield(item)
    end
    array
  end

  # my_all function
  def my_all?(parameter = nil)
    unless parameter == nil 
      self.each do |item|
        return false unless item.kind_of?(parameter)
      end

      return true
    else
      if block_given?
        self.each do |item| 
          return false unless yield(item)
        end

        return true
      else
        y=0
        self.each do |x|
         y += 1 unless (x==false || x.nil?)
        end
        if y == self.size 
          true 
        else 
          false
        end
      end
    end
  end


  # my_any?
  def my_any?
  end

  #my_none?
  def my_none?
  end

  #my_count
  def my_count
  end

  #my_map
  def my_map
  end

  #my_inject
  def my_inject
  end
end

#### test normal select
# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

puts /t/.class
# my_array = %w[ant bear cat]
# # p [nil, true, 99].my_all?{|block| block.length >= 1}
# p [false].my_all?

