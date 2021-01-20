# rubocop:disable Layout/LineLength
# rubocop:disable Metrics/BlockLength
# spec/game_logic_test_spec.rbc

require '../lib/enumerable_method'

describe Enumerable do
  let(:my_range) { Range.new(1, 10) }
  describe '#my_each' do
    it 'would return Enumarator if there\'s no block' do
      expect([1, 2, 3, 4, 5].my_each).to be_an(Enumerator)
    end

    it 'would return the operation in the block when received a block' do
      expect([1, 2, 3, 4, 5].my_each { |item| p item }).to eql([1, 2, 3, 4, 5])
      # since each don't mutate the original array
    end

    it 'would loop throud in array in execute the block statements on each item' do
      expect(my_range.my_each { |item| p item * 2 }).to eql(my_range.each { |item| p item * 2 })
    end
  end

  describe '#my_select' do
    it 'would return the operation in the block when received a block' do
      expect([1, 2, 3, 4].my_select { |item| item > 2 }).to eql([3, 4])
    end

    it 'would return Enumarable if there\'s no block' do
      expect([1, 2, 3, 4, 5].my_select).to be_an(Enumerator)
    end

    it 'would return the same thing as the original select method' do
      expect([1, 2, 3, 4].my_select { |item| item > 2 }).to eql([1, 2, 3, 4].select { |item| item > 2 })
    end
  end

  describe '#my_any?' do
    it 'it check if there false element in an array' do
      expect([1, 2, 3, false, 4].my_any?).to eql([1, 2, 3, false, 4].any?)
    end

    it 'check if there\'s a symbol in an array' do
      expect([1, :none, 2].my_any? { |item| item.is_a?(Symbol) }).to eql([1, :none, 2].any? { |item| item.is_a?(Symbol) })
    end

    it 'check if there\'s a falsy element' do
      expect([1, 2, false].my_any?(false)).to eql([1, 2, false].my_any?(false))
    end

    it 'check if there\'s a true element' do
      expect([1, 2, true].my_any?(true)).to eql([1, 2, true].my_any?(true))
    end

    it 'check if there\'s a specific string' do
      expect([1, 2, 'npm'].my_any?('npm')).to eql([1, 2, 'npm'].my_any?('npm'))
    end
  end

  describe '#my_none?' do
    it 'check if there\'s a symbol in an array' do
      expect([1, :none, 2].my_none? { |item| item.is_a?(Symbol) }).to eql([1, :none, 2].none? { |item| item.is_a?(Symbol) })
    end

    it 'check if a range have not something specified in a block' do
      expect(my_range.my_none? { |item| item > 4 }).to eql(false)
    end

    it 'return true if don\'t found NUmeric class' do
      expect(my_range.my_none?(Numeric)).to eql(true)
    end

    it 'return true if it don\'t found string class' do
      expect(my_range.my_none?(String)).to eql(true)
    end
  end

  describe '#my_map' do
    it 'return an array from a range and apply a block statement to the range' do
      expect(my_range.my_map { |item| item * 1 }).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    end

    it 'return an array from an array and apply a block statement to the array' do
      expect([1, 2, 3, 4].my_map { |item| item * 1 }).to eql([1, 2, 3, 4])
    end
  end
end
# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/BlockLength
