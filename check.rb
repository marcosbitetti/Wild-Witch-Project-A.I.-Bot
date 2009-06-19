$path = File.expand_path(File.dirname(__FILE__))

require $path + "/twitter_control"
require $path + "/roteiro"

class Checagem

	@@twitter = nil
	@@roteiro = nil
	
	def initialize
	
	end
	
	def checkPosts
		@@twitter = TwitterControl::new
		@msgs = Array::new
		(@@twitter.lerMensagens false).each { |@tweet| @msgs.push @tweet.text }
		puts "Lidas:\n"
		puts @msgs.to_s
		return @msgs
	end
	
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