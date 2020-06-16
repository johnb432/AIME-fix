#include "script_component.hpp"

params [
	"_target",
	"_player",
	"_args"
];

private _vehicle = vehicle _player;

"Eject" call EFUNC(main,ignore_keybind_for_input_action) && { [_player, _vehicle] call FUNC(can_eject) >= 0 };