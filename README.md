
# Blips Manager
Allow to display or hide blips

Menu disable / enable : 

![image](https://i.imgur.com/WYktLci.png)

Maps : 

![image](https://i.imgur.com/V79FkiG.png)

## Dependencies

- [OxLib](https://github.com/overextended/ox_lib)

## Usage

#### Exemple
```
exports.axio_blipsManager:createBlip({
	resource = GetCurrentResourceName(),
	coords = vector3(742.6594, -822.2820, 22.667),
	text = "Arcade",
	sprite = 546,
	scale = 0.6,
	color = 28,
	group = "Activité",
	short = true,
	advanced = {
		{ type = 'title', "Arcade", false },
		{ type = 'infoText', "Open hour", "24/24"},
		{ type = 'infoHeader', ""},
		{ type = 'infoText', "Come play to old video game and beat your friend. Drink and food also available."},
		{ type = 'image', "maps_blips", "arcade"}
	}
})
``` 

#### Basic blips

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `resource` | `string` | current resource name for disable blip if stopped |
| `coords` | `vector3` | Coord | 
| `text` | `string` | Blips title | 
| `sprite` | `number` | Blips sprite | 
| `scale` | `number?` | Blips size (0.8 default) | 
| `color` | `number?` | Blips colors (0 default) | 
| `group` | `string?` | Set group for display blips group in menu for display / hide | 
| `short` | `bool?` | SetBlipAsShortRange (false default) | 


#### Advanced params
for advanced blips add 'advanced array'

| Parameter | Parameter                       |
| :-------- | :-------------------------------- |
| `title (unique)` | string, bool |
| `infoText` | string, string |
| `infoHeader` | string, string  |
| `image (unique)` | "maps_blips", string|

For image, add in stream/maps_blips.ytd

Recommended size 512x256

### Original
Blips info : https://github.com/glitchdetector/fivem-blip-info
