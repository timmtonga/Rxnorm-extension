class LocalConcept < ActiveRecord::Base

  #validates_uniqueness_of :RXAUI
  before_create :complete_record

  def name
    return self.STR.humanize.gsub(/\b('?[a-z])/) { $1.capitalize } rescue ""
  end

  def aui
    return self.RXAUI
  end

  def cui
    return self.RXCUI
  end

  def complete_record
    self.SAB = 'LEXT' if self.SAB.blank?
    self.LAT = 'ENG' if self.LAT.blank?
    self.SUPPRESS = 'N'
    self.RXCUI = next_concept_num if self.RXCUI.blank?
    self.RXAUI = next_atom_num
  end

  def add_relationships(concept, relatives, relationship)
    (relatives || []).each do |relative|
      LocalRelationship.create(RXCUI1: concept, RXCUI2: relative,SAB: 'LEXT', REL: relationship )
    end
  end

  private
  def next_concept_num
    last_cui = LocalConcept.select(:RXCUI).where("left(RXCUI, 1) = 'C'").order('RXCUI DESC').first.cui rescue 0
    last_cui = last_cui.gsub('C','') rescue 0
    return "C#{last_cui.to_i + 1}"
  end

  def next_atom_num
    last_aui = LocalConcept.select(:RXAUI).where("left(RXAUI, 1) = 'A'").order('ID DESC').first.aui rescue 0
    last_aui = last_aui.gsub('A','') rescue 0
    return "A#{last_aui.to_i + 1}"
  end
end
