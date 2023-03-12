-module(application_spec_check).

-export([
	 start/0,
	 %% Support
	 all_files/0,
	 all_info/0
	]).


-define(Dir,".").
-define(FileExt,".spec").

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    
    check(all_info(),na),
    init:stop(),
    ok.

check([],_)->
    io:format("Success, OK ! ~n");
check([{ok,[{appl_spec,_Id,Info}]}|T],_)->
    io:format("Checking ~p~n",[Info]),
    true=proplists:is_defined(appl_name,Info),
    true=proplists:is_defined(vsn,Info),
    true=proplists:is_defined(app,Info),
    true=proplists:is_defined(gitpath,Info),
    true=proplists:is_defined(local_resource_type,Info),
    true=proplists:is_defined(target_resource_type,Info),
    check(T,T);
check(Error,T) ->
    io:format("error,Error T ~p~n",[{Error,T}]).


   

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_files()->
    {ok,Files}=file:list_dir(?Dir),
    FileNames=[filename:join(?Dir,Filename)||Filename<-Files,
					     ?FileExt=:=filename:extension(Filename)],
    FileNames.    
all_info()->
    [file:consult(File)||File<-all_files()].
	    
    
