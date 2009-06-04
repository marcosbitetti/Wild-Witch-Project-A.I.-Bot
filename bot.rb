require "time"

require File.expand_path(File.dirname(__FILE__)) + '/twitter_control'
require File.expand_path(File.dirname(__FILE__)) + '/data/frases'
require File.expand_path(File.dirname(__FILE__)) + '/roteiro'

puts "           _                             "
puts "         /' `\       /'                /'"
puts "       /'   ._)    /'                /'"
puts "     /'       O  /'__     ____     /' ____"
puts "   /'       /' /'    )  /'    )  /' /'    )"
puts " /'       /' /'    /' /(___,/' /' /(___,/'"
puts "(_____,/'(__(___,/(__(________(__(________"
puts "                                          "
puts "                                em acao..."

class Bot
	@@path = File.expand_path(File.dirname(__FILE__));
	@@lins = (IO.read(@@path+"/data/entradas.txt")).split "\n"
	@@agora = Time::new
	@data = (IO.read(@@path+"/data/memory")).split "\n"
	@@lastUpdate = Time::parse(@data[0])
	@@lastFrase = @data[1].to_i

	def initialize
		if self.faloAgora? then
			@msg = self.escreveRoteiro 
			if not @msg == nil 
				self.updateData
				@control = TwitterControl::new
				@control.postar @msg.strip
			end
		end
	end
	
	#I.A. de nivel mais primitivo, sorteia chance de falar algon
	#naquele horario em 25%
	def faloAgora?
		if (rand 4) == 0 then return true else return false end
	end
	
	def escreveRoteiro
		@doc= Roteiro.new
		
		if @@lastFrase < @doc.linhas.length then
			@msg = @doc.linhas[@@lastFrase]
		else
			@msg = nil
		end
		@@lastFrase = @@lastFrase + 1
		if @@lastFrase>@@lins.length
			@@lastFrase = @@lins.length
		end
		return @msg
	end
	
	def updateData
		@dt  = Time::new.to_s + "\n" #ultimo update
		@dt += @@lastFrase = @@lastFrase.to_s + "\n" # ultima frase
		File.open( @@path + "/data/memory","w" ) do |f|
			f.print( @dt )
		end
	end

end


#puts Frases::frase[ rand Frases::frase.length ]


#f.each { |lin| puts "-->" + lin }
#puts lins[0]
#TODO: Criar classe Memoria para ela alembrar dq falow das ultimas vezes!

Bot.new


