require 'rspec'
require_relative '../model/license'
require_relative '../model/contract'

describe License do
  let(:contract) { Contract.new(contents: ['back to the future']) }
  let(:license) { described_class.new(2, 200, ['volver']) }

  it 'should have properties set' do # rubocop:disable RSpec/MultipleExpectations
    expect(license.amount_of_repetitions).to eq(2)
    expect(license.repetition_frequency).to eq(200)
    expect(license.signals).to eq(['volver'])
    expect(license.contract).to eq(nil)
  end

  it 'remove_signal should remove the signal' do
    license.contract = contract
    license.remove_signal('volver')
    expect(license.signals.size).to eq(0)
  end

  it 'add_signal should add the signal' do
    license.contract = contract
    license.add_signal('volver')
    expect(license.signals.size).to eq(2)
  end

  describe 'change license with confirmated contract' do
    it 'license with confirmed contract should not be able to change signals' do
      contract.confirmed = true
      license.contract = contract
      expect { license.add_signal('canal 13') }.to raise_error(UpdateContractError)
      expect { license.remove_signal('volver') }.to raise_error(UpdateContractError)
    end

    it 'license with confirmed contract should not be able to change amount_of_repetitions' do
      contract.confirmed = true
      license.contract = contract
      expect { license.change_amount_of_repetitions(10) }.to raise_error(UpdateContractError)
    end

    it 'license with confirmed contract should not be able to change repetition_frequency' do
      contract.confirmed = true
      license.contract = contract
      expect { license.change_repetition_frequency(6000) }.to raise_error(UpdateContractError)
    end
  end
end
