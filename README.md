# Mocker Demonstration App

This "app" exists to demonstrate unit testing using the Strobl Approach with mocks originated using the Mocker application. The functionality in the app is trivial and makes use of code from [FunWithParticleEmitters](https://github.com/dkw5877/FunWithParticleEmitters).

![AppDemonstration](/assets/AppDemonstration.gif)

The view controller of the app in provided by a VIPER module called "Main". VIPER was used here because it allows for demonstration of unit testing the presenter and the interactor.

A "Demonstration" facade is implemented. One of the methods in the facade is actually used in the application. The other two methods are invented just for the purpose of illustrating unit testing techniques.

## Points of Interest

### \#1
Several protocols are defined so that **Foundation** classes can be dependency injected into objects for control during unit testing. In the project, the following protocols are created:

| Protocol  | Foundation Class | Implementation |
| --- | --- | --- |
| `DataRetreiving` | `URLSession` | `FoundationDataRetreiver` |
| `FileManaging`  | `FileManager` |
| `NotificationPosting`  | `NotificationCenter` |
| `TimerFactory`  | `Timer` | `FoundationTimerFactory` |
| `Timing`  | `Timer` |  |

### \#2

The interactor and presenter implementations are pretty bland for the Main module. However, 100% unit test code coverage is achieved on these objects providing a high level of confidence in the correctness of their implementations. Pay attention to the objects that are injected into both the interactor and presenter.

![MainCodeCoverage](/assets/MainCodeCoverage.png)

The presentor is interesting because it uses a timer to determine when to tell the view to remove the partical emitter and show the "Tap Me" button again. Both the `showConfetti()` and `showSnow()` use three unit tests to cover all the code including handling the timer firing.

| Tested Method  | Test for nil View | Test to Create Timer but not fire | Test to Create and Fire Timer | 
| --- | --- | --- | --- |
| `showConfetti()` | `testShowConfetti_viewIsNil` | `testShowConfetti_timerCreatedButNotFired` | `testShowConfetti_timerCreatedAndFired` |
| `showSnow()` | `testShowSnow_viewIsNil` | `testShowSnow_timerCreatedButNotFired` | `testShowSnow_timerCreatedAndFired` |


### \#3

100% code coverage is also acheived on the `DemonstrationFacade`. 

![FacadeCodeCoverage](/assets/FacadeCodeCoverage.png)

The tests for `retrieveSomeData(from url: URL)` demonstrate testing a network call. They execute both a failed attempt (where an error is thrown) and a successful attempt. In a real implemenation, where there may be inspection of the response and conversion of the response data into data transfer objects (DTO), logic for all the processing steps can be tested because of the ability to control the response and the injected components completely. 

Likewise, the tests for `pretendToCheckForFile(at url: URL)` can be perfectly controlled as well. When you have to do file operations it can be extremely difficult to execute the error paths. The Strobl Approach makes it possible to construst tests that execute all paths within a method. 

## License
[Unlicense](https://unlicense.org)

