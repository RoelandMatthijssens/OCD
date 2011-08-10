class MaterialsController < ApplicationController

  def index
    @title = "Materials"
    @materials = Material.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @material = Material.find(params[:id])
  end

  def new
    @material = Material.new
    @faculties = get_data_from_filter params[:material], :faculty_id, Faculty
    @disciplines = get_data_from_filter params[:material], :discipline_id, Discipline
    @subjects = get_data_from_filter params[:material], :subject_id, Subject
    @submit = "Create new Material"
  end

  def create
    @material = Material.new(params[:material])
    @material.options= get_options_from_material(params[:material])
    if @material.save
      flash[:succes] = "Material succesfully created"
      redirect_to @material
    else
      filter = params[:material]
      @faculties = get_data_from_filter filter, :faculty_id, Faculty
      @disciplines = get_data_from_filter filter, :discipline_id, Discipline
      @subjects = get_data_from_filter params[:material], :subject_id, Subject
			flash[:notice] = "NOT created material. #{params[:subject]}"
      render 'new'
    end
  end

  def edit
    @material = Material.find(params[:id])
    @faculties = get_data_from_material @material, :faculty_id
    @disciplines = get_data_from_material @material, :discipline_id
    @subjects = get_data_from_material @material, :subject_id
    @submit = "Update Material"
  end

  def update
    @material = Material.find(params[:id])
    @material.subject = nil unless subject_given?(params[:material])
    @material.options = get_options_from_material(params[:material])
    if @material.update_attributes(params[:material])
      flash[:succes] = "Material updated succesfully"
      redirect_to @material
    else
      @faculties = get_data_from_material @material, :faculty_id
      @disciplines = get_data_from_material @material, :discipline_id
      @subjects = get_data_from_material @material, :subject_id
      render 'edit'
    end
  end

  def destroy
  end
  
  private
  
  def subject_given? par
    return par[:subject_id]
  end
  
  def get_options_from_material par
    os = []
    par[:options_attributes].each_value { |v|
      o = Option.find(v["id"])
      os << o if o.instance_of? Option and v["_destroy"] != "1"
    } unless par[:options_attributes].nil?
    return os
  end
  
  def get_data_from_filter filter, key, model
    filter && filter[key] ? model.find_all_by_id(filter[key]) : {}
  end
  
  def get_data_from_material material, type
    case type
    when :subject_id
      Subject.find_all_by_id material.subject_id
    when :discipline_id
      Discipline.find_all_by_id material.discipline_id
    when :faculty_id
      Faculty.find_all_by_id material.faculty_id
    when :institute_id
      Institute.find_all_by_id material.institute_id
    end
  end
  
end
