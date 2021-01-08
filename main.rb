require_relative 'lib/enumerable_method'

# ## test for any
# p %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
# p [nil, true, 99].any?                              #=> true
# p [].any?                                           #=> false
# p %w[ant bear cat].any?(/d/)                        #=> false
# p [nil, true, 99].any?(Integer)                     #=> true
# puts "\n\n"
# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p [nil, true, 99].my_any?                              #=> true
# p [].my_any?                                           #=> false
# p %w[ant bear cat].my_any?(/d/)                        #=> false
# p [nil, true, 99].my_any?(Integer)                     #=> true

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

# #### test for injection
# p (5..10).inject { |sum, n| sum + n }            #=> 45
# p (5..10).inject(1) { |product, n| product * n } #=> 151200
# longest = %w{ cat sheep bear }.inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest                                        #=> "sheep"
# puts "\n\n"
# p (5..10).my_inject            #=> 45
# p (5..10).my_inject { |sum, n| sum + n }            #=> 45
# p (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# longest = %w{ cat sheep bear }.my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest                                        #=> "sheep"

### Test for my_none
p %w[ant bear cat].none? { |word| word.length == 5 } #=> true
p %w[ant bear cat].none? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].none?(/d/)                        #=> true
p [1, 3.14, 42].none?(Float)                         #=> false
p [].none?                                           #=> true
p [nil].none?                                        #=> true
p [nil, false].none?                                 #=> true
p [nil, false, true].none?                           #=> false
puts "\n\n"
p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false

# p "\n\n"
# [nil, false,true].num?

p '############### Test for Count'
ary = [1, 2, 4, 2]
p(ary.count) #=> 4
p(ary.count(2)) #=> 2
p(ary.count(&:even?)) #=> 3
