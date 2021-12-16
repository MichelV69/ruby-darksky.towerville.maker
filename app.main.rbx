#! env ruby
# presumes cucumber –init // for Testing
require('psych')
require_relative('app.classes.rb')
require_relative('lib.wolfstar_studios.rb')
# --- ---

puts "... building domains ..."
studio_domain 	= "wolfstar.ca"
book_domain 		= "DarkSkyDarkFuture"
table_domain 		= "PrimaryIndustry"
studio_and_book_domain = "#{studio_domain},#{book_domain}"

puts "... about to load YAML from disk..."
yaml_data = Psych.load_file("tables.randomTowerville.yaml")

puts "... looking for our domain ..."
puts Psych.dump(yaml_data)

Psych.add_domain_type( "#{studio_domain}/#{book_domain}/#{table_domain}", table_domain ) { |type, val|
  puts val.inspect
}
