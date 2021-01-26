require_relative './../lib/enumerable_method'

describe '#Enumerable' do
  describe '#Each' do
    it 'should return an array' do
      expect([1, 2, 3, 4].my_each { |x| x }).to eql [1, 2, 3, 4]
    end
    it 'should return a range' do
      expect((1..4).my_each { |x| x }).to eql(1..4)
    end
    it 'should return an enumerable' do
      expect((1..4).my_each).to be_a Enumerator
    end
  end

  describe '#Each With Index' do
    hash = {}
    test1 = %w[cat dog wombat].my_each_with_index do |item, index|
      hash[item] = index
    end
    it 'should return an array' do
      expect(test1).to eql %w[cat dog wombat]
    end
    it 'should return an enumerable' do
      expect((1..4).my_each_with_index).to be_a Enumerator
    end
  end

  describe '#Select' do
    select1 = [1, 2, 3, 4, 5].my_select(&:even?)
    select2 = (1..5).my_select(&:even?)
    it 'should return the filtered array' do
      expect(select1).to eql [2, 4]
    end
    it 'should return the filtred array' do
      expect(select2).to eql [2, 4]
    end
    it 'should return an enumerable' do
      expect((1..4).my_select).to be_a Enumerator
    end
  end

  describe '#Count' do
    my_array = [1, 2, 4, 2]

    it 'should return the count 4' do
      expect(my_array.my_count).to eql 4
    end
    it 'should return the count 2' do
      expect(my_array.my_count(2)).to eql 2
    end
    it 'should return the count 3' do
      expect(my_array.my_count(&:even?)).to eql 3
    end
  end

  describe '#Map' do
    elements = [1, 2, 3, 4]
    my_proc = proc { |i| i * i }
    second_proc = nil

    it 'should return an array doubled given an array' do
      expect(elements.my_map { |i| i * i }).to eql [1, 4, 9, 16]
    end
    it 'should return cats each to array length' do
      expect(elements.my_map { 'cat' }).to eql %w[cat cat cat cat]
    end
    it 'should return an array doubled a range' do
      expect((1..4).my_map { |i| i * i }).to eql [1, 4, 9, 16]
    end
    it 'should return cats each to the range length' do
      expect((1..4).my_map { 'cat' }).to eql %w[cat cat cat cat]
    end
    it 'should return an array given a proc' do
      expect(elements.my_map(my_proc)).to eql [1, 4, 9, 16]
    end
    it 'should return an enumerable' do
      expect(elements.my_map(second_proc)).to be_a Enumerator
    end
  end
  describe '#Any' do
    elements = %w[ant bear cat]
    it 'should return true for all true' do
      expect(elements.my_any? { |word| word.length >= 3 }).to be true
    end
    it 'should return true for one match' do
      expect(elements.my_any? { |word| word == 'cat' }).to be true
    end
    it 'should return true for at least a true' do
      expect([nil, true, false].my_any?).to be true
    end
    it 'should return false if all is false' do
      expect([nil, false].my_any?).to be false
    end
    it 'should return false if none matches' do
      expect(elements.my_any?(/d/)).to be false
    end
    it 'should return true if given an instance of any' do
      expect([nil, true, 99].my_any?(Integer)).to be true
    end
  end

  describe '#All' do
    elements = %w[ant bear cat]
    it 'should return true for all true' do
      expect(elements.my_all? { |word| word.length >= 3 }).to be true
    end
    it 'should return false for one match' do
      expect(elements.my_all? { |word| word == 'cat' }).to be false
    end
    it 'should return false for at least a false' do
      expect(['a', true, false].my_all?).to be false
    end
    it 'should return false if all is false' do
      expect([nil, false].my_all?).to be false
    end
    it 'should return false if none matches' do
      expect(elements.my_all?(/d/)).to be false
    end
    it 'should return false if given only one instance' do
      expect([nil, true, 99].my_all?(Integer)).to be false
    end
  end
end
