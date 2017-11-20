class Rxnconso < ActiveRecord::Base
  self.table_name = 'RXNCONSO'
  self.primary_key = 'RXAUI'

  def name
    return self.STR.humanize.gsub(/\b('?[a-z])/) { $1.capitalize } rescue ""
  end

end
