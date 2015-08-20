require_relative '../../db/config'


class Legislator < ActiveRecord::Base
	def name
		"#{firstname} #{middlename} #{lastname}"
		# Legislator.select(:firstname, :middlename, :lastname).order(lastname: :desc)
	end


	def self.state(states)
		puts "#{self.to_s} :"
		self.where(state: states).each do |legislator|
			puts "#{legislator.name} (#{legislator.party})"
		end
		nil
	end

	def self.print_legislators(state)
		Sen.state(state)
		Rep.state(state)
	end
	
	def self.gender(gender)
		init_gender = gender[0].capitalize

		senator_gender = Sen.where(gender: init_gender, in_office: "1").count
		rep_gender = Rep.where(gender: init_gender, in_office: "1").count

		total_senator = (senator_gender.to_f/(Sen.count.to_f))*100
		total_rep = (rep_gender.to_f/(Rep.count.to_f))*100

		puts "#{gender} senator: #{senator_gender} (#{total_senator.round(0)}%)"
		puts "#{gender} representative: #{rep_gender} (#{total_rep.round(0)}%)"
	end
	
	def self.list_state
		# self.where(in_office: "1").order(state: :desc).each do |state|
		# 	senator = Sen.count
		# 	rep = Rep.count
		# 	puts "#{state}: #{senator} Senators, #{rep} Representative(s)"
		# end
		# Legislator.select(:state).distinct.order(:state).map(&:state).each do |states|
		# 	puts "#{states}: #{Sen.where(in_office: "1",state: states).count} Senators, #{Rep.where(in_office: "1", state: states).count} Representative(s)"
		# end
		Legislator.select(:state).distinct.order(state: :desc).map(&:state).each do |states|
			num_sen = Sen.where(in_office: "1", state: states).count
			num_rep = Rep.where(in_office: "1", state: states).count
			puts "#{states}: #{num_sen} Senators, #{num_rep} Representative(s)"
		end
	end

	def self.total_congress
		total_sen = Sen.count
		total_rep = Rep.count

		puts "Senators: #{total_sen}"
		puts "Representatives : #{total_rep}"
	end

	def self.delete_inactive
		Legislator.where(in_office: "0").destroy_all
	end
end	

