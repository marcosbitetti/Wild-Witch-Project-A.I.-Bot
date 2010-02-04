require File.expand_path(File.dirname(__FILE__)) + '/gconnector'
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
#	Testes:
#		Um teste é realizado antes da postagem de novas mensagens, este teste usa o valor contido na
#		variável $probabilidadeDePost que se encontra no arquivo congig.rb ou no documento remoto.
#		Este teste pode ser ou não usado para postar conforme os comandos modificadores abaixo.
#	Comandos modificadores de posts:
#		[D] - Durante o dia
#		[N]	- À noite
#		[M] - Durante a madrugada
#		[am] - antes do meio-dia (manhã)
#		[pm] - após meio-dia (tarde)
#		[I] - Imediato (manda a mensagem imediatamente, ignorando testes)
#		[pipi] - Usa as mensagens de ir ao banheiro, elas se encontram em data/pipi
#		[A0/A9] - São ações customizadas, onde A0 até A9 correspondem à arquivos em data/a0 até data/a9
#				  Por exemplo:
#					[A0] -> no arquivo data/a0 existem mensagens do tipo: "Esto tomando café","Pãozinho quente pela manhã"
#					[A1] -> no arquivo data/a0 existem mensagens do tipo: "Estou almoçando","Oba, hj tem bife no almoço"
#				  O número de mensagens vai de 0 à 9. E podem ser comentadas com : após o numero indicador. Ex.:
#					[A0:café], [A1:almoço]
#					quando comentadas o comentário não interfere na checagem do nome, podendo ser escrito despreocupadamente.
#			
#		Agregação de comandos:
#					[D,am] - Dia pela manha (7:00 as 12:00)
#					[N,M] - Todo periodo escuro, da noite e da madrugada (18:00 as 23:59 e 0:00 as 7:00)
#					[N,I] - Manda mensagem apenas a noite, mas ignorando os testes
#		Ex.:
#				Olha a tarde eu falo com vcs -> Sera postado normalmente
#				[pm]Não achei a loja -> sera postada entre 12 horas e 18 horas, se o teste for positivo
#				[pm,I]To voltando de taxi! -> sera postada imediatamente após a mensagem anterior no periodo da tarde
#				[am,I]To indo dormir. ZzzzZzzz -> sera postada imediatamente no periodo da madrugada
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
