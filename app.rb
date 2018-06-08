# $ ruby app.rb -o $IP 필요!!

require 'sinatra'
require 'sinatra/reloader'
# start web server
# '/' root 주소 의미

get '/' do
  'Hello world!'
end

get '/htmlfile' do
     send_file 'views/htmlfile.html'
end

get '/htmltag' do
    '<h1>hihi</h1>
    <ul>
        <li>sdf</li>
        <li>asdf</li>
    </ul>
    
    '
end

get '/name/:name' do
   
    "#{params[:name]}님 안녕하세요."
end

get '/cube/:num' do
    num =params[:num]
    num = num.to_i
    num = num**3
    "num #{num} 입니다."
end

get '/erbfile' do
    @name = "jihoon123123"
    
    erb:erbfile
end


get '/lunch-array' do
    # 메뉴를 배열에 입력 및 저장
    # 하나 추천
    # erb일에 담아서 렌더링
    luncharr = ["짜장면","카레"]
    lunch = luncharr.sample
    @lunch = lunch
    erb :luncharray
end


get '/lunch-hash' do
    menukey = ['0','1']
    menu = {"0" =>"짜장면","1" =>"카레"}
    imgpath = ['https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Jajangmyeon_by_stu_spivack.jpg/240px-Jajangmyeon_by_stu_spivack.jpg','http://recipe.ezmember.co.kr/cache/recipe/2016/06/29/82aedbd16108d4fedad9a4668333e8781.jpg']
    rand =menukey.sample
    @lunch = menu[rand]
    @imgpath = imgpath[rand.to_i]
    erb :luncharray
end
