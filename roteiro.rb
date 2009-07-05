require "net/http"
require "rexml/document"

#######
#
#  Roteiro
#  Classe desenvolvida para ler as entradas programadas no Google Docs
#  TODO: metodo getLinha retorna um objeto com informações de horário ou não
#		 apartir de uma marcação no texto. Assim um post pode ser configurado
#		 para ir ao ar em determinado periodo do dia.
#		 Marcação dos posts:
#		[D] - Durante o dia
#		[N]	- À noite
#		[M] - Durante a madrugada
#		[am] - antes do meio-dia (manhã)
#		[pm] - após meio-dia (tarde)
#		Agregação de comandos:
#					[D,am] - Dia pela manha (7:00 as 12:00)
#					[N,M] - Todo periodo escuro, da noite e da madrugada (18:00 as 23:59 e 0:00 as 7:00)
#
#######

class Roteiro
	
	@@hostname = 'docs.google.com'
	@@origin = '/View?id=dddvrrg4_20r7mh6rqr'
	@@headers = ""
	@@html = ""
	@@linhas = nil
	
	##
	# Conecta ao Google Docs e armazena as entradas
	##
	def initialize
		print "Lendo roteiro..." + @@hostname
		@http = Net::HTTP.new( @@hostname )
		@@headers, @@html = @http.get( @@origin )
		puts "pronto"
		
		#@htm = htm.unpack("U*").map{|c|c.chr}.join
		@htm = @@html.scan( /\<div id=\"doc-contents\"\>.*\<br clear=\"all\"/mi ).to_s
		@@linhas = @htm[23,@htm.length].to_s.split "<br>"
		@@linhas.pop
	end
	
	##
	# retorna toda a matriz de entradas
	##
	def linhas
		return @@linhas
	end

end