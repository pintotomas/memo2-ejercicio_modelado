require 'rspec'
require_relative '../model/contract'
require_relative '../model/amendment'
require_relative '../model/mont_amendment'
require_relative '../model/license'
require_relative '../exceptions/update_contract_error'

describe Contract do
  describe 'contract' do
    it { is_expected.to respond_to(:signature_date) }
    it { is_expected.to respond_to(:client) }
    it { is_expected.to respond_to(:mont) }
    it { is_expected.to respond_to(:contents) }
    it { is_expected.to respond_to(:license) }
    it { is_expected.to respond_to(:amendments) }
    it { is_expected.to respond_to(:confirmed) }
  end

  it 'should have properties' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
    date = Date.new
    license = License.new(2, 200, ['volver'])
    contract = described_class.new(signature_date: date, client: 'artear', mont: 5000,
                                   contents: ['Volver al futuro'], license: license)
    expect(contract.signature_date).to eq(date)
    expect(contract.client).to eq('artear')
    expect(contract.mont).to eq(5000)
    expect(contract.contents).to eq(['Volver al futuro'])
    expect(contract.license).to eq(license)
    expect(contract.amendments).to eq([])
    expect(contract.confirmed).to eq(false)
  end

  describe 'change confirmated contract' do
    it 'confirmed contract should not be able to be changed' do
      contract = described_class.new(mont: 2000)
      contract.confirmed = true
      expect { contract.change_mont(1000) }.to raise_error(UpdateContractError)
    end
  end

  it 'mont amendment is added ok' do
    contract = described_class.new
    mont_amendment = MontAmendment.new(100)
    contract.add_amendment(mont_amendment)
    expect(contract.amendments.size).to eq(1)
  end
end
