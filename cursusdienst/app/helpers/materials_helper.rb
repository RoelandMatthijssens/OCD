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
  
  
end
