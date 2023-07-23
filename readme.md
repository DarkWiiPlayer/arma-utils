Add this block to your `description.ext` file:

```cpp
class CfgFunctions
{
	class DWP
	{
		#include "functions\utils\functions.hpp";
	};
};
```

## Respawn

```sqf
[
	this, // respawning object
	100, // distance
	10, // time before vehicle respawns
	[], // array of curators to add new objects to
	{}, // code called on respawn, params are [new, old]
	
] spawn DWP_fnc_distanceRespawn;
```