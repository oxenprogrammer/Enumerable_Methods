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
end
