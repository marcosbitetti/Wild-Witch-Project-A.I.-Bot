
$WIDTH = 1000
$HEIGHT = 560

Shoes.app (
	:title => "Terminal Wild Witch",
	:width => $WIDTH, :height => $HEIGHT,
	:resizable => false
) do

	@@prompt = nil
	
	#background
	stack :width => $WIDTH, :height => $HEIGHT, :top => 0, :left => 0 do
		background white
	end

	#median
	stack :width => 256, :height => 128, :left => $WIDTH-238, :top => ($HEIGHT-130) do
		image "resources/logo.png"
		hover do
		
		end
		leave do
		
		end
	end
	#foreground
	flow :width => $WIDTH, :height => $HEIGHT, :top => 0, :left => 0 do
		@@prompt = edit_box "Seleciona a informacao desejada", :name => "_prompt", :width => $WIDTH-258, :height => $HEIGHT - 6, :top => 4, :left => 1
		stack :top => 2, :left => $WIDTH-255 do
			button("erros em novas mensagens", :width => 252 )	{ @@prompt.text = (%x[ruby terminal.rb get 1]).unpack("C*").pack("U*") }
			button("verificar posts rescentes", :width => 252 )	{ @@prompt.text = (%x[ruby terminal.rb get 2]).unpack("C*").pack("U*") }
			button("ver log", :width => 252 )					{ @@prompt.text = (%x[ruby terminal.rb get 3]).unpack("C*").pack("U*") }
			button("ver variáveis remotas", :width => 252 )		{ @@prompt.text = (%x[ruby terminal.rb get 4]).unpack("C*").pack("U*") }
			button("ver arquivo de memória", :width => 252 )	{ @@prompt.text = (%x[ruby terminal.rb get 5]).unpack("C*").pack("U*") }
		end
	end
	

end