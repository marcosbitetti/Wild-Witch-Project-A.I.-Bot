require 'rubygems'
require File.expand_path(File.dirname(__FILE__)) + '/check'

class Tela
	@@check = Checagem::new

	def initialize
		self.principal
	end
	
	def principal
		@loop = true
		system "clear"
		@esp = "\t\t"
		puts @esp + "1. verificar por erros em novas mensagens"
		puts @esp + "2. verificar posts rescentes"
		
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

end



Tela::new