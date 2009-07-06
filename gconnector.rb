require "net/http"

###########
#
# Classe de coneção ao Google Docs
#
##########

class GConnector
	@hostname
	@origin
	@headers
	
	@linhas
	
	##
	# Construtor, requer endereço a ser carregado
	##
	def initialize url
		@hostname = 'docs.google.com'
		@p = url.to_s.split @hostname
		@origin = @p[1].strip
		self.gGetDoc
	end

	##
	# Fução para acessar a pgina com as configuraes
	##
	def gGetDoc
		print "Acessando página de dados remota..." + @hostname
		begin
			@http = Net::HTTP.new( @hostname )
			@headers, @html = @http.get( @origin )
			puts " pronto."
			@htm = @html.scan( /\<div id=\"doc-contents\"\>.*\<br clear=\"all\"/mi ).to_s
			@linhas = @htm[23,@htm.length].to_s.split "<br>"
			@linhas.pop
			@linhas.each { |l| l = l.strip }
			
			return @linhas
			
		rescue => @erro
			print " " + @erro.to_s
		end
		
		@linhas = []
		puts "."
		return nil
	end
	
	##
	# acessar a páina com as configuraes
	##
	def linhas
		return @linhas
	end
	
	##
	# pega uma linha do registro
	##
	def getLinha n
		return @linhas[n.to_i]
	end

end