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
end
