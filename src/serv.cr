require "kemal"

get "/" do
    render "serv/views/index.ecr", "serv/layouts/main.ecr"
end

Kemal.run()

