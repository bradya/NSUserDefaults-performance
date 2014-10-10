NSUserDefaults-performance
==========================

Quickly built this to test NSUserDefaults performance and scalability. To see for yourself, open the project in Xcode and run the tests.

### Results (1000 iterations)

NSUserDefaults, setObject, synch after, empty defaults
    Avg. Runtime:   0.39 seconds

NSUserDefaults, setObject, no synch, empty defaults
    Avg. Runtime:   0.38 seconds

NSUserDefaults, setObject, synch after, 100 other strings in defaults
    Avg. Runtime:   4.70 seconds

NSUserDefaults, setObject, no synch, 100 other strings in defaults
    Avg. Runtime:   4.78 seconds

NSUserDefaults, setObject, synch after, 1000 other strings in defaults
    Avg. Runtime:  87.90 seconds

NSUserDefaults, setObject, no synch, 1000 other strings in defaults
    Avg. Runtime:  86.87 seconds

NSDictionary, setObject
    Avg. Runtime:   0.00132 seconds

### My conclusions
1. it's ok to call synchronize as much as you want
2. it's not ok to use NSUserDefaults for any code that is called often
