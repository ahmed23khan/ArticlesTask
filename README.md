# SmartDubai
This repository is for an assignment


### How to run the app
 - Pull the latest code from "https://github.com/ahmed23khan/SmartDubai.git"
 - Open the folder SmartDubai/Articles
 - Double Click Articles.xcodeproj
 - Select Articles Target and Select iPhone 13 Pro Max
 - Click on Run or ⌘R
 
### How to test the app
 - Pull the latest code from "https://github.com/ahmed23khan/SmartDubai.git"
 - Open the folder SmartDubai/Articles
 - Double Click Articles.xcodeproj
 - Select Articles Target
 - Select Product-> Test
 - Click on Products and Test or ⌘U

### Code Walkthrough 
- **Design Pattern**: MVVM
- **ArticleViewController**: Class contains view related code like Initialising UI and updating the UI after fetching data from API.
- **ArticleViewModel**: Contains the business logic and the intermediate between View (ArticleViewController) and the Model(Article) binded by closure callbacks.
- **Article** : Class that acts the model to contains the data fetched from API.
- **ArticleTableViewCell**: A custom class for custom cells inheriting from UITableViewCell.
- **ArticleDetailViewController**: A detail view class, which displays data of the selected article.

 * **Network Layer** :
 
     *The network layer is implemented using the Protocol Oriented Programming (POP) paradigm to make it modular,testable and mockable.

- **ProviderProtocol**: A provider Protocol acts as a provider to send requests.
- **URLSessionProtocol**: This protocol is used for creating stubs and mock objects to test the Network layer.
- **URLSessionProvider**: URLSessionProvider conforms to ProviderProtocol. This approach is necessary to test network layer. It’s essential because in easy way you can switch session with mock file and simulate responses from API without internet connection.
- **RequestProviding**: A protocol to build the URL with baseURL, apiKey and period seleced.

### Class Diagram
![Alt text](https://github.com/ahmed23khan/SmartDubai/blob/adabd611da59f4da0c2f9752a0fe52d1e29a0c84/Class_Diagram.png)


# Code Coverage Report
![alt text](https://github.com/ahmed23khan/SmartDubai/blob/adabd611da59f4da0c2f9752a0fe52d1e29a0c84/Code_Coverage.png)


# Screen Shots

![alt text](https://github.com/ahmed23khan/SmartDubai/blob/adabd611da59f4da0c2f9752a0fe52d1e29a0c84/screenshot4.png)

![alt text](https://github.com/ahmed23khan/SmartDubai/blob/adabd611da59f4da0c2f9752a0fe52d1e29a0c84/Screenshot3.png)
