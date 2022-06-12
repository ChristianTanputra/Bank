'Bank' app is written in SwiftUI.

Models contains 6 files, 5 for all the different API needs, and 1 to help with grouping of transactions in a Dictionary setting.

Views contains all of the views. Generic components are separated for reusability and dynamicity. Different views (excluding login and register group) are separated into different groups.

Controllers contain a main App file.

Service contains an Observable Object named Network, which will provide the whole app with token (when needed), and a couple of functions to help with token editing. It also contains a file named LocalNetwork, which houses all of the API request functions.
