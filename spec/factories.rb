
Factory.define :region do |region|
  region.code        "AAA"
  region.description "Aaa Region Description"
end

Factory.define :population do |pop|
  pop.year                    2001
  pop.total_pop_thous         492
  pop.total_pop_estimated     false
  pop.total_pop_break_in_data false
  pop.total_pop_see_explan    false
  pop.pop_density_perkm2      389.2
  pop.association             :region
end
