# This is our custom fake enumerables
module Enumerable
  # my_each
  def my_each(&block)
    return enum_for(:my_each) unless block_given?

    for item in self
      block.call item
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |data|
      yield data, i

      i += 1
    end
    self
  end

  # my_select function
  def my_select
    return to_enum(:my_select) unless block_given?

    to_a if self.class.instance_of? Range
    elements = []
    my_each do |item|
      elements << item if yield(item)
    end
    elements
  end

  # my_all function
  def my_all?(parameter = nil)
    if !parameter.nil?
      if parameter.is_a? Regexp
        my_each do |item|
          num = item.to_s
          return true if num == parameter
        end

        false
      else
        my_each { |item| return false unless item.is_a?(parameter) }
        true
      end
    else
      if block_given?
        each do |item|
          return false unless yield(item)
        end

        true
      else
        y = 0
        my_each do |x|
          y += 1 unless x == false || x.nil?
        end
        true if y == size
        y == size
      end
    end
  end

  # my_any?
  def my_any?(parameter = nil)
    # for parameter
    if !parameter.nil?
      count = 0
      for item in self
        flag = false if item.class == parameter
        count += 1 if flag == false

      end

      if count.positive?
        true
      else
        false
      end
    # for black_given
    elsif block_given?
      my_each do |element|
        return true if yield(element)
      end
      false

    # for without block and parameter
    else
      my_each do |x|
        return true unless x == false || x.nil?
      end
      false
    end
  end

  # my_none?
  def my_none?(parameter = nil)
    # for parameter
    if !parameter.nil?
      count = 0
      for item in self
        flag = false if item.class == parameter
        count += 1 if flag == false
      end
      if count.positive?
        false
      else
        true
      end
    # for black_given
    elsif block_given?
      my_each do |element|
        return false if yield(element)
      end
      true

    # for without block and parameter
    else
      my_each do |x|
        return false unless x == false || x.nil?
      end
      true
    end
  end

  # my_count
  def my_count(obj = nil)
    count = 0
    my_each do |item|
      if obj
        count += 1 if obj == item
      elsif block_given?
        count += 1 if yield item
      else
        count += 1
      end
    end
    count
  end

  # my_map
  def my_map(proc = nil)
    return enum_for(:my_map) if proc.nil? && !block_given?

    to_a if self.class.instance_of? Range
    item = []

    my_each do |element|
      item << if proc.instance_of?(Proc)
                proc.call(element)
              else
                yield(element)
              end
    end
    item
  end

  # my_inject
  def my_inject(pa1 = nil, pa2 = nil)
    data = to_a
    # Through Error if Parameter and block are not given
    if pa1.nil? && pa2.nil? && !block_given?
      raise LocalJumpError
    # Block is given and parameter is given but its value is nil
    elsif pa1.nil? && block_given?
      data.length.times do |item|
        pa1 = data[item] if item.zero?
        pa1 = yield(pa1, data[item]) unless item.zero?
      end

    # Only Block given
    elsif block_given?
      data.length.times do |item|
        pa1 = yield(pa1, data[item])
      end

    # Parameter 1 is not nil and parameter 2 is nil
    elsif pa2.nil? && !pa1.nil?
      pa2 = pa1
      data.length.times do |item|
        pa1 = data[0] if item.zero?
        pa1 = pa1.send(pa2, data[item]) unless item.zero?
      end

    # Parameter 1 given and Parameter 2 given but equal to Symbol
    elsif pa2.is_a?(Symbol) && !pa1.nil?
      data.length.times do |item|
        pa1 = pa1.send(pa2, data[item])
      end
    end

    pa1
  end
end
