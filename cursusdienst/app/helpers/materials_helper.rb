module MaterialsHelper
  def all_parents
    Material.where "parent_id is NULL"
  end
end
