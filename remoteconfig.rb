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
					eval("$"+@l[0].strip+"=\""+@l[1].strip+"\"")
				end
			end
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

end

#instancia a variavel de configuração
#conf = RemoteConfig::new
