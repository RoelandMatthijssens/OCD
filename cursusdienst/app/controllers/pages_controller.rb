class PagesController < ApplicationController
  def home
    if signed_in? && current_user.guilds.any?
      redirect_to root_url(:subdomain => current_user.guilds[0].initials)
    end
    @title = t(:home, :scope => "titles" )
  end

  def guide
    @title = t(:guide, :scope => "titles" )
  end

  def info
    @title = t(:info, :scope => "titles" )
  end

  def access_denied
    @title = t(:access_denied, :scope => "titles" )
  end
  
  def manual
    @title = t(:guide, :scope => "titles" )
  end

  def control_panel
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('use_control_panel')
    @title = t(:control_panel2, :scope => "titles" )
  end

  def search_results
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('use_control_panel')
    @title = t(:search_results, :scope => "titles" )
    deny_access and return unless signed_in?

    substr = params[:search]
    #each element is [tablename, [columnnames], attribute_to_display]
    search_environments = [[User, ['name', 'last_name', 'user_name']],
      [Institute, ['name', 'initials', 'location']],
      [Faculty, ['name', 'initials']],
      [Discipline, ['name']],
      [Subject, ['name', 'prof', 'year_type']],
      [Material, ['name']],
      [Guild, ['name', 'initials']],
      [Printer, ['name']]]
    @search_results = {}
    search_environments.each do |table, columns|
      conditions = [[]]
      columns.each do |column|
        conditions[0] << "#{column} LIKE ? "
        conditions << "%#{substr}%"
      end
      conditions[0] = conditions[0].join(" or ")
      @search_results[table] = table.find(:all, :conditions => conditions)
    end
    #render :action => 'search_results'
  end
end
