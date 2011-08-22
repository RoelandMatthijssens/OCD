module FiltersHelper
  
  def get_data_from_filter filter, key, model
    filter && filter[key] ? model.find_all_by_id(filter[key]) : {}
  end
  
  def get_data_from_material model, type
    case type
    when :material_id
      Subject.find_all_by_id model.material_id
    when :subject_id
      Subject.find_all_by_id model.subject_id
    when :discipline_id
      Discipline.find_all_by_id model.discipline_id
    when :faculty_id
      Faculty.find_all_by_institute_id model.institute_id
    when :institute_id
      Institute.find_all_by_id model.institute_id
    end
  end
  
  def get_all_data_from_filter model, type
    case type
    when :material_id
      Subject.find_all_by_id model.material_id
    when :subject_id
      Subject.find_all_by_id model.subject_id
    when :discipline_id
      Discipline.find_all_by_id model.discipline_id
    when :faculty_id
      Faculty.find_all_by_institute_id model.institute_id
    when :institute_id
      Institute.all
    end
  end
  
  def get_institutes
    Institute.all
  end
  
  def get_faculties
    if signed_in? && !current_user.disciplines.empty?
      current_user.disciplines.first.institute.facultities
    else
      Institute.first.faculties
    end
  end
  
  def get_disciplines
    if signed_in? && !current_user.disciplines.empty?
      current_user.disciplines.first.faculty.disciplines
    else
      Institute.first.faculties.first.disciplines
    end
  end
  
  def selected_item item
    item unless item && item.empty?
  end
  
end
