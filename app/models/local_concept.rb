class LocalConcept < ActiveRecord::Base
  def name
    return self.STR.humanize.gsub(/\b('?[a-z])/) { $1.capitalize } rescue ""
  end

  def aui
    return self.RXAUI
  end

  def cui
    return self.RXCUI
  end
end
