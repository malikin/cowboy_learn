%%%-------------------------------------------------------------------
%% @doc cowboy_learn public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_learn_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

% start(_StartType, _StartArgs) ->
    % cowboy_learn_sup:start_link().

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
               {"/", hello_handler, []},
               {"/post", post_handler, []}
              ]}
    ]),
    cowboy:start_http(my_http_listener, 100, [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]
    ),
    cowboy_learn_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
