require "time"

require "twitter_sendeador.rb"

puts "Cibele em acao"

agora = Time::new
puts agora.hour.to_s + ":" + agora.min.to_s + ":" + agora.sec.to_s

compare = Time::parse "19:32:55"

puts compare>agora


