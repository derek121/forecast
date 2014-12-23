all: deps compile

compile: deps
	rebar compile

deps:
	test -d deps || ./rebar get-deps

run:
	erl -pa ebin -pa deps/*/ebin

clean:
	rebar clean

distclean: clean
	rebar delete-deps


