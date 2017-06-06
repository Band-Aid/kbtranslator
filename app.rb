require 'nokogiri'
require 'rest-client'
require 'easy_translate'
require 'sinatra'

#page =  RestClient.get('https://community.box.com/t5/How-to-Guides-for-Admins/Enterprise-Settings-Content-amp-Sharing/ta-p/174')
#parse_page = Nokogiri::HTML(RestClient.get('https://community.box.com/t5/How-to-Guides-for-Admins/Enterprise-Settings-Content-amp-Sharing/ta-p/174'))
#parse_page = Nokogiri::HTML(RestClient.get('https://community.box.com/t5/How-to-Guides-for-Managing/Excel-Online-Previewer/ta-p/30633'))

get '/' do
return erb :home
end

post '/showtrans' do
@kburl = params[:kburl]

parse_page = Nokogiri::HTML(RestClient.get(@kburl))
    parse_page.css('.lia-message-body').map do |a|
       # post_name = a.text.gsub /\t/, ''
        post_name = a
        #post_enter = post_name.gsub /\n/, ''
   # puts post_name
    File.open("out.txt",'w') {|f| f.write(post_name)}
end

to_parse = File.read("out.txt")
EasyTranslate.api_key = ''
@outcome = EasyTranslate.translate([to_parse], :to => :japanese)

#File.open("views/outcome1.erb",'w') {|f| f.write(outcome)}
#erb :outcome1
    
return erb :results

end
