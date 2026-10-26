# System map (DRAFT - read from the .slx XML, not yet verified in MATLAB)

Top model `mainModels/parrotMinidroneCompetition.slx`:
Signal Builder (AC cmd) -> **Flight Control System** (`controller/flightControlSystem.slx`) -> Nonlinear Airframe -> Sensors / Environment models -> back to controller; 3D visualization on the side.

## flightControlSystem (root)
Inputs: AC cmd, Sensors, Image Data. Outputs: Actuators (4 motor commands), Flag (stop sim).
- **Image Processing System**: PARROT image conversion -> threshold per pixel -> sum of white pixels -> threshold on total white pixels -> `Vision-based Data`.
- **Control System**:
  - **Path Planning**: takes reference cmds + estimated values + Vision-based Data, outputs `UpdatedReferenceCmds`. Uses a gain 0.0005 on the vision error, a latch value, and constant `zValue = -1.1`, `xValue = 0`. Line tracking and the landing/target logic are in here - read in MATLAB.
  - **State Estimator**: Altitude Estimator (Kalman, sonar + pressure, outlier handling), Attitude Estimator (pitch/roll Kalman, yaw integrator), XY Position Estimator (optical flow + accelerometer).
  - **Controller**: Position Controller, Yaw Controller, Altitude Controller, Attitude Controller, ControlMixer, thrustsToMotorCommands.
  - **Crash Predictor Flags**: geofencing error, altitude error vs 0.5 m, counters/thresholds -> stop-simulation `Flag`.

## Control loops
- Position (x,y): position controller -> velocity controller, LPF at 8 Hz on position error, earth->body frame rotation by yaw -> pitch/roll commands.
- Attitude: angle loop -> angular velocity loop -> tau_pitch, tau_roll.
- Yaw: P=0.004, I=0.002, D=0.3*0.004, saturation +-30 deg.
- Altitude: P_z=0.8, D_z=0.5, I=0.24, discrete integrator, hover feed-forward `-g*mass`, saturated by `Controller.totalThrustMaxRelative`; takeoff gain `Controller.takeoffGain` (Mambo 0.45).
- Mixer: `Controller.Q2Ts` -> per-motor thrust -> `Vehicle.Motor.thrustToMotorCommand`, motor directions [1 -1 1 -1], saturation at motor min/max.

## Parameters (tasks/*.m)
- `controllerVars.m`: `takeoffGain` 0.45 (Mambo), `totalThrustMaxRelative` 0.92.
- Other gains sit in library blocks (Position/Velocity controller, Angle/Angular-velocity loops) - open in MATLAB to read.

## To verify in MATLAB (needs Aerospace Blockset installed)
- Exact line-tracking law inside Path Planning (what the vision error is mapped to).
- Landing logic: how the landing target is detected and what triggers descent / stop flag.
- Position/velocity/angle loop gains.
