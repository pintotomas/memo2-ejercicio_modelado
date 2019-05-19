require 'rspec'
require_relative '../model/contract'
require_relative '../model/amendment'
require_relative '../model/mont_amendment'
require_relative '../model/license'
require_relative '../exceptions/update_contract_error'
require_relative '../exceptions/contract_must_have_content_error'

describe Contract do
  let(:initial_contract) { described_class.new(contents: ['300']) }

  describe 'contract' do
    it { expect(initial_contract).to respond_to(:signature_date) }
    it { expect(initial_contract).to respond_to(:client) }
    it { expect(initial_contract).to respond_to(:mont) }
    it { expect(initial_contract).to respond_to(:contents) }
    it { expect(initial_contract).to respond_to(:license) }
    it { expect(initial_contract).to respond_to(:amendments) }
    it { expect(initial_contract).to respond_to(:confirmed) }
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
    it 'confirmed contract should not be able to be change mont' do
      contract = described_class.new(mont: 2000, contents: ['Volver al futuro'])
      contract.confirmed = true
      expect { contract.change_mont(1000) }.to raise_error(UpdateContractError)
    end

    it 'confirmed contract should not be able to be change signature_date' do
      contract = described_class.new(signature_date: Date.new, contents: ['Volver al futuro'])
      contract.confirmed = true
      expect { contract.change_signature_date(Date.new) }.to raise_error(UpdateContractError)
    end

    it 'confirmed contract should not be able to be change client' do
      contract = described_class.new(client: 2000, contents: ['Volver al futuro'])
      contract.confirmed = true
      expect { contract.change_client('pepsi') }.to raise_error(UpdateContractError)
    end

    it 'confirmed contract should not be able to be change content' do
      contract = described_class.new(content: ['Volver al futuro'], contents: ['Volver al futuro'])
      contract.confirmed = true
      expect { contract.add_content('Volver al futuro II') }.to raise_error(UpdateContractError)
      expect { contract.remove_content('Volver al futuro') }.to raise_error(UpdateContractError)
    end
  end

  it 'mont amendment is added ok' do
    contract = described_class.new(contents: ['Volver al futuro'])
    mont_amendment = MontAmendment.new(100)
    contract.add_amendment(mont_amendment)
    expect(contract.amendments.size).to eq(1)
  end

  it 'content is added ok' do
    contract = described_class.new(contents: ['Volver al futuro'])
    contract.add_content('Volver al futuro II')
    expect(contract.contents.size).to eq(2)
  end

  it 'content is removed ok' do
    contract = described_class.new(contents: ['Volver al futuro', 'Volver al futuro 2'])
    contract.remove_content('Volver al futuro')
    expect(contract.contents.size).to eq(1)
  end

  it 'contract must have content' do
    expect { described_class.new }.to raise_error(ContractMustHaveContentError)
  end

  it 'cant remove content if there is only one' do
    contract = described_class.new(contents: ['Volver al futuro'])
    expect { contract.remove_content('Volver al futuro') }
      .to raise_error(ContractMustHaveContentError)
  end
end
