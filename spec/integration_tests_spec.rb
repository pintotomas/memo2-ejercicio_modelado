require 'rspec'
require_relative '../model/contract'
require_relative '../model/contract_decorator'
require_relative '../model/amendment'
require_relative '../model/mont_amendment'
require_relative '../model/frequency_amendment'
require_relative '../model/license'
require_relative '../exceptions/update_contract_error'
require_relative '../exceptions/contract_must_have_content_error'

describe 'Integration tests' do
  ## Ejemplo 1: contrato sin confirmar se puede modificar
  let(:contract_with_amendments) do
    license = License.new(1, 1, %w[volver canal13])
    contract = Contract.new(client: 'artear', contents: ['Volver al futuro'],
                            mont: 100, license: license)
    contract.confirm
    contract.add_amendment(MontAmendment.new(50))
    contract.add_amendment(FrequencyAmendment.new(7))
    contract
  end

  it 'Can modify a contract without confirmation' do
    license = License.new(1, 1, %w[volver canal13])
    contract = Contract.new(client: 'artear', contents: ['Volver al futuro'],
                            mont: 10_000, license: license)
    contract.change_mont(200_000)
    expect(contract.mont).to eq 200_000
  end
  it 'Cant modify a contract after confirmation' do
    license = License.new(1, 1, %w[volver canal13])
    contract = Contract.new(client: 'artear', contents: ['Volver al futuro'],
                            mont: 10_000, license: license)
    contract.confirm

    expect { contract.change_mont(200_000) }.to raise_error(UpdateContractError)
  end
  it 'Cant amend a contract without confirmation' do
    license = License.new(1, 1, %w[volver canal13])
    contract = Contract.new(client: 'artear', contents: ['Volver al futuro'],
                            mont: 10_000, license: license)
    expect { contract.add_amendment('amendment') }.to raise_error(CantAddAmendments)
  end
  it 'Amend a contract mont after confirmation, and old version should not be affected' do
    license = License.new(1, 1, %w[volver canal13])
    contract = Contract.new(client: 'artear', contents: ['Volver al futuro'],
                            mont: 10_000, license: license)
    contract.confirm
    contract.add_amendment(MontAmendment.new(200_000))
    expect(ContractDecorator.new.get_contract_version(contract, 1).mont).to eq 200_000
    expect(ContractDecorator.new.get_contract_version(contract, 0).mont).to eq 10_000
  end

  it 'Amend a contract mont and freq after confirm, check original version' do
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 0).mont).to eq 100
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 0).license.repetition_frequency).to eq 1
  end
  it 'Amend a contract mont and freq after confirm, check first version' do
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 1).license.repetition_frequency).to eq 1
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 1).mont).to eq 50
  end
  it 'Amend a contract mont and freq after confirm, check last version' do
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 2).license.repetition_frequency).to eq 7
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 2).mont).to eq 50
  end
  it 'Amend a contract mont and freq after confirm, should not affect amount of repetitions' do
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 2).license.amount_of_repetitions).to eq 1
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 1).license.amount_of_repetitions).to eq 1
    expect(ContractDecorator.new.get_contract_version(contract_with_amendments, 0).license.amount_of_repetitions).to eq 1
  end
end
