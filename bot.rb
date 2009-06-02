require "time"

#require File.expand_path(File.dirname(__FILE__)) + '/twitter_control'
require File.expand_path(File.dirname(__FILE__)) + '/data/frases'

puts "           _                             "
puts "         /' `\       /'                /'"
puts "       /'   ._)    /'                /'"
puts "     /'       O  /'__     ____     /' ____"
puts "   /'       /' /'    )  /'    )  /' /'    )"
puts " /'       /' /'    /' /(___,/' /' /(___,/'"
puts "(_____,/'(__(___,/(__(________(__(________"
puts "                                          "
puts "                                em acao..."

agora = Time::new
puts agora.hour.to_s + ":" + agora.min.to_s + ":" + agora.sec.to_s

compare = Time::parse "19:32:55"

puts compare>agora

puts Frases::frase[ rand Frases::frase.length ]

#TODO: Criar classe Memoria para ela alembrar dq falow das ultimas vezes!
