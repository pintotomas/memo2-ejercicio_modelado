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
end
