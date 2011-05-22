data project demo
-----------------

The purpose of this project is to enhance my application for 
a position creating a central repository for data regarding 
research subjects (patients).

Goal: 
	merge together some datasets relating to the same "subjects" 
	and provide a web interface for accessing the results

I have chosen European Union Statistical Regions as my 
metaphorical "research subjects" because the data is freely
available and there are a number of different types of data
available for each region.

-----------------------------------
Step 1: Choose & Download Some Data

I browsed the eurostat regional data available and picked the following
items to download because I considered them interesting and potentially 
relatable:

data sources
	eurostat data
		http://epp.eurostat.ec.europa.eu/portal/page/portal/region_cities/regional_statistics/data/main_tables
		see tools/download_data.rb for individual download paths
			regional demographics
				Total average population, by NUTS 2 regions (tgs00001)
				Population density, by NUTS 2 regions (tgs00024)
				Total area and land area, by NUTS 2 regions (tgs00002)
			economic
				Regional gross domestic product (PPS per inhabitant), by NUTS 2 regions (tgs00005)
				Dispersion of regional GDP per inhabitant (tsdec220)
				Real growth rate of regional GDP at market prices, by NUTS 2 regions (tgs00037)
				Disposable income of private households, by NUTS 2 regions (tgs00026)
				Primary income of private households, by NUTS 2 regions (tgs00036)
			education
				Pupils and students in all levels of education (ISCED 0-6), by NUTS 2 regions (tgs00091)
				Participation rates of 4-years-olds in education, by NUTS 2 regions (tgs00092)
				Pupils and students in upper secondary and post-secondary non-tertiary education (ISCED 3-4), by NUTS 2 regions (tgs00093) 
				Students in tertiary education (ISCED 5-6), by NUTS 2 regions (tgs00094)
				Pupils in primary and lower secondary education (ISCED 1-2), by NUTS 2 regions (tgs00095)
			science and tech
				Human resources in science and technology (HRST), by NUTS 2 region (tgs00038)
				Employment in high-tech sectors (high-tech manufacturing and high-tech knowledge-intensive services), by NUTS 2 region (tgs00039) 
				Patent applications to the EPO by priority year, by NUTS 2 region (tgs00040)
				High-tech patent applications to the EPO by priority year, by NUTS 2 region (tgs00041)
				Total intramural R&D expenditure (GERD), by NUTS 2 region (tgs00042)
				Researchers, all sectors, by NUTS 2 regions (tgs00043)
			health
				All causes of death, by NUTS 2 regions (tgs00057)
				Death due to cancer, by NUTS 2 regions (tgs00058)
				Death due to ischaemic heart diseases, by NUTS 2 regions (tgs00059)
				Death due to accidents, by NUTS 2 regions (tgs00060)
				Death due to transport accidents, by NUTS 2 regions (tgs00061)
				Physicians or doctors, by NUTS 2 regions (tgs00062)
				Dentists, by NUTS 2 regions (tgs00063)
				Available beds in hospitals, by NUTS 2 regions (tgs00064)
		eurostat dictionaries
			all dictionaries
				http://epp.eurostat.ec.europa.eu/NavTree_prod/everybody/BulkDownloadListing?sort=1&file=dic%2Fall_dic.zip


-----------------------
Step 2: Import the Data

Or at least some of it. To make sure I have time to write all the 
basic functionality of this application, I will only import a very 
minimal amount of data at this time. If I have time later I will 
come back and import additional files.

First, I need a table defining all the regions. 
This data is coming from original_data/eurostat_data/all_dic/en/geo.dic
(copied to data/geo.dic)
This file has two columns, the code and the description.

I noticed that the descriptions of the regions within countries do not
repeat the name of the country, so I am going to add that in during the 
import process.

This proved to have an unexpected challenge of dealing with international
character encodings and getting them to transfer properly.



