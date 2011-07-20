module ApplicationHelper

  def navigation_selected page
    if @title == page
      return "selected"
    else
      return ""
    end
  end

end
