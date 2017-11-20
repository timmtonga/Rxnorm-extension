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
end
