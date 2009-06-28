require 'rubygems'
require File.expand_path(File.dirname(__FILE__)) + '/check'
require File.expand_path(File.dirname(__FILE__)) + '/remoteconfig'

class Tela
	@@check = Checagem::new
	@@path = File.expand_path(File.dirname(__FILE__))
	@@loop = true
	
	def initialize
		if ARGV[0]=='get' then
			self.select ARGV[1]
		else
			self.principal
		end
	end
	
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
