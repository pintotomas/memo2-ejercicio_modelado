require 'rspec'
require_relative '../model/contract'

describe Contract do
  describe 'contract' do
    it { is_expected.to respond_to(:info) }
    it { is_expected.to respond_to(:frequency) }
    it { is_expected.to respond_to(:cost) }
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:amendments) }
  end

  describe 'initialize' do
    it 'should set frequency of the content' do
      freq = 5
      contract = described_class.new(frequency: freq)
      expect(contract.frequency).to eq(freq)
    end

    it 'should set the cost of the content' do
      cost = 5000
      contract = described_class.new(cost: cost)
      expect(contract.cost).to eq(cost)
    end

    it 'should set the info of the content' do
      info = 'this is the contract with WB'
      contract = described_class.new(info: info)
      expect(contract.info).to eq(info)
    end

    # it 'get version' do
    #   info = "this is the contract with WB"
    #   contract = described_class.new(info: info)
    #   a1 = amendments.new
    #   contract.add_amendments(a1)
    #   expect(contract.version).to eq(1)
    # end
  end
end
