require 'rspec'
require_relative '../model/license'

describe License do
  it 'should have properties set' do
    license = described_class.new(2, 200, ['artear'])
    expect(license.amount_of_repetitions).to eq(2)
    expect(license.repetition_frequency).to eq(200)
    expect(license.signals).to eq(['artear'])
  end

  it 'remove_signal should remove the signal' do
    license = described_class.new(2, 200, ['artear'])
    license.remove_signal('artear')
    expect(license.signals.size).to eq(0)
  end

  it 'add_signal should add the signal' do
    license = described_class.new(2, 200, ['artear'])
    license.add_signal('artear')
    expect(license.signals.size).to eq(0)
  end
end
