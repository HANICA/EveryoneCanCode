# EveryoneCanCode - Guided Project / Restaurant

The OrderApp from the teaching materials is included.
We have made a few changes: the decodable protocol seems to be very unforgiving and this is even more so for the way the proposed app was formed, especially considering the images. This is problematic since some items from the OrderApp were not 1-on-1 with the RestaurantServer app and the menu.json.

- imageName from the menu.json is called imageURL in the OrderApp (MenuItem), we have updated the menu.json to imageURL
- We have made imageURL optional and if it is nil it is not force-unwrapped.

## ToDo:
- there should be better feedback on decoding JSON to the objects, jsonDecoder.decode(MenuItems.self, from: data) either succeeds or fails and seems to fail on every little detail without a good way to debug / trace reasons.
