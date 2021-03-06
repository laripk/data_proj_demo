require 'term/ansicolor'

class Color
  extend Term::ANSIColor
end

#                            |tools
watch('(app|config|db|lib|public|spec|vendor)/.*\.(rb|erb)') do |match|
  system("clear")
  puts Color.cyan{ "Found change in #{match[0].inspect}..." }
  system("bundle exec rake spec")
end

