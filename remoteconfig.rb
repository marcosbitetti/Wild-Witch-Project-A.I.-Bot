require "net/http"

###########
#
# Classe de configuração
#	Pega a configuração apartir de um documento Google Docs
#	e repassa para os parametros globais
#
##########
class RemoteConfig
	# absolute path
	@@path = File.expand_path(File.dirname(__FILE__));
	#linhas
	@@lins = []
	#web
	@@hostname = 'docs.google.com'
	@@origin = '/View?id=dddvrrg4_22gxcgj8c7'
	#@@hostname = 'localhost'
	#@@origin = '/tmp/view_google.html'

	###
	#
	# Construtor, chama os metodos basicos
	#
	##
	def initialize
		@lDoc = self.getDoc
		begin
			@lDoc.each do |lin|
				@l = lin.split ":"
				@@lins.push [ @l[0].strip, @l[1].strip  ]
				if not @l[0]== ""
					#eval("$"+@l[0].strip+"=\""+@l[1].strip+"\"")
					puts @l[0].strip + " = " + @l[1].strip if $testMode == true
				end
			end
			self.manageGlobals
		rescue => @erro
			
		end
	end

	##
	# Função para acessar a página com as configurações
	##
	def getDoc
		print "Acessando páina de dados remota..." + @@hostname
		@http = Net::HTTP.new( @@hostname )
		@headers, @html = @http.get( @@origin )
		puts " pronto"
		
		@htm = @html.scan( /\<div id=\"doc-contents\"\>.*\<br clear=\"all\"/mi ).to_s
		@linhas = @htm[23,@htm.length].to_s.split "<br>"
		@linhas.pop
		
		return @linhas
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
