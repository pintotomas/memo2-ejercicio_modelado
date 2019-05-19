require 'rspec'
require 'byebug'
require_relative '../model/contract'
require_relative '../model/contract_decorator'
require_relative '../model/amendment'
require_relative '../model/mont_amendment'
require_relative '../model/frequency_amendment'
require_relative '../model/license'
require_relative '../exceptions/update_contract_error'
require_relative '../exceptions/contract_must_have_content_error'

describe ContractDecorator do
  let(:initial_contract) do
    Contract.new(signature_date: Date.new, client: 'artear', mont: 5000,
                 contents: ['Volver al futuro'], license: License.new(2, 200, ['volver']))
  end
  let(:contract_decorator) { described_class.new }

  it 'returns original if version is 0' do
    mont_amendment = MontAmendment.new(100)
    initial_contract.add_amendment(mont_amendment)
    contract_version = contract_decorator.get_contract_version(initial_contract, 0)
    expect(contract_version.mont).to eq(5000)
  end

  it 'applies mont amendment' do
    mont_amendment = MontAmendment.new(100)
    initial_contract.add_amendment(mont_amendment)
    contract_version = contract_decorator.get_contract_version(initial_contract, 1)
    expect(contract_version.mont).to eq(100)
  end

  it 'applies frequency amendment' do
    freq_amendment = FrequencyAmendment.new(4)
    initial_contract.add_amendment(freq_amendment)
    contract_version = contract_decorator.get_contract_version(initial_contract, 1)
    expect(contract_version.license.repetition_frequency).to eq(4)
  end

  it 'applies only first amendment if version is 1' do
    initial_contract.add_amendment(FrequencyAmendment.new(4))
    initial_contract.add_amendment(MontAmendment.new(100))
    contract_version = contract_decorator.get_contract_version(initial_contract, 1)
    expect(contract_version.license.repetition_frequency).to eq(4)
    expect(contract_version.mont).to eq(5000)
  end
end
