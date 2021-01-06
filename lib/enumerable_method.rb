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

end

my_array = ['abdl', 'cat','dog']

hash = Hash.new
my_array.my_each_with_index

#### test normal select
p my_array.my_select {|item| item.length.even? }
