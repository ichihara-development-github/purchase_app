module EvaluationsHelper

  def evaluation_avarage(product)
     product.evaluations.average(:star).round(1)
  end

  def has_evaluation?(product)
    current_user.reviewed_products.include?(product)
  end
end
