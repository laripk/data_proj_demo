module ApplicationHelper
  
  # Return the title on a per-page basis
  def title
    base_title = "Lari Kirby's Data Project Demo App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  
  # based on #checks in MetaSearch
  def check_group(object_name, method, choices, value_method, text_method, selected = [], options = {})
    # concat selected.inspect
    concat hidden_field_tag("#{object_name}[#{method}][]", '', 
                            options.merge(:id => [object_name.to_s, method.to_s].join('_')))
    concat "\n"
    choices.each do |choice|
      text = choice.send(text_method)
      value = choice.send(value_method)
      check = MetaSearch::Check.new
      check.box = check_box_tag(
        "#{object_name}[#{method}][]",
        value,
        selected.include?(value),
        options.merge(:id => [object_name.to_s, method.to_s, value.to_s.underscore].join('_'))
      )
      check.label = label_tag([object_name.to_s, method.to_s, value.to_s.underscore].join('_'),
                                    text)
      concat check.box
      concat check.label
      concat tag('br')
      concat "\n"
    end
  end
  
  
end
