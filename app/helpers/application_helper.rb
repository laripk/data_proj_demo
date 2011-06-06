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
  def check_group(object_name, method, choices = [], selected = [], options = {}, &block)
    unless choices.first.respond_to?(:first) && choices.first.respond_to?(:last)
      raise ArgumentError, 'invalid choice array specified'
    end
    check_boxes = []
    choices.each do |choice|
      text = choice.first
      value = choice.last
      check = MetaSearch::Check.new
      check.box = check_box_tag(
        "#{object_name}[#{method}][]",
        value,
        selected.include?(value),
        options.merge(:id => [object_name, method.to_s, value.to_s.underscore].join('_'))
      )
      check.label = label_tag([object_name.to_s, method.to_s, value.to_s.underscore].join('_'),
                                    text)
      if block_given?
        yield check
      else
        check_boxes << check
      end
    end
    check_boxes unless block_given?
  end
  
  
end
