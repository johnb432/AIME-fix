#include "script_component.hpp"

private _run = {
	params [
		"_target",
		"_player",
		"_args"
	];

	if (!(_player call EFUNC(main,operating_uav))) then {
		_player action ["UAVTerminalOpen", _player];
	};
};
private _condition = {
	params [
		"_target",
		"_player",
		"_args"
	];

	GVAR(uav_action)
	&& { _player call FUNC(connected) }
	&& { !(_player call EFUNC(main,operating_uav)) };
};
private _condition_inside = {
	params [
		"_target",
		"_player",
		"_args"
	];

	GVAR(uav_action)
	&& { _player call EFUNC(main,operating_uav) };
};
private _modify = {
	params [
		"_target",
		"_player",
		"_args",
		"_menu"
	];

	private _config = configFile >> "CfgVehicles" >> typeOf getConnectedUAV _player;
	private _text = getText (_config >> "displayName");
	private _icon = getText (_config >> "icon");

	_menu set [1, _text];
	_menu set [2, _icon];
};

private _ace_action = [
	QUOTE(CLAS(uav_action)),
	"Stanby...",
	"",
	_run,
	_condition,
	FUNC(uav_menus),
	nil,
	nil,
	nil,
	nil,
	_modify
] call ace_interact_menu_fnc_createAction;

private _ace_action_inside = [
	QUOTE(CLAS(uav_action)),
	"Stanby...",
	"",
	_run,
	_condition_inside,
	FUNC(uav_menus),
	nil,
	nil,
	nil,
	nil,
	_modify
] call ace_interact_menu_fnc_createAction;

[
	"CAManBase",
	1,
	["ACE_SelfActions", "ACE_Equipment"],
	_ace_action,
	true
] call ace_interact_menu_fnc_addActionToClass;

[
	"CAManBase",
	1,
	["ACE_SelfActions"],
	_ace_action_inside,
	true
] call ace_interact_menu_fnc_addActionToClass;