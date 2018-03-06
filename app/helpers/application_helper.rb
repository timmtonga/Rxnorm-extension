module ApplicationHelper
  def logged_in
    return current_user.blank?
  end

  def authorize
    redirect_to '/login' unless current_user
  end

  def tty
    types = {'IN' => 'Ingredient', 'PIN' => 'Precise Ingredient', 'MIN' => 'Multiple Ingredients',
             'SCDC' => 'Semantic Clinical Drug Component', 'SCDF' => 'Semantic Clinical Drug Form',
             'SCDG' => 'Semantic Clinical Dose Form Group', 'SCD' => 'Semantic Clinical Drug', 'GPCK' => 'Generic Pack',
             'BN' => 'Brand Name', 'SBDC' => 'Semantic Branded Drug Component', 'SBDF' => 'Semantic Branded Drug Form',
             'SBDG' => 'Semantic Branded Dose Form Group', 'SBD' => 'Semantic Branded Drug',
             'BPCK' => 'Brand Name Pack', 'PSN' => 'Prescribable Name', 'SY' => 'Synonym', 'DFG' => 'Dose Form Group',
             'TMSY' => 'Tall Man Lettering Synonym', 'DF' => 'Dose Form', 'ET' => 'Dose Form Entry Term'}
    return types
  end

  def get_value(type,name)
    context = eval(type)
    return context[name]
  end

  def dose_forms
    forms = ['','Gas for Inhalation','Inhalant Solution','Metered Dose Inhaler','Nasal Inhalant','Nasal Inhaler','Inhalant Powder (Powdered Dose Inhaler)','Dry Powder Inhaler','Mucosal Spray','Nasal Spray','Oral Spray','Rectal Spray','Topical Spray (Dermal Spray)','Powder Spray','Vaginal Spray','Nasal Cream','Ophthalmic Cream','Oral Cream','Otic Cream','Rectal Cream','Topical Cream','Augmented Topical Cream','Vaginal Cream','Oral Foam','Rectal Foam','Topical Foam','Vaginal Foam','Medicated Liquid Soap','Medicated Shampoo','Topical Oil','Prefilled Applicator','Inhalant Solution','Injectable Solution','Intraperitoneal Solution','Prefilled Syringe (Cartridge, Pen)','Irrigation Solution','Douche','Enema(Rectal Solution; Rectal Suspension)','Ophthalmic Irrigation Solution','Nasal Solution (Nasal Drops; Nose Drops)','Ophthalmic Solution (Ophthalmic Drops; Eye Drops)','Oral Solution (Oral Drops)','Mouthwash (Oral Rinse; Topical Dental Solution)','Mucus Membrane Topical Solution','Otic Solution (Otic Drops; Ear Drops)','Topical Solution (Tincture; Liniment)','Injectable Suspension','Prefilled Syringe (Cartridge, Pen)','Topical Lotion','Augmented Topical Lotion','Nasal Suspension (Nasal Drops; Nose Drops)','Ophthalmic Suspension (Ophthalmic Drops; Eye Drops)','Oral Suspension (Oral Drops)','Extended Release Suspension','Otic Suspension (Otic Drops; Ear Drops)','Bar Soap','Medicated Bar Soap','Chewable Bar','Beads','Cake','Oral Capsule','Enteric Coated Capsule','Extended Release Enteric Coated Capsule','Extended Release Capsule','Extended Release Enteric Coated Capsule','Cement','Chewing Gum','Crystals','Disk','Flakes','Nasal Gel (Nasal Jelly)','Oral Gel (Oral Jelly)','Ophthalmic Gel (Ophthalmic Jelly)','Rectal Gel (Rectal Jelly)','Topical Gel (Topical Jelly)','Augmented Topical Gel','Urethral Gel (Urethral Jelly)','Vaginal Gel (Vaginal Jelly)','Granules','Drug Implant','Lozenge (Oral Troche)','Medicated Pad (Medicated Swab)','Medicated Tape','Nasal Ointment','Ophthalmic Ointment','Oral Ointment','Otic Ointment','Rectal Ointment','Topical Ointment','Augmented Topical Ointment','Vaginal Ointment','Oral Strip','Buccal Film','Paste','Oral Paste','Pudding','Toothpaste','Transdermal Patch','Pellet','Inhalant Powder (Powdered Dose Inhaler)','Oral Powder','Rectal Powder','Topical Powder','Vaginal Powder','Rectal Suppository','Vaginal Suppository','Urethral Suppository','Oral Tablet (Caplet)','Buccal Tablet','Sustained Release Buccal Tablet','Chewable Tablet','Disintegrating Tablet','Enteric Coated Tablet','Extended Release Enteric Coated Tablet','Extended Release Tablet','Extended Release Enteric Coated Tablet','Sublingual Tablet','Vaginal Tablet','Vaginal Ring','Wafer']
    return forms
  end

  def dose_units
    units = ['', 'dL','IU','L','mcL','mcmol','mL','mm','mmol','mol','nmol','cm2','%','kg','g','mcg','mg','ng',
             'kg/L','g/L','mcg/L','mg/L','ng/L','kg/mL','g/mL','mcg/mL','mg/mL','ng/mL','% W/W','% W/V','% V/V']

    return units
  end
end
