require_relative '../db/config'
require_relative '../app/models/legislator'
require_relative '../app/models/sen'
require_relative '../app/models/rep'
require_relative '../app/models/com'
require_relative '../app/models/del'
require_relative '../app/models/tweet'
require 'twitter'

#Setup 
# class CongressTwitter
# 	attr_reader :client

	# def initialize
		client = Twitter::REST::Client.new do |config|
 		config.consumer_key        = "6bMMl7UDOTjvq6Vfjnyd0j1Bo"
		config.consumer_secret     = "XgUXpZvNw0fjJhiGWHGMoGIg945KrPTDyQzOUq6kcjtyGcEzll"
		config.access_token        = "612492229-kC4Q3YxNW13T9MpKM9E5P09eXvJHomEfLJ0aivM5"
		config.access_token_secret = "IZquwL9qepLAvOBwuvYPfkNyuwWrQ2yj8omfR5PluwQk4" 
		end
# 	end
# end

# client.search("to:justinbieber bullshit", result_type: "recent").take(3).collect do |tweet|
#   puts "#{tweet.user.screen_name}: #{tweet.text}"
# end

congresslist = Legislator.where.not(twitter_id: "")

congresslist.each do |legislator|
	tweeting = client.user_timeline(legislator.twitter_id)

	tweeting.each do |t|
		Tweet.create(text: t.text, tweet_id: t.id, legislator_id: legislator.twitter_id)
		puts "Reading #{t.id} and tweet #{t.text}"
	end
end

# congress = Legislator.all
# twit = CongressTwitter.new

# congress.each do |index|

# 	unless index[:twitter_id] == ""
# 		begin
# 			puts "Fetch tweet from #{index[:twitter_id]}"
# 			if twit.client.user?("#{index[:twitter_id]}")
# 				twit.client.user_timeline("#{index[:twitter_id]}",{count: 10}).each do |t|
# 					Tweet.create(tweet: t.tweet, tweet_id: t.id, legislator_id: legislator.id)
# 					puts "USER #{t.id} are tweeting #{t.tweet}"
# 					end
# 			end
# 	end
# end
# end