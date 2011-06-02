class QueryDef
  include ActiveModel::Serialization
  extend ActiveModel::Naming
  # include ActiveModel::MassAssignmentSecurity


  def initialize
    @selects = []
    @filters = []
  end
  
  def add_to_selects(fields)
    if fields.is_a?(Enumerable)
      fields.each{|f| add_to_select(f) }
    else
      add_to_select field
    end
  end
  
  def add_to_filters(filters)
    warn "not implemented"
  end
  
  
  private
    
    def add_to_select(field)
      if field.is_a?(FieldInfo)
        @selects << field.name
      elsif field.is_a?(Symbol)
        @selects << field
      else
        raise "unexpected type #{field.class.to_s} = #{field.to_s}"
      end
    end
  
end
