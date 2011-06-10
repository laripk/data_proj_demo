MetaSearch::Where.add :between, :btw,
    :predicate => :in,
    :types => [:integer, :float, :decimal, :date, :datetime, :timestamp, :time],
    :formatter => Proc.new {|param| Range.new(param.first, param.last)},
    :validator => Proc.new {|param|
      param.is_a?(Array) && !(param[0].blank? || param[1].blank?)
    }

# monkey-patch!
# because the alias_method_chain for the postgresql adapter isn't getting seen/being used by meta_search
class Arel::Table
  private
    def self.table_cache(engine) # :nodoc:
      @@table_cache ||= Hash[engine.connection.tables_with_views_included.map { |x| [x,true] }]
    end
end
