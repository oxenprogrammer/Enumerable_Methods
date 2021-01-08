require_relative 'lib/enumerable_method.rb'

#### test for my_any
puts "\n\n my_any"
p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p [nil, true, 99].my_any?                              #=> true
p [].my_any?                                           #=> false
p %w[ant bear cat].my_any?(/d/)                        #=> false
p [nil, true, 99].my_any?(Integer)                     #=> true

#### test case of my_all
puts"\n\n my_all"
p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p [nil, true, 99].my_all?                              #=> false
p [].my_all?                                           #=> true
p %w[ant bear cat].my_all?(/t/)                        #=> false
p [1, 2i, 3.14].my_all?(Numeric)                       #=> true

#### test for my_inject
puts "\n\n my_inject"
p (5..10).my_inject            #=> 45
p (5..10).my_inject { |sum, n| sum + n }            #=> 45
p (5..10).my_inject(1) { |product, n| product * n } #=> 151200
longest = %w{ cat sheep bear }.my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
p longest                                        #=> "sheep"


### Test for my_none
puts "\n\n my_none"
p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p %w{ant bear cat}.my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false

#### Test for my_each_with_index
puts "\n\n my_each_with_index"
hash = Hash.new
p %w(cat dog wombat).my_each_with_index { |item, index|
  hash[item] = index
} #=> {"cat"=>0, "dog"=>1, "wombat"=>2}

#### Test for my_select
puts "\n\n my_select"
p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

#### Test for my_count
puts "\n\n my_count"
ary = [1, 2, 4, 2]
p ary.my_count               #=> 4
p ary.my_count(2)            #=> 2
p ary.my_count{ |x| x%2==0 } #=> 3

#### Test for my_map
puts "\n\n my_map"
p [1,2,3,4].my_map { |i| i*i }      #=> [1, 4, 9, 16]
