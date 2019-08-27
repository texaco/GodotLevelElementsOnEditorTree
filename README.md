# Compose game elements on editor tree #

Wouldn't it be nice to have a bunch of enemies, and a bunch of bullets and compose them on level design time on the editor?

That's my goal with this project.

## What can I expect? ##

A prof of concept. Just wandering about Godot Game engine, trying to figure out how to compose a level with maximising the options with the developed resources.

The state, thought is far from finish and it is not working. I am facing here some problems and asking for help to figure out how this can be acomplished.

## What has been done then? ##

There are a couple of enemy types, coupe of weapons and those are meant to be spawn dynamically and also configurable in level design time.

### Discarted paths ###

#### Node.duplicate() ####

This methods has been actively discouraged by Godot developers

Besides some references are lost on spawning process.

### Current strategy ###

Ok, now that we know what didn't work, what's the current approach?

#### PackedScene.instance() ####

It took me awhile until I was able to instance a packed scene from a child node. This can be found in `res://core/Library.gd` but this has also some caveats.

##### Didn't you mention Level design? #####

This approach has the problem that all work with the fine tune of our enemies and bullets in level design phase are lost.

It also took me a while to figure out how to `copy` those scripts variables to the new instance.

But this only solve part of the problem.

Those configurations that aren't part of the script variables are lost.

Copying all parameters can be drawbacks unexpected. So far I have only code to copy `Script variables` and `Collision layers and mask` (Enemies were blowing up themselves before that)

Other nodes that we add, in order to configure our game element in the scene are also lost.

I did tried to instance all subnodes but this is not a direct path since our subscenes can be made of other subscenes and those aren't ment to instantiate again. This can be accomplished but I can't think in any free problem way.

## Licence ##

All code and files that don't belong to Godot are under CC0 licence.
