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
   
end
