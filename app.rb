require 'sinatra'
require "sinatra/reloader"
require "rest-client"
require "json"
require "httparty"
require "nokogiri"
require "uri"
require "date"
require "csv"

before do
    p "****************************"
    p params
    p "****************************"
end

get '/' do
  'Hello world! welcome'
end

get '/htmlfile' do
    send_file 'views/htmlfile.html'
end

get '/htmltag' do
    '<h1>html태그를 보낼수 있습니다.</h1>
    <ul>
        <li>1</li>
        <li>22</li>
        <li>333</li>
    </ul
    '
end

get '/welcome/:name' do
    "#{params[:name]}님 안녕하세요"
end

get '/cube/:num' do
    # input = params[:num].to_i
    # result = input ** 3
    # "<h1>#{result}</h1>"
    
    "#{params[:num].to_i ** 3}"
    
end

get '/erbfile' do
    @name = "5chang2"
    erb :erbfile
end

get '/lunch-array' do
    # 메뉴들을 배열에 저장한다.
    menu = ["20층", "김밥까페","시골집", "시래기"]
    # 하나를 추첨한다.
    @result = menu.sample
    # erb 파일에 담아서 랜더링한다.
    erb :luncharray
end

get '/lunch-hash' do
    #메뉴들이 저장된 배열을 만든다
    menu = ["짜장면", "볶음밥", "김밥"]
    #메뉴 이름(key) 사진 url(value)을 
    #가진 Hash 를 만든다
    menu_img = {
        "짜장면" => "http://www.ohfun.net/contents/article/images/2015/0607/1433677499050108.jpg",
        "볶음밥" => "https://t1.daumcdn.net/cfile/tistory/136532424F08529921",
        "김밥" => "https://i.ytimg.com/vi/60ANBnHjiDU/maxresdefault.jpg"
    }
    #랜덤으로 하나를 출력한다.
    @menu_result = menu.sample
    @menu_img = menu_img[@menu_result]
    #이름과 url을 넘겨서 erb를 랜더링 한다.
    erb :lunchhash
end


get '/randomgame/:var' do
    var = params[:var]
    agearr = ["10","20","30","40","50"]
    age ={"10" =>"당신은 10대입니다.",
        "20" =>"당신은 20대로 추정됩니다.",
        "30" =>"당신은 30대로 추정됩니다.",
        "40" =>"당신은 40대로 추정됩니다",
        "50" =>"당신은 50대로 추정됩니다"
    }
    rand = agearr.sample
    puts rand
    result = age[rand]
    puts result
     @result = result
     @name = var
     erb :randomgame
end

get '/lotto-sample' do
   #random samplng 
   num = (1..45).to_a.sample(6).sort
   url ="http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
   lotto_info = RestClient.get(url)
   lotto_info_hash=JSON.parse(lotto_info);
   actnum =[]
   lotto_info_hash.each do |k,v|
      check = k.slice(0,5)
      if (check == "drwtN")
          actnum << v
      end
      end
    
   @bonusnum =    lotto_info_hash["bnusNo"]
   puts @bonusnum
   
   
   
   n =  actnum & num
   n = n.length
   puts n
   result = "꽝"
   if (n ==3) then result = "5등"
   elsif (n==4) then result = "4등"
   elsif(n==5)
        if ((@bonusnum & n)>0) then result ="3등"
        else 
            result ="2등"
        end
   elsif(n==6) then result="1등"
   end
   
   puts result
   
   
   @n = n
   @actlotto = actnum.to_a.sort
   @yourlotto = num
   erb :lotto
end



get '/form' do
    
    erb:form
end

get '/search' do
    @keyword = params[:keyword]
    url = "https://search.naver.com/search.naver?query="
    query = @keyword
    url = url + query
    redirect to (url)
end




get '/opgg' do
   
    
    erb:opgg
end

get '/opggresult' do
    url = "http://www.op.gg/summoner/userName="
    @userName = params[:userName]
    @encodeName = URI.encode(@userName)
    
    @res = HTTParty.get(url+@encodeName)
    @doc = Nokogiri::HTML(@res.body)
    
    @win = @doc.css(".WinLose .wins").text
    @lose = @doc.css(".WinLose .losses").text
    @rank = @doc.css(".SummonerRatingMedium .tierRank").text
    @champion =@doc.css(".GameSettingInfo .ChampionName").text
    
    #File.open(filename,option) do |f|
    #  handling...
    #end
    
    #File.open("opgg.txt",'a+') do |f|
    #    f.write("#{@encodeName} : #{@win},#{@lose},#{@rank} \n")
    #end
    CSV.open("opgg.csv",'a+') do |c|
        c << [@userName,@win,@lose,@rank]
    end
    
    
    
    
    erb:opggresult
end