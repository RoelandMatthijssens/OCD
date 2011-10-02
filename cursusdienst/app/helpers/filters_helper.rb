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

  def get_faculties current_institute_id = nil
    if current_institute_id && !current_institute_id.empty?
      Institute.find(current_institute_id).faculties
    elsif signed_in? && !current_user.disciplines.empty?
      current_user.disciplines.first.institute.faculties
    else
      Institute.first ? Institute.first.faculties : []
    end
  end

  def get_disciplines current_faculty_id = nil
    if current_faculty_id && !current_faculty_id.empty?
      Faculty.find(current_faculty_id).disciplines
    elsif signed_in? && !current_user.disciplines.empty?
      current_user.disciplines.first.faculty.disciplines
    else
       Institute.first &&  Institute.first.faculties.first ? Institute.first.faculties.first.disciplines : []
    end
  end

  def get_subjects current_discipline_id = nil
    if current_discipline_id && !current_discipline_id.empty?
      Discipline.find(current_discipline_id).subjects
    elsif signed_in? && !current_user.disciplines.empty?
      current_user.disciplines.first.faculty.disciplines.first.subjects
    else
      Institute.first &&  Institute.first.faculties.first && Institute.first.faculties.first.disciplines.first ? Institute.first.faculties.first.disciplines.first.subjects : []
    end
  end

  def get_materials current_subject_id = nil
    if current_subject_id && !current_subject_id.empty?
      Subject.find(current_subject_id).materials
    elsif signed_in? && !current_user.disciplines.empty?
      current_user.disciplines.first.faculty.disciplines.first.subjects.first.materials
    else
      Institute.first &&  Institute.first.faculties.first && Institute.first.faculties.first.disciplines.first && Institute.first.faculties.first.disciplines.first.subjects.first ? Institute.first.faculties.first.disciplines.first.subjects.first.materials : []
    end
  end

  def selected_item item
    item unless item && item.empty?
  end


  def get_id params, key
    params[key] ? params[key] : ""
  end

end
