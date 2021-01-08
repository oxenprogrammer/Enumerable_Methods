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
  def my_inject(p1 = nil, p2 = nil)
    data = to_a
    # Through Error if Parameter and block are not given
    if p1.nil? and p2.nil? and !block_given?
      return  "Required Block or Parameter"
    # Block is given and parameter is given but its value is nil
    elsif p1.nil? and block_given?
      data.length.times do |item|
        if item == 0
          p1 = data[item]
        else
          p1 = yield(p1, data[item])
        end 
      end

    # Only Block given
    elsif block_given?
      data.length.times do |item|
        p1 = yield(p1, data[item])
      end

    # Parameter 1 is not nil and parameter 2 is nil
    elsif p2.nil? and !p1.nil? 
      p2 = p1
      data.length.times do |item|
        if item == 0
          p1 = arr[0]
        else
          p1 = p1.send(p2, arr[item]) 
        end
      end

    # Parameter 1 given and Parameter 2 given but equal to Symbol
    elsif p2.is_a?(Symbol) and !p1.nil?
      data.length.times do |item|
        p1 = p1.send(p2, data[item])
      end
    end

    p1
  end
end


