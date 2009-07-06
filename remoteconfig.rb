require "gconnector"

###########
#
# Classe de configuração
#	Pega a configuração apartir de um documento Google Docs
#	e repassa para os parametros globais
#
##########

class RemoteConfig < GConnector
	# absolute path
	@@path = File.expand_path(File.dirname(__FILE__));
	#linhas
	@@lins = []

	###
	#
	# Construtor, chama os metodos basicos
	#
	##
	def initialize
		super $remoteConfigVars
		begin
			@linhas.each do |lin|
				@l = lin.split ":"
				@@lins.push [ @l[0].strip, @l[1].strip  ]
				if not @l[0]== ""
					puts @l[0].strip + " = " + @l[1].strip if $testMode == true
				end
			end
			self.manageGlobals
		rescue => @erro
			#TODO: implementar mecanismo de resposta a erros
		end
	end
	
	##
	# Lê um registro das linhas de config
	##
	def reg nm
		@@lins.each { |l| return l if l[0]==nm }
		return nil
	end

	##
	# Retorna todas as linhas
	##
	def lins
		return @@lins
	end

	##
	# Retornas todos os indices
	##
	def indexes
		@ind = []
		@@lins.each { |l| @ind.push l[0] }
		return @ind
	end
	
	##
	# Arranjo das variaveis globais a serem modificadas
	##
	def manageGlobals
		@@lins.each do |@l|
			case @l[0]
				when 'probabilidadeDePost'
					$probabilidadeDePost = @l[1].to_i
				when 'paused'
					$paused = 'true' == @l[1]
			end
		end
	end
end

#instancia a variavel de configuração
#conf = RemoteConfig::new
#puts $paused
