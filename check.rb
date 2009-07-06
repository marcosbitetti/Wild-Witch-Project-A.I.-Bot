$path = File.expand_path(File.dirname(__FILE__))

require $path + "/twitter_control"
require $path + "/roteiro"

#######
#
#  Checagem
#	Esta  uma classe de varredura, criada para localizar erros em
#	novos posts antes de serem definitivamente enviados.
#	Tambm possui mtodos para retornar os registros do Twitter
#	TODO: Mtodos para analizar a conexo com a internet, para
#	verificar as configuraes remotas, etc.
#
#######

class Checagem

	@@twitter = nil
	@@roteiro = nil
	
	##
	# Construtor
	##
	def initialize
	
	end
	
	##
	# Retorna a lista dos ultimos posts pela API do Twitter
	##
	def checkPosts
		@@twitter = TwitterControl::new
		@msgs = Array::new
		(@@twitter.lerMensagens false).each { |@tweet| @msgs.push @tweet.text }
		puts "Lidas:\n"
		puts @msgs.to_s
		return @msgs
	end
	
	##
	# Abre o arquivo remoto de posts, e procura por erros, como por exemplo
	# posts com mais de 140 caracteres.
	##
	def checkNovasMensagens
		@@roteiro = Roteiro::new
		#passa testes
		@@roteiro.linhas.each do |lin|
			if lin.length>140 then
				puts "[ERRO - Comprimento de linha: " + lin.length.to_s + " ] " + lin
			else
				puts "\t" + lin
			end
		end
	end

end

#check = Checagem::new
#check.checkNovasMensagens