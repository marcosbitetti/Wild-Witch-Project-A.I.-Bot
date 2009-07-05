require 'rubygems'
require File.expand_path(File.dirname(__FILE__)) + '/check'
require File.expand_path(File.dirname(__FILE__)) + '/remoteconfig'

#######
#
#  Tela
#	Classe especial de gerenciamento. Implementa um pequeno programa
#	de controle e monitoramento. Sua interface serve para uso via SSH
#	Mas foi preparada para responder ao terminal gráfico.
#
#######

class Tela
	@@check = Checagem::new
	@@path = File.expand_path(File.dirname(__FILE__))
	@@loop = true
	
	##
	# Inicialização. Verifica se existe o parametro 'get' em ARGV
	# se este parametro existir, passa direto para a interface de opções
	# e retorna o resultado sem entrar no loop principal
	##
	def initialize
		if ARGV[0]=='get' then
			self.select ARGV[1]
		else
			self.principal
		end
	end
	
	##
	# Loop principal, uma classica interface de menu usando os metodos
	# do sistema operacional.
	# Os valores das opções são case-sensitive.
	##
	def principal
		system "clear"
		@esp = "\t\t"
		puts @esp + "1. verificar por erros em novas mensagens"
		puts @esp + "2. verificar posts rescentes"
		puts @esp + "3. ver log"
		puts @esp + "4. ver variaveis remotas"
		puts @esp + "5. ver arquivo de memoria"
		
		puts @esp + "x. sair"
		
		@s = gets.strip
		puts "Trabalhando..."
		self.select @s
		self.espera if not @s == 'x'
		
		self.principal if @@loop
	end
	
	##
	# Seletor de opções
	##
	def select op
		case op
			when "1"
				@@check.checkNovasMensagens
			when "2"
				@@check.checkPosts
			when "3"
				self.showLog
			when "4"
				self.showRemotas
			when "5"
				self.showMemory
			when "x"
				@@loop = false
		end
	end
	
	##
	# Apenas imprime uma mensagem para pressionar 'enter'
	# antes de limpar a tela e voltar ao menu principal
	##
	def espera
		puts "--- pressione enter ---"
		gets
		self.principal
	end
	
	##
	# Lê o arquivo de log do sistema
	##
	def showLog
		puts (IO.read(@@path+"/data/log"))
	end
	
	##
	# Lê o arquivo de memria (state-machine) do bot
	##
	def showMemory
		puts (IO.read(@@path+"/data/memory"))
	end
	
	##
	# Lê as variaveis de configuração remotas
	##
	def showRemotas
		@conf = RemoteConfig::new
		@conf.lins.each { |l| puts l[0] + ": " + l[1] }
	end

end



Tela::new
