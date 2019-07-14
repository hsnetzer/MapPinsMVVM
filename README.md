# MapPinsMVVM

Persistence store: serializing objects to .json archive

Time elapsed: approx 6 hours

Extra credit: 
* delete rows from the tableview and see them remove from the map
* unit test for deleting rows
* re-sync pins from server

## discussion

I decided to make a UITabBarController-based app with MVVM architecture. The two tabs are the MapViewController and the ListViewController, each of which gets its data from its own viewmodel. The viewmodels get their data from a shared model object which is instantiated in the app delegate. 

By way of an example, deleting a row from the table will call a method on its delegate (the ListViewController), which similarly calls a method on its viewmodel, which similarly calls a method on the model. The model makes the appropriate change and sends a notification to the view controllers. The map view controller knows to ask its viewmodel for updated information when the notification comes through. 
