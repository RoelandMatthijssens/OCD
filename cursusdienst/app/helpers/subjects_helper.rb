module SubjectsHelper

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_discipline(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.first
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
#fields = f.fields_for(association, :child_index => "new_#{association}") do |builder|
      render('discipline_fields', :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end
  
  def get_types
    [
      t(:bachelor, :scope => "subject.types"), 
      t(:master, :scope => "subject.types"),
    ]
  end


end
