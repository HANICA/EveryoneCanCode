# EveryoneCanCode - Guided Project / Restaurant

The OrderApp from the teaching materials is included.
We have made a few changes: the decodable protocol seems to be very unforgiving and this is even more so for the way the proposed app was formed, especially considering the images. This is problematic since some items from the OrderApp were not 1-on-1 with the RestaurantServer app and the menu.json.

- imageName from the menu.json is called imageURL in the OrderApp (MenuItem), we have updated the menu.json to imageURL
- We have made imageURL String instead of URL to avoid a decodable problem we ran into
- images now work in the detail views with server 1.0.4+, not yet in the master view of the categories
- we have changed fetchImage a little: if no http is found in the imageURL, it will append the default baseURL to the front of the url

## ToDo:
- there should be better feedback on decoding JSON to the objects, jsonDecoder.decode(MenuItems.self, from: data) either succeeds or fails and seems to fail on every little detail without a good way to debug / trace reasons.

## Notes:

I changed the baseURL in MenuController(.swift) to my RestaurantServer hostname (http://macbook-pro.local:8090/ in my case), if you work on the same machine (using iPhone simulator), you could/should use http://localhost:8090/ as the local address.



