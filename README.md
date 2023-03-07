# State-feedback control with integral action

The model and the code show the implementation of a state-feedback controller with integral action in Xcos.

Code created to support a Linkedin post. Follow me on Linkedin! https://www.linkedin.com/in/simone-bertoni-control-eng/

Original post: https://www.linkedin.com/posts/simone-bertoni-control-eng_state-feedback-control-with-integral-action-activity-7038780323064635392-kf9f?utm_source=share&utm_medium=member_desktop

--------------------------------------------------------------------------------------------------------------------------

Is PID control all you know?

That's probably not enough.

State feedback control is a useful alternative.

I have shown the canonical approach in the past (link in the comments).

However the canonical approach has a limitation: it doesn't use integral action, which can cause a steady-state error.

But we can fix that.

Let's see how in a practical example.

A box of mass m = 10 kg, sliding on a surface where it's subject to viscous friction of coefficient k = 0.5 N*s/m, pushed by a force F. It is also subject to an unknown resistance Fd.

The dynamic equation is:

d^2z/dt^2 m = F - k * dz/dt - Fd

We have seen in the past that such a system can be described in a continuous-time state-space model where the two states are z (position) and dz/dt (speed).

Let's choose a control input that includes the integral of the control error:

F = kr*r - k1*z - k2*dz/dt + k3*integral(r - z)

and substitute in the dynamic equation:

d^2z/dt^2 m = kr*r - k1*z - k2*dz/dt + k3*integral(r - z) - k * dz/dt

then move to the Laplace domain:

m*Z(s)*s^2 + (k2 + k)*Z(s)*s + k1*Z(s) + k3*Z(s)/s = kr*R(s) + k3*R(s)/s

and finally the close loop transfer function:

Gc(s) = Z(s)/R(s) = (s*kr/m + k3/m)/[s^3 + s^2*(k2+k)/m + s*k1/m + k3/m]

We now choose a target transfer function with the same form, as follows (time to 90% = ~10s and steady state gain = 1):

T(s) = (0.15*s + 0.064)/(s^3 + 1.2*s^2 + 0.48*s + 0.064)

To have Gc(s) = T(s) we need to choose our control parameters as follows:

✅ kr/m = 0.15 ➡ kr = 0.15m = 1.5

✅ k1/m = 0.48 ➡ k1 = 0.48m = 4.8

✅ (k2+k)/m = 1.2 ➡ k2 = 1.2m - k = 11.5

✅ k3/m = 0.064 ➡ k3 = 0.064m = 0.64

The simulation result (from Xcos) of the control algorithm designed above is shown in the picture below, where:

✅ The control algorithm is implemented in discrete time, with sample time T = 0.1s.

✅ It is assumed that only the position of the box can be measured, and Gaussian noise has been added to simulate an actual measurement.

✅ As the speed is not available I used a simple algorithm to calculate the derivative of the position as opposed to an observer, to simplify. The Z-transform of the filtered derivative is D(z) = (z-1)/(z*(T+T_c) - T_c)), where T_c = 0.4.

✅ The "ideal" response that we expect from T(s) = (0.15*s + 0.064)/(s^3 + 1.2*s^2 + 0.48*s + 0.064) is shown in the plot vs the response of the system.

✅ Whilst the controller was designed assuming a system with m = 10 kg and k = 0.5 N*s/m, the actual plant used in the simulation has m = 7 kg and k = 0.2 N*s/m. This is to test the robustness to uncertainties on the actual plant.

✅ The resistance force Fd is 100 N.

The link to the code is in the comments.

If you enjoyed this follow me for more tips on control and embedded software engineering.

Hit the 🔔 on my profile to get a notification for all my new posts.

Feel free to ask anything in the comments, I'll do my best to answer.

#controlsystems #embeddedsystems #softwareengineering #embeddedsoftware #controltheory
