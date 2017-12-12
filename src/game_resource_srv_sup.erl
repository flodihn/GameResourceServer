-module(game_resource_srv_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 10, 
    MaxSecondsBetweenRestarts = 30, 

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    Restart = transient,
    Shutdown = 6000,

    GameResourceSrv = {game_resource_srv, 
        {game_resource_srv, start_link, [mnesia_resource]},
        Restart,
        Shutdown,
        worker,
        []},

    GameResourceEventManager = {game_resource_event_manager,
        {gen_event, start_link, [{local, game_resource_event_manager}]},
        Restart,
        Shutdown,
        worker,
        []},

    {ok, {SupFlags, [GameResourceSrv, GameResourceEventManager]}}.

