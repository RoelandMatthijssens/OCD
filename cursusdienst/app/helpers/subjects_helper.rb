module SubjectsHelper

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_discipline(name, f, association)
    fields = f.fields_for(association, :child_index => "new_#{association}") do |builder|
      render('discipline_fields', :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end


end
