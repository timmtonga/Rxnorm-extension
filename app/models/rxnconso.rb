class Rxnconso < ActiveRecord::Base
  self.table_name = 'RXNCONSO'
  self.primary_key = 'RXAUI'
  #default_scope {-> { where "#{self.table_name}.SUPPRESS = 'O'" }}

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
