# **PID Control**

[//]: # (Image References)

[image1]: ./images/import.jpg "import"
[image2]: ./images/existing_project.jpg "existing project"
[image3]: ./images/select_project.png "select project"
[image4]: ./images/final.png "final"
[image5]: ./images/build_all.png "build all"
[image6]: ./images/run_as.png "run as"
[image7]: ./images/simulator.png "simulator"
[image8]: ./images/pid.png "PID"
[image9]: ./images/effect.png "effect"
[image10]: ./images/p.png "p"
[image11]: ./images/pd.png "pd"
[image12]: ./images/i.png "i"

**PID Control Project**

## Goals
In this project you'll revisit the lake race track from the Behavioral Cloning Project. This time, however, you'll implement a PID controller in C++ to maneuver the vehicle around the track!

The simulator will provide you the cross track error (CTE) and the velocity (mph) in order to compute the appropriate steering angle.

One more thing. The speed limit has been increased from 30 mph to 100 mph. Get ready to channel your inner Vin Diesel and try to drive __SAFELY__ as fast as possible! 

__NOTE__: you don't have to meet a minimum speed to pass.

---
## Dependencies

* [simulator](https://github.com/udacity/self-driving-car-sim/releases)

## Environment Setup

1. Open Eclipse IDE

__Linux__:
```
docker run --rm --name pid \
    --net=host -e DISPLAY=$DISPLAY \
    -v $HOME/.Xauthority:/root/.Xauthority \
    dragon7/carnd-pid-control-project
```

__Mac__:
```
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"

docker run --rm --name pid \
    -e DISPLAY=[IP_ADDRESS]:0 \
    -p 4567:4567 \
    dragon7/carnd-pid-control-project
```

2. Import the project into Eclipse

    1. Open Eclipse.
    2. Import project using Menu `File > Import`
    ![alt text][image1]
    3. Select `General > Existing projects into workspace`
    ![alt text][image2]
    4. **Browse** `/root/workspace/CarND-PID-Control-Project/build` and select the root build tree directory. Keep "Copy projects into workspace" unchecked.
    ![alt text][image3]
    5. Now you should have a fully functional eclipse project
    ![alt text][image4]

3. Code Style

    1. From Eclipse go to `Window > Preferences > C/C++ > Code Style > Formatter`
    2. Click Import
    3. Select `/root/workspace/eclipse-cpp-google-style.xml`
    4. Click Ok

4. Build

    * Select `Project -> Build All`
    ![alt text][image5]

    __OPTIONAL__: Build on command line
    ```
    cd /root/workspace/CarND-PID-Control-Project/build
    make
    ```

5. Run

    * `Right click Project -> Run as -> 1 Local C++ Application`
    ![alt text][image6]

    __OPTIONAL__: Run on command line
    
    `./pid`


6. Launch simulator

![alt text][image7]

---
## Reflection

### Describe the effect each of the P, I, D components had in your implementation.

![alt text][image8]

![alt text][image9]

|              | P Controller               | PD Controller            | PID Controller         | Twiddle PID Controller          |
|:------------:|:--------------------------:|:------------------------:|:----------------------:|:-------------------------------:|
| effect       | marginally stable          | solve overshoot          | solve systematic bias  | parameters (P,I,D) optimization |
| side effect  | overshoot, systematic bias | systematic bias          |                        |                                 |

1. P Component

![alt text][image10]

2. D Component

![alt text][image11]

3. I Component

![alt text][image12]

### Describe how the final hyperparameters were chosen.



---
## Result


