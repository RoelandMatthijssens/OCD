module MaterialsHelper
  def all_parents
    Material.where "parent_id is NULL"
  end
  
  def get_selected_item params = nil, type = nil, key = nil
    if type == :subject && key == :subject_id || type == :parent && key == :parent_id
      params && params[:material] && params[:material][key] ? params[:material][key] : ""
    else
      params && params[type] &&  params[type][key] ? params[type][key] : ""
    end
  end

  def get_types
    [
      t(:book, :scope => "material.types"), 
      t(:slides, :scope => "material.types"),
      t(:summary, :scope => "material.types"),
      t(:syllabus, :scope => "material.types"),
      t(:misc, :scope => "material.types"),
    ]
  end
  
  def can_rate? material
    if current_user
      qry = Order.joins(:material_orders).find(:all, :conditions => ['user_id=? and status=? and material_id=?', current_user.id, 'Payed', material.id ])
      qry.any?
    else
      false
    end
  end

   
end
