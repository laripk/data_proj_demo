class FieldInfo
  include ActiveModel::Serialization
  extend ActiveModel::Naming
  include ActiveModel::MassAssignmentSecurity
  
  attr_reader :name, :description, :time_range_type, 
              :model_klass, :model_field
  
  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @time_range_type = args[:time_range_type]
    @model_klass = args[:model_klass]
    @model_field = args[:model_field]
  end
  
  def self.all
    list = []
    # list << FieldInfo.new({
    #   :name => "Countries",
    #   :description => "Countries available for filtering",
    #   :time_range_type => "not applicable",
    #   :model_klass => Country,
    #   :model_field => :countries_used # not sure this will work
    # })
    list << FieldInfo.new({
      :name => "Primary Household Income",
      :description => "Primary income of private households (PPS per inhabitant) in a region. The primary distribution of income shows the income of private households generated directly from market transactions, in particular the purchase and sale of factors of production. This includes as the main item the compensation of employees, i.e. income from the sale of labour as a factor of production. Purchasing Power Standards (PPS) are a fictive currency unit that eliminates differences in purchasing power, i.e. different price levels, between countries. [The calculation in PPS is intended to allow the comparison of levels of economic activity of different sized economies irrespective of their price levels. It is less suited for comparisons over time.]",
      :time_range_type => "Year",
      :model_klass => HouseholdIncome,
      :model_field => :primary
    })
    list << FieldInfo.new({
      :name => "Total Population",
      :description => "Total population resident in a region. Average of population at the beginning of the year and population at the end of the year. (1,000 inhabitants)",
      :time_range_type => "Year",
      :model_klass => Population,
      :model_field => :total_pop_thous
    })
    list << FieldInfo.new({
      :name => "Population Density",
      :description => "Total population divided by the surface area. (inhabitants per square km) For calculation of population density, the land area concept (excluding inland water bodies like lakes or rivers) should be used wherever available. In several countries the total area, including area of lakes and rivers, is used because it is the only concept for which data are available.",
      :time_range_type => "Year",
      :model_klass => Population,
      :model_field => :pop_density_perkm2
    })
    list << FieldInfo.new({
      :name => "Death Rate - All Causes",
      :description => "Deaths due to all causes of death in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :time_range_type => "Three Year Periods (Overlapping)",
      :model_klass => DeathRate,
      :model_field => :all_causes
    })
    list << FieldInfo.new({
      :name => "Death Rate - Cancer",
      :description => "Deaths due to cancer (all death caused by a malignant neoplasm) in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :time_range_type => "Three Year Periods (Overlapping)",
      :model_klass => DeathRate,
      :model_field => :cancer
    })
    list << FieldInfo.new({
      :name => "Death Rate - Heart Disease",
      :description => "Death due to ischemic heart diseases (all death caused by reduced blood supply to the heart - most are due to 'heart attack') in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :time_range_type => "Three Year Periods (Overlapping)",
      :model_klass => DeathRate,
      :model_field => :heart_disease
    })
    list << FieldInfo.new({
      :name => "Death Rate - All Accidents",
      :description => "Death due to all kinds of accidents (transport, drowning, fire, ...) in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :time_range_type => "Three Year Periods (Overlapping)",
      :model_klass => DeathRate,
      :model_field => :all_accidents
    })
    list << FieldInfo.new({
      :name => "Death Rate - Transport Accidents",
      :description => "Death due to transport accidents (all kinds of transport (road: car, pedestrian, cyclist, ..; water; air; ...)) in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :time_range_type => "Three Year Periods (Overlapping)",
      :model_klass => DeathRate,
      :model_field => :transport_accidents
    })
    list
  end
  
end
