#!/usr/bin/env ruby
require 'rubygems'
require 'twitter'

# Nucledo de transmiss�o do bot


puts "╔══╗\n"
puts "║╔╗║\n"
puts "║╚╝╠══╦╦══╦═╗\n"
puts "║╔╗║╔╗║║║║║╩╣\n"
puts "╚╝╚╩╝╚╩╩╩╩╩═╝ ○ ○ ○\n"

# exemplo de retorno
#<Mash
#	created_at="Sat May 23 07:37:46 +0000 2009"
#	favorited=false
#	id=1891629536
#	in_reply_to_screen_name=nil
#	in_reply_to_status_id=nil
#	in_reply_to_user_id=nil
#	source="web"
#	text="pucha, uma eminha gostosinha me adicionou aki, mais ela \303\251 fake. q puta. Ah. cancei, vou deita, hj vo colher amoras bem cedinho"
#	truncated=false
#	user=<Mash
#		created_at="Sat May 23 07:20:32 +0000 2009"
#		description=nil
#		favourites_count=0
#		followers_count=1
#		following=false
#		friends_count=0
#		id=41992444
#		location=nil
#		name="Cibele Arnemetia"
#		notifications=false
#		profile_background_color="352726"
#		profile_background_image_url="http://static.twitter.com/images/themes/theme5/bg.gif"
#		profile_background_tile=false
#		profile_image_url="http://s3.amazonaws.com/twitter_production/profile_images/242510321/RoxaneCibeleTariaSD2_normal.bmp"
#		profile_link_color="D02B55"
#		profile_sidebar_border_color="829D5E"
#		profile_sidebar_fill_color="99CC33"
#		profile_text_color="3E4415"
#		protected=false
#		screen_name="cibelebruxinha"
#		statuses_count=9
#		time_zone=nil
#		url=nil
#		utc_offset=nil
#	>
#>

require File.expand_path(File.dirname(__FILE__)) + '/config'


httpauth = Twitter::HTTPAuth.new $tw_user, $tw_pass
base = Twitter::Base.new httpauth

#base.update('Heeeeyyyyooo from the Twitter Gem')

base.friends_timeline.each do |tweet|
	if not tweet.user.id = $tw_id then
		puts tweet.user.name
	end
end


