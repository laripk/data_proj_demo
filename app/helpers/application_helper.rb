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
  
  
end
