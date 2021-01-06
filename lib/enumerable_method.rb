module Enumerable
  def my_each
    return nil unless block_given?
    each do |param|
      yield param
    end
  end
end

my_array = [1, 2,3,4]

using_each = my_array.my_each

using_each

