require 'rubygems'
require File.expand_path(File.dirname(__FILE__)) + '/check'
require File.expand_path(File.dirname(__FILE__)) + '/remoteconfig'

class Tela
	@@check = Checagem::new
	@@path = File.expand_path(File.dirname(__FILE__))

	def initialize
		self.principal
	end
	
	def principal
		@loop = true
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
		case @s
			when "1"
				@@check.checkNovasMensagens
				self.espera
			when "2"
				@@check.checkPosts
				self.espera
			when "3"
				self.showLog
			when "4"
				self.showRemotas
				self.espera
			when "5"
				self.showMemory
				self.espera
			when "x"
				@loop = false
		end
		
		self.principal if @loop
	end
	
	def espera
		puts "--- pressione enter ---"
		gets
		self.principal
	end
	
	def showLog
		puts (IO.read(@@path+"/data/log"))
	end
	
	def showMemory
		puts (IO.read(@@path+"/data/memory"))
	end
	
	def showRemotas
		@conf = RemoteConfig::new
		@conf.lins.each { |l| puts l[0] + ": " + l[1] }
	end

end



Tela::new