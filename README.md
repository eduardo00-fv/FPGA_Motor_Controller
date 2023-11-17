# FPGA_Motor_Controller
FPGA Motor controller using verilog

## Project Overview

The project aims to implement the speed control of a DC motor using digital logic, with manual or automatic adjustment through an analog sensor. The user can select the control type (manual or automatic) using a switch and start the motor with another switch.

### Inputs

The system takes two analog signals as inputs:

1. Rotary Potentiometer Signal: Represents the user-adjusted speed using a rotary knob.
2. Resistive Sensor Signal: Derived from a resistive sensor (e.g., thermistor, LDR, FSR) providing additional feedback.
These analog values are converted to digital values using an Analog-to-Digital Converter (ADC-0808 in this case).

### Motor Speed Control

The motor's maximum speed corresponds to the value 15, and the minimum speed is 0, indicating that the motor should not rotate.
The range of the sensor should be accurately reflected in the motor speed output.

## Outputs

1. Two 7-Segment Displays: Show the current speed level. Utilize the available 7-segment displays on the FPGA board.

2. Eight-LED Bar: Represented consecutively. No LED should be lit at speed 0, and all LEDs should be on at speed 15. The number of active LEDs for intermediate speeds should be representative of the covered range.

3. External LCD Display: The top row displays the exact motor speed. The bottom row emulates a speed range bar with 10 cells, similar to the LED bar. When the motor is stopped, it should display "Motor Stopped." Additionally, when the motor reaches maximum speed, it should display "Maximum Speed."

4. PWM Control Signal for DC Motor: This signal includes a power interface separating the motor control circuit from the power supply, ensuring the required current is provided.