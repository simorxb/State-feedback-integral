// Define the name of the Xcos diagram to be loaded
scheme = "State feedback - integral\State feedback - integral.zcos";

// Load the Xcos diagram
importXcosDiagram(scheme);

// Define a string containing a list of parameters and their values
ctx = ["m = 7; k = 0.2; k1 = 4.8; k2 = 11.5; k3 = 0.64; kr = 1.5; stp = 100; Fd = 100; std_noise = 0.3; T = 0.1; T_c = 0.4;"];

// Set the context of the Xcos diagram to the values defined in `ctx`
scs_m.props.context = ctx;

// Simulate the Xcos diagram
xcos_simulate(scs_m, 4);

// Define a the ideal transfer function `SimpleSys`
s = %s;
SimpleSys = syslin('c', (0.15*s+0.4^3)/(s+0.4)^3);

// Create a time vector with a step size of 0.01 seconds
t = [0:0.01:40];

// Simulate a step response of `SimpleSys` over time `t`
z_id = csim('step', t, SimpleSys)*100;

// Create a subplot and plot the output `u_out` against time `u_out.time`
subplot(212);
h = plot(u_out.time, u_out.values, 'b-', 'LineWidth',4);
ax=gca();
set(gca(),"grid",[1 1]);
xlabel('t[s]', 'font_style', 'times bold', 'font_size', 4);
ylabel('F [N]', 'font_style', 'times bold', 'font_size', 4);

// Create another subplot and plot three outputs: `stp_out`, `z_id`, and `z_out`
subplot(211);
h = plot(stp_out.time, stp_out.values, 'r-', t, z_id, 'g-', z_out.time, z_out.values, 'b-', 'LineWidth',4);
l = legend("Setpoint", "Ideal", "Response");
l.font_size = 4;
ax=gca();
set(gca(),"grid",[1 1]);
xlabel('t[s]', 'font_style', 'times bold', 'font_size', 4);
ylabel('Position [m]', 'font_style', 'times bold', 'font_size', 4);
