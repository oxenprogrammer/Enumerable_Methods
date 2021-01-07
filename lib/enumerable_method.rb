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
  def my_all?( parameter = nil )

    if parameter != nil
      for item in self
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
  def my_any?(parameter = nil)
    # for parameter
    if parameter != nil
      count = 0
      for item in self
        flag = false if item.class == parameter
        if flag == false
          count += 1 
        end
      end

      if count > 0
        return true
      else
        return false
      end
    # for black_given
    elsif block_given?
      self.each do |item| 
        return true if yield(item)
      end
      return false

    # for without block and parameter
    else
      self.each do |x|
       return true unless (x==false || x.nil?)
      end
      return false
    end

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

### test for any
p %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
p [nil, true, 99].any?                              #=> true
p [].any?                                           #=> false
p %w[ant bear cat].any?(/d/)                        #=> false
p [nil, true, 99].any?(Integer)                     #=> true
puts "\n\n"
p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p [nil, true, 99].my_any?                              #=> true
p [].my_any?                                           #=> false
p %w[ant bear cat].my_any?(/d/)                        #=> false
p [nil, true, 99].my_any?(Integer)                     #=> true

# #### test case of all
# p %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
# p [nil, true, 99].all?                              #=> false
# p [].all?                                           #=> true
# p %w[ant bear cat].all?(/t/)                        #=> false
# p [1, 2i, 3.14].all?(Numeric)                       #=> true
# puts"\n\n"
# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true