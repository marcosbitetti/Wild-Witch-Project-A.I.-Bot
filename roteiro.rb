require "net/http"
require "rexml/document"

class Roteiro
	
	@@hostname = 'docs.google.com'
	@@origin = '/View?id=dddvrrg4_20r7mh6rqr'
	@@headers = ""
	@@html = ""
	@@linhas = nil
	
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
	
	def linhas
		return @@linhas
	end

end