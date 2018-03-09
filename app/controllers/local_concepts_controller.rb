class LocalConceptsController < ApplicationController
  def new
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end

    @batch_job = (params[:id].blank? ? nil : SearchItem.find(params[:id]).job_id rescue nil)
  end

  def create
    ingredients = []
    item_name_parts = []
    strengths = []
    dose_form_cui = Rxnconso.where(TTY: 'DF', STR: params[:local_concept][:dose_form],
                                   SUPPRESS: 'N').pluck(:RXCUI)

    item = nil #placeholder for where to retrun

    #transaction to add new concepts
    Rxnconso.transaction do
      #first check/create all the ingredients
      (params[:local_concept][:ingredients] || []).each do |key, value|
        break if value['ingredient'].blank?
        ing = Rxnconso.select(:RXCUI).where("TTY in ('IN','PIN','MIN') AND STR = ?",value['ingredient']).first
        if ing.blank?
          ing = LocalConcept.where(STR: value['ingredient'], TTY: 'IN').first_or_initialize
          ing.save
        end

        ingredients << ing.cui
        item_name_parts << "#{value['ingredient']} #{value['dose_strength']} #{value['dose_unit']}"
        strengths << "#{value['dose_strength']} #{value['dose_unit']}"
      end

      unless !params[:local_concept][:matched].blank?
        #first create SCD (Ingredient + Strength + Dose Form) if it doesn't exist
        scd = check_concept("STR = '#{item_name_parts.join(' / ')} #{params[:local_concept][:dose_form]}' AND TTY = 'SCD'" )

        if scd.blank?
          scd = LocalConcept.create(STR: "#{item_name_parts.join(' / ')} #{params[:local_concept][:dose_form]}",
                                    TTY: 'SCD')
          scd.add_relationships(scd.cui,dose_form_cui,'has_dose_form')
        end

        #next create SCDC (Ingredient + Strength) if it doesn't exist
        scdc = check_concept("STR = '#{item_name_parts.join(' / ')}' AND TTY = 'SCDC'")

        if scdc.blank?
          scdc = LocalConcept.create(STR: "#{item_name_parts.join(' / ')}",
                                     TTY: 'SCDC')
          scdc.add_relationships(scdc.cui,[scd.cui],'constitutes')
          scdc.add_relationships(scdc.cui,ingredients,'has_ingredient')
        end

      end

      item = scd

      unless params[:local_concept][:brand_name].blank?
        #Create BN if it doesn't exist
        brand = check_concept("STR= '#{params[:local_concept][:brand_name]}' AND TTY = 'BN'")
        brand = LocalConcept.create(STR: params[:local_concept][:brand_name], TTY: 'BN') if brand.blank?

        #Create SBDC (Ingredient + Strength + Brand Name) if it doesn't exist
        sbdc = check_concept("STR = '#{item_name_parts.join(' / ')} [#{brand.STR}]' AND TTY = 'SBDC'")
        if sbdc.blank?
          sbdc = LocalConcept.create(STR: "#{item_name_parts.join(' / ')} [#{brand.STR}]", TTY: 'SBDC')
          sbdc.add_relationships(sbdc.cui,[brand.cui],'has_ingredient')
          sbdc.add_relationships(sbdc.cui,[scdc.cui],'tradename_of')
        end

        #Create SBD (Ingredient + Strength + Dose Form + Brand Name)
        sbd_name = "#{item_name_parts.join(' / ')} #{params[:local_concept][:dose_form]} [#{brand.STR}]"
        sbd = check_concept("STR = '#{sbd_name}' AND TTY = 'SBD' AND RXCUI = '#{scd.cui}'")
        if sbd.blank?
          sbd = LocalConcept.create(STR: sbd_name, TTY: 'SBD',RXCUI: scd.cui)

          LocalSat.create(RXCUI:sbd.cui, RXAUI: sbd.aui ,ATN: 'DRUG_CODE',STYPE: 'AUI',
                          ATV: params[:local_concept][:identifier])

          sbd.add_relationships(sbd.cui,ingredients,'has_ingredient')
          sbd.add_relationships(sbd.cui,[brand.cui],'has_ingredient')
          sbd.add_relationships(sbd.cui,dose_form_cui,'has_dose_form')
          sbd.add_relationships(sbd.cui,[sbdc.cui],'consists_of')
          sbd.add_relationships(sbd.cui,[scdc.cui],'consists_of')
          sbd.add_relationships(sbd.cui,[scd.cui],'tradename_of')
        end

        #Create SY (Brand Name + Strength + Dose Form) if it doesn't exist
        sy_name = "#{brand.STR} #{strengths.join('/')} #{params[:local_concept][:dose_form]}"
        sy = check_concept("STR = '#{sy_name}' AND TTY = 'SY' AND RXCUI = '#{scd.cui}'")
        if sy.blank?
          sy = LocalConcept.create(STR: sy_name, TTY: 'SY',RXCUI: scd.cui)
          sy.add_relationships(sy.cui,ingredients,'has_ingredient')
        end
      end
    end

    if params[:local_concept][:batch_job].blank?
      @partial = '/local_concepts/show'
      @concept = item
    else
      @partial = '/batch_jobs/show'
      @job = params[:local_concept][:batch_job]
      @records = SearchItem.where(job_id: @job, status: %w[Matched Verified])
    end

    respond_to do |format|
      format.html { render '/main/index' }
      format.js {}
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def show
    redirect_to '/' and return
  end

  private
  def check_concept(query)

    concept = Rxnconso.where(query).first rescue nil
    if concept.blank?
      concept = LocalConcept.where(query).first rescue nil
    end

    return concept
  end
end
