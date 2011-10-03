module ApplicationHelper

  def navigation_selected page
    if @title == page
      return "selected"
    else
      return ""
    end
  end
     
  def title
    #base_title = (request.subdomain == 'www')
    base_title = request.subdomain == 'www' || request.subdomain == '' ? "Cursusdienst.net" : Guild.find_by_initials(request.subdomain).name + " cursusdienst"
    if @title.nil?
      base_title
    else
      "#{base_title} :: #{@title}"
    end
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, new_id = Time.now.to_i)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{new_id}','#{escape_javascript(fields)}')")
  end


  def add_fields(f, association, new_id = Time.now.to_i)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder, :lol => "kaka")
      #      render(:partial => association.to_s.singularize + "_fields", :locals => {:f => f, :tag => new_id})
    end
    return "add_fields(this, '#{association}', '#{new_id}','#{escape_javascript(fields)}')"
  end

  def link_to_add_field(name, f, association)
    field = render(association.to_s + "_field", :f => f)
    link_to_function(name, "add_field(this, '#{association}_id', '#{escape_javascript(field)}')")
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

  def link_to_create_hide_items(name, association, hide_ids, f)
    field = render(association.to_s + "_field", :f => f)
    show_js = "add_field(this, '#{association}_id', '#{escape_javascript(field)}');"
    hide_js = "hide_fields(#{hide_ids})"
    link_to_function(name,show_js+hide_js)
  end

  def destroy_nearest_class_and_show_items(name, distroy_val, show_ids, f)
    show_js = "show_fields(#{show_ids});"
    hide_js = "remove_fields(this)"
    f.hidden_field(:_destroy) + link_to_function(name,show_js+hide_js)
  end

  def remove_nearest_class_and_show_items(name, distroy_val, show_ids, f)
    show_js = "show_fields(#{show_ids});"
    hide_js = "delete_fields(this)"
    link_to_function(name,show_js+hide_js)
  end

  def filter_select_on_change parent_id, child_id, data_key
    return "filter_select_on_change('#{parent_id}', '#{child_id}', '#{data_key}')"
  end

  def link_to_perform_javascript name, functions, params, complete_functions = []
    js = ""
    functions.size.times{ |i|
      js += functions[i] + "("
      par = params[i]
      par.size-1.times{|j| js += "'#{par[j]}', "} if par.size > 1

      js += "'#{par.last}');"
    }
    complete_functions.each { |f| js += f}
    link_to_function(name, js)
  end

end
