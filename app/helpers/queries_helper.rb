module QueriesHelper
   
   def csv_results(results, query)
      require 'csv'
      headers['Content-Disposition'] = "attachment; filename=#{query.name}.csv"
      flds = query.selected_fields # need to use selected_fields to fix the field sort order
      CSV.generate do |csv|
         csv << flds
         @results.each do |record|
            row = []
            flds.each do |f|
               row << record[f]
            end
            csv << row
         end
      end
   end
   
   # ListOption = Struct.new(:text, :value, :id)
   def filter_select_opts
      [{:text => '', :value => 'none', :id => 'opt-none', :visible => true}] + 
         VwcAllCombined.filterables.map{|fld| 
            {:text => "Filter on #{fld.humanize.titlecase}", 
             :value => fld, 
             :id => "opt-#{fld}", 
             :visible => true} 
         }
   end
   
end
