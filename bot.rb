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

	#Inicialização, aqui esta o corpo do bot
	def initialize
		if self.faloAgora? then
			begin
				@msg = self.lerRoteiro 
				if not @msg == nil 
					self.updateData
					@control = TwitterControl::new
					@control.postar @msg.strip
				end
				self.log "Postado com sucesso: \"" + @msg.strip
			rescue => @erro
				self.log @erro
			end
		end
	end
	
	#I.A. de nivel mais primitivo, sorteia chance de falar algon
	#naquele horario em x%
	def faloAgora?
	return true
		@rnd = 100/15
		if (rand @rnd.to_i) == 0 then return true else return false end
	end
	
	#Chama o leitor de roteiro
	def lerRoteiro
		begin
			@doc= Roteiro.new
			
			if @@lastFrase < @doc.linhas.length then
				@msg = @doc.linhas[@@lastFrase]
			else
				@msg = nil
				self.log "Final do script de roteiro"
			end
			@@lastFrase = @@lastFrase + 1
			if @@lastFrase>@doc.linhas.length
				@@lastFrase = @doc.linhas.length
			end
			return @msg
		rescue => @erro
			self.log @erro
		end
		return nil
	end
	
	#atualiza memoria
	def updateData
		@dt  = Time::new.to_s + "\n" #ultimo update
		@dt += @@lastFrase = @@lastFrase.to_s + "\n" # ultima frase
		File.open( @@path + "/data/memory","w" ) do |f|
			f.print( @dt )
		end
	end
	
	#log do sistema
	def log msg
		if not msg == nil
			@t = Time::new
			puts "#{@t} -> #{msg}"
			File.open( @@path + "/data/log", "a") do |f|
				f.print "#{@t} -> #{msg}\n"
			end
		end	
	end

end


#puts Frases::frase[ rand Frases::frase.length ]


#f.each { |lin| puts "-->" + lin }
#puts lins[0]
#TODO: Criar classe Memoria para ela alembrar dq falow das ultimas vezes!

Bot.new


