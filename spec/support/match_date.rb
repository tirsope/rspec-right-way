RSpec::Matchers.define :match_date do |expected_string|
	match do |actual|
		format_date(actual) == expected_string
	end

	failure_message do |actual|
		"expected tha #{format_date(actual)} would match #{expected}"
	end

	def format_date date
		"%d-%02d-%02d" % [date.year, date.month, date.day]		
	end
end