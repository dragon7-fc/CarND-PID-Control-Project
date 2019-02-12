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

The PID algorithm is implemented in line 24~26 and 33 of PID.cpp as below.

``` c++
  d_error = cte - p_error;
  p_error = cte;
  i_error += cte;
```

``` c++
  -Kp * p_error - Kd * d_error - Ki * i_error;
```

![alt text][image8]

1. P Component

From the formula, we can found that the P component control how the Cross Track Error (CTE), i.e. how far from road middle, affect the steering angle. If we got larger Kp, the steering angle would be more affected by CTE. If the car is far away from middle, this would be helpful. Because it need more steering angle to adjust to return back to center. But if the car is close to the middle. larger Kp would let the car overshoot or oscillate more quickly. However, if Kp is too small, it would not sensitive to land curvature.

![alt text][image10]

2. D Component

Besides P component, we added one D, i.e. differential, part to the formula to let the steering angle more smooth. Consider the car gradually leaves the middle, the would cause a positive differential. So we would get more steering angle to return back to center. IF the car is gradually back to middle, we got negative differential, and smaller steering angle. Make sense. But if Kd too large, it would make the steering angle change too rough. However, if the Kd is too small it can't solve the overshoot problem.

![alt text][image11]

3. I Component

In this portion, we add an I, i.e. integral, part to the equation. It looks like we compensate all previous error. If Ki is close to 1, the steering angle will sensitive to oscillation and can't go for high speed. If Ki close to 0, the car will tend to drift to one side of the lane for a long period of time.

![alt text][image12]

|              | P Controller               | PD Controller            | PID Controller         | Twiddle PID Controller          |
|:------------:|:--------------------------:|:------------------------:|:----------------------:|:-------------------------------:|
| effect       | marginally stable          | solve overshoot          | solve systematic bias  | parameters (P,I,D) optimization |
| side effect  | overshoot, systematic bias | systematic bias          |                        |                                 |

![alt text][image9]

### Describe how the final hyperparameters were chosen.

The final hyperparameter were chosen as below. Manually tuned these parameters with the base values gotten from PID Control lesson. Followed the procedure from P to D then I to tune these parameters. During P parameter tuning, I set D and I as zero. During D tuning, fixed P and let I as zero. Finally during I tuning, fixed P and D. Because the values got from the lesson almost already workable. I haven't implemented Twiddle algorithm to find the optimized parameters. I found that the result run from Udacity workspace and Mac is a little different, so I made some modification on these hyperparameters.

| coefficient | P        | I        | D        |
|-------------|----------|----------|----------|
| value       | 0.2      | 0.001    | 3        |
