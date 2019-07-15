# MapPinsMVVM

A UITabBarController-based app with MVVM architecture. The view models get their data from a shared model object which is instantiated in the app delegate. 

Deleting a row from the table, for example, calls a method on its delegate (the tableview controller), which in turn calls a method on its view model, which then calls a method on the model. The model makes the appropriate change and sends a notification to the view controllers. The view controllers ask their view models for updated information when the notification comes through.

Persistence store is serializing objects to .json archive.

Time elapsed: approx 6 hours.

Extra credit: 
* delete rows from the tableview and see them disappear from the map
* unit test for deleting rows
* re-sync pins from server
