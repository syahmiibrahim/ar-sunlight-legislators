require_relative '../../db/config'


class Tweet < ActiveRecord::Base

	belongs_to :legislator
	validates :tweet_id, uniqueness:true
end