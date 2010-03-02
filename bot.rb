require "rubygems"
require "time"
require "htmlentities"

require File.expand_path(File.dirname(__FILE__)) + '/twitter_control'
require File.expand_path(File.dirname(__FILE__)) + '/data/frases'
require File.expand_path(File.dirname(__FILE__)) + '/roteiro'
require File.expand_path(File.dirname(__FILE__)) + '/remoteconfig'

puts "           _                             "
puts "         /' `\       /'                /'"
puts "       /'   ._)    /'                /'"
puts "     /'       O  /'__     ____     /' ____"
puts "   /'       /' /'    )  /'    )  /' /'    )"
puts " /'       /' /'    /' /(___,/' /' /(___,/'"
puts "(_____,/'(__(___,/(__(________(__(________"
puts "                                          "
puts "                                em acao..."

#######
#
#  Bot
#
#######

class Bot

	# absolute path
	@@path = File.expand_path(File.dirname(__FILE__));
	# deprecate: local entries data file
	#@@lins = (IO.read(@@path+"/data/entradas.txt")).split "\n"
	# current time
	@@agora = Time::new
	# local state-machine data file (temporary)
	@data = (IO.read(@@path+"/data/memory")).split "\n"
	@@lastUpdate = Time::parse(@data[0])
	@@lastFrase = @data[1].to_i

	##
	#Inicialização, aqui esta o corpo do bot
	##
	def initialize
		#obtem configurção adicional de origem remota
		@conf = RemoteConfig::new
		if self.faloAgora? and not $paused then
			#nucleo
			begin
				@msg = self.lerRoteiro 
				if not @msg == nil 
					self.updateData
					if not $testMode then
						@control = TwitterControl::new
						@control.postar @msg.strip
					end
				end
				#self.log "Postado com sucesso: \"" + @msg.to_s.strip if @msg
				self.log "Postado com sucesso: \"" + @msg
			rescue => @erro
				self.log @erro
			end
		end
	end
	
	##
	#I.A. de nivel mais primitivo, sorteia chance de falar algo
	#naquele horario em x%
	##
	def faloAgora?
		if $testMode then return true end
		@targ = rand 100
		return true if @targ < ($probabilidadeDePost.to_i)
		self.log( "Teste: " + @targ.to_s + "/" + $probabilidadeDePost.to_s + " : sem reação" ) if $logEntradasNegativas
		return false
	end
	
	##
	#Chama o leitor de roteiro
	##
	def lerRoteiro
		@coder = HTMLEntities.new
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
			return  @coder.decode(@msg)
		rescue => @erro
			self.log @erro
		end
		return nil
	end
	
	##
	#atualiza memoria
	##
	def updateData
		@dt  = Time::new.to_s + "\n" #ultimo update
		@dt += @@lastFrase = @@lastFrase.to_s + "\n" # ultima frase
		File.open( @@path + "/data/memory","w" ) do |f|
			f.print( @dt )
		end
	end
	
	##
	#log do sistema
	##
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

#start the bot
Bot.new


