/*
	initArsenal
	Author: DarkWiiPlayer

	Arguments[]
		1: Teleport Object
		2: Teleport Target
		3: Menu Text
*/

if (!isServer) exitWith {}; //run only on server

private _ammobox = param[0, objNull, [objNull]];
private _config = param[1, configNull, [configNull]];

private _ace = "CODE" == typeName ace_arsenal_fnc_initBox;

private _addFromConfig = {
	private _ammobox = param[0, objNull, [objNull]];
	private _config = param[1, configNull, [configNull]];

	if (_ace) then {
		if (isArray (_config / "weapons")) then { [_ammobox, getArray (_config / "weapons"), true] call ace_arsenal_fnc_addVirtualItems };
		if (isArray (_config / "magazines")) then { [_ammobox, getArray (_config / "magazines"), true] call ace_arsenal_fnc_addVirtualItems };
		if (isArray (_config / "items")) then { [_ammobox, getArray (_config / "items"), true] call ace_arsenal_fnc_addVirtualItems };
		if (isArray (_config / "backpacks")) then { [_ammobox, getArray (_config / "backpacks"), true] call ace_arsenal_fnc_addVirtualItems };
	} else {
		if (isArray (_config / "weapons")) then { [_ammobox, getArray (_config / "weapons"), true] call BIS_fnc_addVirtualWeaponCargo };
		if (isArray (_config / "magazines")) then { [_ammobox, getArray (_config / "magazines"), true] call BIS_fnc_addVirtualMagazineCargo };
		if (isArray (_config / "items")) then { [_ammobox, getArray (_config / "items"), true] call BIS_fnc_addVirtualItemCargo };
		if (isArray (_config / "backpacks")) then { [_ammobox, getArray (_config / "backpacks"), true] call BIS_fnc_addVirtualBackpackCargo };
	};
};

[_ammobox, _config] call _addFromConfig;

if (_ace) then {
	[_ammobox, false] call ace_arsenal_fnc_initBox;
} else {
	["AmmoboxInit", [_ammobox, false]] call BIS_fnc_arsenal; 
};

if (isClass (_config / "mods")) then {
	private _mods = getLoadedModsInfo apply { toLower (_x # 1) } apply { if (_x find "@" == 0) then { _x select [1] } else { _x } };
	{
		if (configName _x in _mods) then {
			[_ammobox, _x] call _addFromConfig;
		}
	} forEach ("true" configClasses _config / "mods")
};
