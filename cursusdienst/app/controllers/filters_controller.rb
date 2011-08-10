class FiltersController < ApplicationController
  
  def faculties_from_institutes
    if params[:institute]
      @institute = Institute.find(params[:institute])
      if @institute
        faculties = Faculty.find_all_by_institute_id(params[:institute])
        respond_to do |format|
          format.html{ flash[:notice] = "ok #{faculties}" } 
          format.json{ render :json => faculties }
        end
      end
    end
    
  end
  
  def get_children_from_parent
    if params[:institute] && Institute.exists?(params[:institute])
      @faculties = Faculty.find_all_by_institute_id(params[:institute])
      respond_to do |format|
        format.html{ flash[:notice] = "ok #{@faculties}" } 
        format.json{ render :json => @faculties }
      end 
    elsif params[:faculty] && Faculty.exists?(params[:faculty])
      @disciplines = Discipline.find_all_by_faculty_id(params[:faculty])
      respond_to do |format|
        format.html{ flash[:notice] = "ok #{@disciplines}" } 
        format.json{ render :json => @disciplines }
      end 
    elsif params[:discipline] && Discipline.exists?(params[:discipline])
      discipline = Discipline.find(params[:discipline])
      @subjects = discipline.subjects
      respond_to do |format|
        format.html{ flash[:notice] = "ok #{@subjects}" } 
        format.json{ render :json => @subjects }
      end  
    end
    
  end
  
end