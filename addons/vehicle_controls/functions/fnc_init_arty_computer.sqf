#include "script_component.hpp"

private _run = {
	params [
		"_target",
		"_player",
		"_args"
	];

	_player action ["ArtilleryComputer", _target];
};

private _condition = {
	params [
		"_target",
		"_player",
		"_args"
	];

	private _config = configFile >> "CfgVehicles" >> typeOf _target;

	GVAR(settingArtyComputerAction) && { getNumber (_config >> "artilleryScanner") == 1 } && { _player == gunner _target };
};

private _ace_action = [
	QGVAR(artyComputerAction),
	getText (configfile >> "CfgActions" >> "ArtilleryComputer" >> "text"),
	"\A3\ui_f\data\gui\cfg\communicationmenu\artillery_ca.paa",
	_run,
	_condition
] call ace_interact_menu_fnc_createAction;

[
	"LandVehicle",
	1,
	["ACE_SelfActions"],
	_ace_action,
	true
] call ace_interact_menu_fnc_addActionToClass;