from manim import *

config.media_width = "75%"
config.verbosity = "WARNING"

import math as mth


%%manim -qm WaveFunction

class WaveFunction(Scene):
    def construct(self):
        
        
        # Change the background color
        self.camera.background_color = "#FFFFFF"  # Use any color you prefer
        
        # Set up the axes
        axes = Axes(
            x_range=[-10, 10, 1],
            y_range=[-4, 4, 0.5],
            axis_config={"color": WHITE}
        )
        
        # Label the axes
        x_label = axes.get_x_axis_label(Tex("x"))
        y_label = axes.get_y_axis_label(Tex(r"$\psi(x, t)$"))

        # Define parameters for the wave function
        k = 2  # Wavenumber
        omega = 1  # Angular frequency
        sigma = 1  # Width of the Gaussian


        #
        x_start = 0.0
        x_end   = 10*mth.pi
        num_points =1000

        N = 1000

        def complex_wave(amplitude, wavelength, frequency,x, time):

            # Generate the x values over the specified range
            #x_values = np.linspace(x_start, x_end, num_points)
            
            # Compute the complex wave across0 the entire array at once
            basis_wave = amplitude * np.exp(1j * (2 * np.pi * 1/wavelength * x - 2* np.pi*frequency*time))
            return basis_wave

        
        def momentum_wave_func(p):
            phi = 1.0*np.exp(-(p-N/2)**2/(N**2*2*np.pi))
            return phi
        
        # Define the wave function as a Gaussian wave packet
        def wave_func(k, x, t):
            sum_wave_func=0.5

            for i in range(N):
               sum_wave_func+=complex_wave(momentum_wave_func(i),i+1.0,2.0/(i+1), x,t) 

            return complex_wave(momentum_wave_func(k),k+1.0,2.0/(k+1), x,t)

        
        # Create a time tracker
        time_tracker = ValueTracker(0)

        # Plot the wave function and update over time
        wave1 = always_redraw(lambda: axes.plot(
            lambda x: wave_func(1, x, time_tracker.get_value()), color=BLACK
        ))

        wave2 = always_redraw(lambda: axes.plot(
            lambda x: wave_func(2, x, time_tracker.get_value()), color=BLACK
        ))

        # Add the components to the scene
        self.add(wave1, wave2)
        
        # Animate the time tracker to make the wave evolve
        self.play(time_tracker.animate.set_value(10), run_time=10, rate_func=linear)
