require "gconnector"
require "rexml/document"

#######
#
#  Roteiro
#  Classe desenvolvida para ler as entradas programadas no Google Docs
#  TODO: metodo getLinha retorna um objeto com informações de horário ou não
#		 apartir de uma marcação no texto. Assim um post pode ser configurado
#		 para ir ao ar em determinado periodo do dia.
#	Marcação dos posts:
#	Posts:
#		Cada post é uma linha no documento do Google Docs (cuidado para não deixar linhas em branco)
#	Comandos de posts:
#		[D] - Durante o dia
#		[N]	- À noite
#		[M] - Durante a madrugada
#		[am] - antes do meio-dia (manhã)
#		[pm] - após meio-dia (tarde)
#		[I] - Imediato (manda a mensagem imediatamente, ignorando testes)
#			  Este método é agregavel à os anteriores.
#		Agregação de comandos:
#					[D,am] - Dia pela manha (7:00 as 12:00)
#					[N,M] - Todo periodo escuro, da noite e da madrugada (18:00 as 23:59 e 0:00 as 7:00)
#					[N,I] - Manda mensagem apenas a noite, mas ignorando os testes
#		Ex.:
#				[pm]Mensagem1 -> sera postada entre 12 horas e 18 horas, se o teste for positivo
#				[pm,I]Mensagem2 -> sera postada imediatamente após Mensagem1 no periodo da tarde
#				[am,I]Mensagem3 -> sera postada imediatamente no periodo da madrugada
#
#######

class Roteiro < GConnector
	
	##
	# Conecta ao Google Docs e armazena as entradas
	##
	def initialize
		puts "Lendo roteiro..."
		super $remoteRoteiro
		
	end
	
end