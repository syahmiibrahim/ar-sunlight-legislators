require_relative '../db/config'
require_relative '../app/models/legislator'
require_relative '../app/models/sen'
require_relative '../app/models/rep'
require_relative '../app/models/com'

 # Legislator.print_legislators("TX")
# Legislator.gender("Male")
# Legislator.gender("Female")
# Legislator.list_state
puts "Total congress members:"
Legislator.total_congress
puts "Remove inactive members..."
Legislator.delete_inactive
puts "Current total of active members"
Legislator.total_congress