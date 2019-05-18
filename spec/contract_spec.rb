require 'rspec'
require_relative '../model/contract'
require_relative '../model/amendment'
require_relative '../model/info_amendment'
require_relative '../model/frequency_amendment'
require_relative '../model/mont_amendment'
require_relative '../exceptions/update_contract_error'

describe Contract do
  describe 'contract' do
    it { is_expected.to respond_to(:info) }
    it { is_expected.to respond_to(:frequency) }
    it { is_expected.to respond_to(:mont) }
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:amendments) }
  end

  describe 'initialize' do
    it 'should set frequency of the content' do
      freq = 5
      contract = described_class.new(frequency: freq)
      expect(contract.frequency).to eq(freq)
    end

    it 'should set the mont of the content' do
      mont = 5000
      contract = described_class.new(mont: mont)
      expect(contract.mont).to eq(mont)
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

  describe 'change confirmated contract ' do
    it 'The confirmed contract should not be able to be changed' do
      info = 'this is the contract with WB'
      contract = described_class.new(info: info)
      contract.confirmed = true
      another_info = 'this is the contract with TNT'
      expect { contract.change_info(another_info) }.to raise_error(UpdateContractError)
    end
  end

  it 'I should add an mont amendment' do
    info = 'this is the contract with WB'
    contract = described_class.new(info: info)
    mont_amendment = MontAmendment.new(100)
    contract.add_amendments(mont_amendment)
    expect(contract.amendments.length).to eq(1)
  end
end
