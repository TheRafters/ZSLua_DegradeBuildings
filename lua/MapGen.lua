local BASE_PATH = "./data/mods/ZSLua_DegradeBuildings/lua/"

require(BASE_PATH.."Functions")

--ProFi = require(BASE_PATH.."--ProFi")
--Log = require(BASE_PATH.."Log")

local MapGen = {}

MapGen.BaseX = 0
MapGen.BaseY = 0
MapGen.BaseZ = 0

MapGen.SEEX = 12
MapGen.SEEY = MapGen.SEEX

MapGen.DefaultTerrain = "t_dirt"

function MapGen.Init ()

  MapGen.SquareTerrain (MapGen.DefaultTerrain, MapGen.BaseX + 0, MapGen.BaseY + 0, MapGen.BaseX + 23, MapGen.BaseY + 23)

end

function MapGen.SquareTerrain (id, x1, y1, x2, y2)

  --Log.Message(string.format("MapGen.SquareTerrain: %s :%d,%d - %d,%d", id, x1, y1, x2, y2))
  map:draw_square_ter (ter_str_id(id), MapGen.BaseX + x1, MapGen.BaseY + y1, MapGen.BaseX + x2, MapGen.BaseY + y2)

end

function MapGen.SquareFurniture (id, x1, y1, x2, y2)

  --Log.Message(string.format("MapGen.SquareFurniture: %s :%d,%d - %d,%d", id, x1, y1, x2, y2))
  map:draw_square_furn (furn_str_id(id), MapGen.BaseX + x1, MapGen.BaseY + y1, MapGen.BaseX + x2, MapGen.BaseY + y2)

end

function MapGen.SquareItem (id, x1, y1, x2, y2, chance)

  local z = 0
  --Log.Message(string.format("MapGen.SquareItem: %s :%d,%d - %d,%d: chance : %d", id, x1, y1, x2, y2, chance))
  for x = math.min(x1, x2), math.max(x1, x2), 1 do
    for y = math.min(y1, y2), math.max(y1, y2), 1 do
      if (MapGen.RNG (1, 100) <= chance) then
        local point = tripoint (MapGen.BaseX + x, MapGen.BaseY + y, MapGen.BaseZ + z)
        map:put_items_from_loc (id, point, 0)
      end
    end
  end

end

function MapGen.LineTerrain (id, x1, y1, x2, y2)

  --Log.Message(string.format("MapGen.LineTerrain: %s :%d,%d - %d,%d", id, x1, y1, x2, y2))
  map:draw_line_ter (ter_str_id(id), MapGen.BaseX + x1, MapGen.BaseY + y1, MapGen.BaseX + x2, MapGen.BaseY + y2)
 
end

function MapGen.LineFurniture (id, x1, y1, x2, y2)

  --Log.Message(string.format("MapGen.LineFurniture: %s :%d,%d - %d,%d", id, x1, y1, x2, y2))
  map:draw_line_furn (furn_str_id(id), MapGen.BaseX + x1, MapGen.BaseY + y1, MapGen.BaseX + x2, MapGen.BaseY + y2)

end

function MapGen.PointTerrain (id, x, y)

  local z = 0
  local point = tripoint (MapGen.BaseX + x, MapGen.BaseY + y, MapGen.BaseZ + z)
  --Log.Message(string.format("MapGen.PointTerrain: %s :%d,%d", id, x, y))
  map:ter_set (point, ter_str_id(id))

end

function MapGen.PointGraffiti (x, y)

  local z = 0
  local point = tripoint (MapGen.BaseX + x, MapGen.BaseY + y, MapGen.BaseZ + z)
  local s = MapGen.RandomGraffitiString()
  --Log.Message(string.format("MapGen.PointGraffiti: %s :%d,%d", s, x, y))
  map:set_graffiti (point, s)

end

function MapGen.RandomGraffitiString ()
	local graffiti_strings = {
		"LOOTED",
		"X",
		"BEWARE OF ZEDS",
		"PRAY",
		"ROLL TIDE",
		"LOOTERS WILL BE SHOT",
		"GO AWAY",
		"IN GOD WE TRUST",
		"AMERICA: WHAT HAPPENED?",
		"DEAD INSIDE",
		"STAY AWAY",
		"DANGER",
		"ARMED AND WILLING TO SHOOT",
		"DON'T COME IN",
		"NO FOOD NO VALUABLES",
		"WE WILL SHOOT ON SIGHT",
		"SURVIVORS INSIDE, PLEASE HELP",
		"INFECTED",
		"END TIMES",
		"CHRISTINNEWYORK",
		"ELBERETH",
		"FOOD STAMPS NOT ACCEPTED",
		"WE WILL NOT HELP YOU",
		"WE WILL SHOOT",
		"BITTEN",
		"THE WONDERS OF TECHNOLOGY",
		"DYING AND INFECTED",
		"PLEASE GIVE PROPER FUNERAL",
		"RUNNING LOW ON FOOD",
		"PLACE WEAPON ON FLOOR AND BACK AWAY SLOWLY",
		"WOMEN AND CHILDREN INSIDE",
		"SURVIVORS INSIDE",
		"WE ARE STILL ALIVE",
		"DON'T SHOOT - ALIVE INSIDE",
		"THE END IS NIGH",
		"REPENT",
		"THIS IS FOR YOUR SINS",
		"THE TERRORISTS WON",
		"DAMN YOU CHINA",
		"BANKSY WAS HERE",
		"DANGER",
		"ZEDS",
		"MONSTERS",
		"UNSTABLE",
		"HAVE FUN GETTING CORNHOLED",
		"FOR A GOOD TIME CALL JENNY",
		"WE DIDN'T PRAY ENOUGH",
		"WE USED TO HAVE HOPE",
		"NOW WE ONLY HAVE LOSS",
		"NOTHING INSIDE",
		"THE LORD WANTS US BACK",
		"PLEASE MAKE HEADSTONE",
		"BITTEN - SEND HELP",
		"SHOOT FOR THE HEAD",
		"NUKE 'EM FROM ORBIT",
		"ONLY WAY TO BE SURE",
		"DANGER! MINEFIELD!",
		"WE KILL ALL INTRUDERS",
		"STOP THE RIOTS",
		"THINK OF THE CHILDREN",
		"SAVE OUR SOULS",
		"RUSSIANS GO HOME",
		"CHINESE GO HOME",
		"JAPANESE GO HOME",
		"CANADIANS GO HOME",
		"EUROPEANS GO HOME",
		"MEXICANS GO HOME",
		"BRITISH GO HOME",
		"WHITEYS GO HOME",
		"YANKEES GO HOME",
		"CONFEDERATES GO HOME",
		"THE WONDERS OF TECHNOLOGY",
		"PROJECT BLACKOUT",
		"IF U GET CLOSE WELL FUCKIN KILL U",
		"SCARED - ALONE - AFRAID",
		"DON'T HURT US",
		"WHY ARE THEY EATING THE DOGS?!",
		"WASTE NOTHING",
		"IT WAS CHINA",
		"IT WAS US",
		"IT WAS ALIENS"
		}

  local s = table.random_value(graffiti_strings)

  --Log.Message(string.format("MapGen.RandomGraffitiString: %s", s))

  return s

end

function MapGen.PointFurniture (id, x, y)

  local z = 0
  local point = tripoint (MapGen.BaseX + x, MapGen.BaseY + y, MapGen.BaseZ + z)
  --Log.Message(string.format("MapGen.PointFurniture: %s :%d,%d", id, x, y))
  map:furn_set (point, furn_str_id(id))

end

function MapGen.PointItem (id, x, y, chance)

  local z = 0
  local point = tripoint (MapGen.BaseX + x, MapGen.BaseY + y, MapGen.BaseZ + z)
  --Log.Message(string.format("MapGen.PointItem: %s :%d,%d: chance : %d", id, x, y, chance))
  if (MapGen.RNG (1, 100) <= chance) then
    map:put_items_from_loc (id, point, 0)
  end

end

function MapGen.PointVending (id, x, y)

  --Log.Message(string.format("MapGen.PointVending: %s :%d,%d", id, x, y))
  map:place_vending(MapGen.BaseX + x, MapGen.BaseY + y, id)

end

function MapGen.PointVehicle (id, x, y, chance)

  --Log.Message(string.format("MapGen.PointVehicle: %s :%d,%d", id, x, y, chance))
  --Log.Message("WARNING: adding of vehicles was not implemented yet!")

end

function MapGen.SquareSpawn (id, x1, y1, x2, y2, chance, density)

  local z = 0
  --Log.Message(string.format("MapGen.SquareSpawn: %s :%d,%d - %d,%d: chance : %d : density : %f", id, x1, y1, x2, y2, chance, density))
  map:place_spawns (mongroup_id(id), chance, x1, y1, x2, y2, density)

end

function MapGen.MakeRubble (x, y, chance)

  local z = 0
  local point = tripoint(x, y, z)
  --Log.Message(string.format("MapGen.MakeRubble: %d,%d: chance : %d", x, y, chance))
  if (MapGen.RNG (1, 100) <= chance) then
    map:make_rubble(point)
  end

end

function MapGen.GetTerrainID (x, y)

  local z = 0
  local point = tripoint(x, y, z)
  local ter = map:ter(point)
  --Log.Message(string.format("MapGen.GetTerrainID: %s :%d,%d", ter, x, y))
  return ter

end

function MapGen.GetTerrainName (x, y)

  local z = 0
  local point = tripoint(x, y, z)
  local tername = map:tername(point)
  --Log.Message(string.format("MapGen.GetTerrainName: %s :%d,%d", tername, x, y))
  return tername

end

function MapGen.RNG (value_min, value_max)

  local method
  local result

  if (game.rng) then
    method = "game.rng"
    result = game.rng(value_min, value_max)
  else
    method = "math.random"
    result = math.random(value_min, value_max)
  end

  --Log.Message(string.format("MapGen.RNG: method %s result %d of %d to %d", method, result, value_min, value_max))
  return result

end

function MapGen.OneIn (n)

  local method
  local result

  if (game.one_in) then
    method = "game.one_in"
    result = game.one_in (n)
  else
    method = "MapGen.RNG"
    result = (n == MapGen.RNG (1, n))
  end

  --Log.Message(string.format("MapGen.OneIn: method %s : %s : one in %d", method, result, n))
  return result

end

return MapGen