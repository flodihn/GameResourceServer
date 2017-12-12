erl -kernel -config config/dev.config -pa ebin -pa deps/*/ebin -pa deps/*/deps/*/ebin +K true +P 1000000 -env ERL_MAX_PORTS 65535 -sname game_resource_srv -s game_resource_srv_app start $1
