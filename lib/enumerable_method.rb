# rubocop:disable Style/Documentation
module Enumerable
  def my_each(&block)
    return enum_for(:my_each) unless block_given?

    for item in self
      block.call item
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |data|
      yield data, i

      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    to_a if self.class.instance_of? Range
    elements = []
    my_each do |item|
      elements << item if yield(item)
    end
    elements
  end

  def my_all?(parameter = nil)
    if !parameter.nil?
      flag = true
      if parameter.class.instance_of? Class
        my_each { |i| flag = false unless parameter === i }
      elsif parameter.instance_of? Regexp
        my_each { |i| flag = false unless parameter.match? i }
      end
      flag
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

  def my_any?(parameter = nil)
    if !parameter.nil?
      flag = false
      if parameter.instance_of? Class
        my_each { |i| flag = true if parameter === i }
      elsif parameter.instance_of? Regexp
        my_each { |i| flag = true if parameter.match? i }
      else
        my_each { |item| flag = true if parameter == item }
      end
      flag
    elsif block_given?
      my_each do |element|
        return true if yield(element)
      end
      false
    else
      my_each do |x|
        return true unless x == false || x.nil?
      end
      false
    end
  end

  def my_none?(parameter = nil)
    if !parameter.nil?
      if parameter.instance_of? Regexp
        return (my_select { |item| item.match(parameter) }).length.zero? if parameter.is_a? Regexp
      elsif parameter.instance_of? Class
        count = 0
        for item in self
          flag = false if item.instance_of? parameter
          count += 1 if flag == false
        end
        if count.positive?
          false
        else
          true
        end
      else
        flag = true
        my_each { |i| flag = false if parameter == i }
        flag
      end
    elsif block_given?
      my_each do |element|
        return false if yield(element)
      end
      true
    else
      my_each do |x|
        return false unless x == false || x.nil?
      end
      true
    end
  end

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

  def my_inject(pa1 = nil, pa2 = nil)
    data = to_a
    if pa1.nil? && pa2.nil? && !block_given?
      raise LocalJumpError

    elsif pa1.nil? && block_given?
      data.length.times do |item|
        pa1 = data[item] if item.zero?
        pa1 = yield(pa1, data[item]) unless item.zero?
      end

    elsif block_given?
      data.length.times do |item|
        pa1 = yield(pa1, data[item])
      end

    elsif pa2.nil? && !pa1.nil?
      pa2 = pa1
      data.length.times do |item|
        pa1 = data[0] if item.zero?
        pa1 = pa1.send(pa2, data[item]) unless item.zero?
      end

    elsif pa2.is_a?(Symbol) && !pa1.nil?
      data.length.times do |item|
        pa1 = pa1.send(pa2, data[item])
      end
    end

    pa1
  end

  def multiply_els(para)
    para.my_inject { |num1, num2| num1 * num2 }
  end
end
# rubocop:enable Style/Documentation
