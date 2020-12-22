# Modular Gamemode Base

This gamemode base is designed around being able to change drastically depending on what map is currently loaded by the server.
In its current state this gamemode base does not provide any additional functionality and simply handles the load order.
However despite its lack of additional functionality it is a greate template to start with as it includes a section for
portions that are always loaded regardless of what map is used, and supports inheriting from other maps.

StartFolder in the config is the main section to use if there is not a section for the current map. This can be thoguht of as a
"Prefered Default Section", if your prefered default section is not found in the config then the "default" section will be used.


Inheriting works as follows:
    1. Loading the Inherit section first
    2. Loading the section inheriting from the first ection

Inheriting can best be seen in the config for gm_construct and gm_flatgrass which both load the default section.


