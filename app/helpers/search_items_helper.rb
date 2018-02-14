module SearchItemsHelper
  def potential_matches(record)
    results = {}
    options = record.potential_matches.split(',') rescue []
    (options || []).each do |option|
      results[option] = Rxnconso.find_by_RXAUI(option).STR rescue ''
    end
    results['none'] = 'No Match Found'
    return results
  end
end
