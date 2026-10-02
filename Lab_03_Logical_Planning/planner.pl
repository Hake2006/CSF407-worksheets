% Laboratory: Logical Reasoning for Planning
% Prolog Knowledge Base for Warehouse Robot & Logical Verification

% Warehouse topology facts:
connected(a, b).
connected(b, a).
connected(b, c).
connected(c, b).

% Rule for direct movement:
can_move(X, Y) :-
    connected(X, Y).

% Rule for plan action verification:
valid_move(X, Y) :-
    connected(X, Y).

% Recursive path verification (multi-step plan):
valid_plan([X, Y]) :-
    connected(X, Y).
valid_plan([X, Y | Rest]) :-
    connected(X, Y),
    valid_plan([Y | Rest]).

% Task 8: Logical reasoning demonstration
wet_road.

slippery :-
    wet_road.

reduce_speed :-
    slippery.
