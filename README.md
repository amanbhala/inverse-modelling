# Running the code
To run the code, run the first 5 cells which initialises all the functions and classes.
- `AII_model` class defines the parameters for defining Bingham distribution and other parameters needed for the forward and inverse model calculations.
- `scan_operation` function runs the forward model and generates ectScan results for a microtexture.
- `calculate_covariance_matrix` function runs the inverse model to retrieve Bingham distribution(cOdf) from ectScan data.

`z_re` and `z_im` are the real and imaginary ectScan values that will act as true data.
User can either provide their own true data. One such example is:
```
# True value
z_re = np.loadtxt("new_green_subsection_real_ect_values.csv", delimiter=',').flatten()
z_im = np.loadtxt("new_green_subsection_imag_ect_values.csv", delimiter=',').flatten()
```
or they can generate random microtexture and use that as true data and try to recover this data by running the inverse model. This can be done by running the following lines:
```
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
```

# IPython Notebook
In the `inverse_modelling.ipynb` file, there are three different examples of inverse model runs:
- Trying to learn only `eta` keeping all other parameters fixed
- Trying to learn all the four parameters together
- Trying to learn only `eta` keeping all other parameters fixed but generating `50` microtextures in every run
If you want to learn some other combination of parameters, then follow the below process:
- Udpate the `AII_model` class to take the specific parameters as input, you can specify multiple parameters from different cODF's here as well
- Update the `simulate_AII_model` function to pass the correct parameters when calling `AII_model` class
- Update the `log_likelihood` function, specifically the following lines to mention the parameters that the model is learning:
  ```
  def log_likelihood(params):
      start_time = time.time()
      # mu_psi, mu_theta , eta, kappa  = params
      parameters = [ 1 , 1.57 , params, 0.15]
      start_time_aiimodel = time.time()
      results = run_async(simulate_AII_model(parameters))
  ```
  ```
  def log_likelihood(params):
    start_time = time.time()
    mu_psi, mu_theta , eta, kappa  = params
    parameters = [mu_psi, mu_theta , eta, kappa]
    start_time_aiimodel = time.time()
    results = run_async(simulate_AII_model(parameters))
  ```
  **NOTE**, If you want to impose prior for the parameters, then you can uncomment the following lines in the `log_likelihood` function:
  ```
  # model.add(smp.uniform(mu_psi, lower=0 , upper=np.pi))
  # model.add(smp.uniform(mu_theta, lower=0 , upper=np.pi/2))
  # model.add(eta_kappa_function(eta,kappa))
  ```
  or you can create your own priors and mention them here.
