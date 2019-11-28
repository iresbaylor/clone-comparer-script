% Blind renaming - C# functions
% Jim Cordy, May 2010

% Using C# grammar
include "csharp.grm"

% Redefinition for potential clones

define method_definition
    [method_header]				
    '{  [NL][IN] 
	[opt statement_list]  [EX]
    '}  
end define

define potential_clone
    [method_definition]
end define

% Generic blind renaming
include "generic-rename-blind.txl"

