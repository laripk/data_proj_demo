require 'open-uri'

class Download
  def self.get(url, filename)
    open(filename, 'wb') do |f| # note that this saves on top of existing files without warning
      f << open(url).read
    end
  end
end




fileswanted = %w(tgs00001 tgs00024 tgs00002 tgs00005 tsdec220 tgs00037 tgs00026 tgs00036 tgs00091 tgs00092 tgs00093 tgs00094 tgs00095 tgs00038 tgs00039 tgs00040 tgs00041 tgs00042 tgs00043 tgs00057 tgs00058 tgs00059 tgs00060 tgs00061 tgs00062 tgs00063 tgs00064)

savedir = File.expand_path(File.dirname(__FILE__) + '/../original_data/eurostat_data')


fileswanted.each do |file|
  print "getting #{file}..."
  url = "http://epp.eurostat.ec.europa.eu/NavTree_prod/everybody/BulkDownloadListing?sort=1&file=data%2F#{file}.tsv.gz"
  filename = File.join(savedir, "#{file}.tsv.gz")
  Download.get url, filename
  
  print "..."
  sleep(1) # pause to be kind to the server
  url = "http://epp.eurostat.ec.europa.eu/tgm/web/_download/Eurostat_Table_#{file}FlagDesc.xls"
  filename = File.join(savedir, "#{file}_FlagDesc.xls")
  Download.get url, filename
  
  puts "got #{file}"
  sleep(2) # pause to be kind to the server
end
