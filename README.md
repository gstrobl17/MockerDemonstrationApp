# Mocker Demonstration App

This "app" exists to demonstrate unit testing using the [Strobl Approach](https://gist.github.com/gstrobl17/1153977444aeac0c4f1722fecccb97e1) with mocks originated using the Mocker application. The app's functionality is trivial and uses code from [FunWithParticleEmitters](https://github.com/dkw5877/FunWithParticleEmitters).

![AppDemonstration](/assets/AppDemonstration.gif)

The app's view controller is provided by a VIPER module called "Main". VIPER was used here because it allows demonstrating unit testing of the presenter and the interactor.

A "Demonstration" facade is implemented. One of the methods in the facade is used in the application. The other two methods are invented to illustrate unit testing techniques.

## Points of Interest

### \#1
Several protocols are defined so that **Foundation** classes can be dependency injected into objects for control during unit testing. In the project, the following protocols are created:

| Protocol  | Related Foundation Class | Implementation |
| --- | --- | --- |
| `DataRetreiving` | `URLSession` | `FoundationDataRetreiver` |
| `FileManaging`  | `FileManager` |
| `NotificationPosting`  | `NotificationCenter` |
| `TimerFactory`  | `Timer` | `FoundationTimerFactory` |
| `Timing`  | `Timer` |  |

### \#2

The interactor and presenter implementations are pretty bland for the Main module. However, 100% unit test code coverage is achieved on these objects providing a high level of confidence in the correctness of their implementations. Pay attention to the objects injected into the interactor and presenter.

![MainCodeCoverage](/assets/MainCodeCoverage.png)

The presenter is interesting because it uses a timer to determine when to tell the view to remove the particle emitter and show the "Tap Me" button again. The `showConfetti()` and `showSnow()` use three unit tests to cover all the code, including handling the timer firing.

| Tested Method  | Test for nil View | Test to Create Timer but not fire | Test to Create and Fire Timer | 
| --- | --- | --- | --- |
| `showConfetti()` | `testShowConfetti_viewIsNil` | `testShowConfetti_timerCreatedButNotFired` | `testShowConfetti_timerCreatedAndFired` |
| `showSnow()` | `testShowSnow_viewIsNil` | `testShowSnow_timerCreatedButNotFired` | `testShowSnow_timerCreatedAndFired` |


### \#3

100% code coverage is also achieved on the `DemonstrationFacade`. 

![FacadeCodeCoverage](/assets/FacadeCodeCoverage.png)

The tests for `retrieveSomeData(from url: URL)` demonstrate testing a network call. They execute both a failed attempt (where an error is thrown) and a successful attempt. In an actual implementation, where there may be an inspection of the response and conversion of the response data into data transfer objects (DTO), the logic for all the processing steps can be tested because of the ability to control the response and the injected components completely. 

Likewise, the tests for `pretendToCheckForFile(at url: URL)` can also be perfectly controlled. When you have to do file operations, executing the error paths can be extremely difficult. The [Strobl Approach](https://gist.github.com/gstrobl17/1153977444aeac0c4f1722fecccb97e1) makes constructing tests that perform all paths within a method possible. 

## License
[Unlicense](https://unlicense.org)

