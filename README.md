# Sinatra Study

### 0.version

- ruby: 2.4.0

### 1. sinatra

- `mkdir sinatra-test`
    - 시나트라 파일을 저장 할 폴더 생성
- `cd sinatra-test`
    - 생성한 폴더로 이동
- `touch app.rb`
    - 루비 코드를 작성할 app.rb 파일 생성
- `gem install sinatra`
- `gem install "sinatra-contrib`
    - restart 없이 변경 적용 가능 
```ruby
require 'sinatra'
require "sinatra/reloader"
get '/' do
    "hello world"
end
```

- `ruby app.rb -0 $IP`
    - 외부 접속을 허용하기 위해서 IP를 바꿔줌
    - default는 localhost라서 c9에서 실행 할수 없어서 변경 필요
