class ContractDecorator
  def get_contract_version(contract, version)
    return contract if version.zero?

    @contract_version = Contract.new(signature_date: contract.signature_date,
                                     client: contract.client, mont: contract.mont,
                                     contents: contract.contents,
                                     license: clone_license(contract))

    @version = get_version(contract, version)
    (0..@version - 1).each do |i|
      contract.amendments[i].apply(@contract_version)
    end
    @contract_version
  end

  private

  def get_version(contract, version)
    current_version = version
    current_version = contract.amendments.size if contract.amendments.size < version
    current_version
  end

  def clone_license(contract)
    License.new(contract.license.amount_of_repetitions,
                contract.license.repetition_frequency,
                contract.license.signals)
  end
end
