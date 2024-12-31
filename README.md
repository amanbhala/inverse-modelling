# Running the code
To run the code, run the first 5 cells which initialises all the functions and classes.
- `AII_model` class defines the parameters for defining Bingham distribution and other parameters needed for the forward and inverse model calculations.
- `scan_operation` function runs the forward model and generates ectScan results for a microtexture.
- `calculate_covariance_matrix` function runs the inverse model to retrieve Bingham distribution(cOdf) from ectScan data.

`z_re` and `z_im` are the real and imaginary ectScan values that will act as true data.
User can either provide their own true data. One such example is:
`
# True value
z_re = np.loadtxt("new_green_subsection_real_ect_values.csv", delimiter=',').flatten()
z_im = np.loadtxt("new_green_subsection_imag_ect_values.csv", delimiter=',').flatten()
`

or they can generate random microtexture and use that as true data and try to recover this data by running the inverse model. This can be done by running the following lines:
`
# Run the below code to generate a random microtexture
start = time.time()
aiimodel=AII_model(0.1)
await aiimodel.async_init()
# Uncomment below line to save the data generated in a txt file which can then be used in mtex for plotting pole figures and orientation plots
# It's a good idea to change the value of self.number_of_microstructures to 1, so that it generates just 1 instance of microtexture instead of 30 which saves time
# aiimodel.write_data_to_new_file('recovered_parameters_green_subsection_1_5_0_0_9_0_5.txt')
aiimodel.scan_operation()
z_re = np.real(aiimodel.microstructure_list[1]['ectScan']['zl']).flatten()
z_im = np.imag(aiimodel.microstructure_list[1]['ectScan']['zl']).flatten()
`
