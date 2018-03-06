class LocalRelationship < ActiveRecord::Base
  before_create :complete_record
  after_create :check_opposite

  def opp_rel
    relationships[self.REL]
  end

  def check_opposite
    opp_rel = LocalRelationship.where(RXCUI1: self.RXCUI2, RXCUI2: self.RXCUI1,REL: self.opp_rel).first_or_initialize
    if opp_rel.SAB.blank?
      opp_rel.SAB = 'LEXT'
      opp_rel.STYPE1 = 'CUI'
      opp_rel.STYPE2 = 'CUI'
      opp_rel.save
    end
  end

  def complete_record
    self.SUPPRESS = 'N'
    self.STYPE1 = 'CUI'
    self.STYPE2 = 'CUI'
  end

  private
  def relationships
    rel = {'ingredient_of' => 'has_ingredient', 'tradename_of' => 'has_tradename', 'constitutes' => 'consists_of',
           'dose_form_of' => 'has_dose_form','has_ingredient' => 'ingredient_of', 'has_tradename' => 'tradename_of',
           'consists_of' => 'constitutes','has_dose_form' => 'dose_form_of'}
  end
end
