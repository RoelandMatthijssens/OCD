module ApplicationHelper

  def navigation_selected page
    if @title == page
      return "selected"
    else
      return ""
    end
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.first
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end

  def link_to_show_item(name, id)
    link_to_function(name, "show_fields('#{escape_javascript(id)}')")
  end

  def link_to_hide_item(name, id)
    link_to_function(name, "hide_fields('#{escape_javascript(id)}')")
  end

  def link_to_show_hide_items(name, show_ids, hide_ids)
    show_js = "show_fields(#{show_ids});"
    hide_js = "hide_fields(#{hide_ids});"
    link_to_function(name,show_js+hide_js)
  end


end
