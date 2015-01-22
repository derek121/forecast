all: deps compile

compile:
	rebar compile

deps:
	rebar get-deps

run:
	rebar shell

clean:
	rebar clean

distclean: clean
	rebar delete-deps


