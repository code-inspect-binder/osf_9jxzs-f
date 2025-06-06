1. Overview

The repository contains the following folders:

- data: Here, all processed data for analysis is stored
- etc: Some global specifications for plots are saved in this folder
- lib: A global list of R pacakages and custom functions is provided in this folder
- src: R scripts could be found here

For details on each folder, the reader is refered to section 3.

2. Get started
If one wants to start the analysis, install R 4.1.1, RStudio 1.4.1717, and RTools 4.0 
(for further instructions on this, consult https://cran.r-project.org/bin/windows/Rtools/rtools40.html). 
Then, just open the RedSeaMP.Rproj file. Before running any R script,
install the following packages by hand.

- groundhog 1.5.0

All other packages will be automatically installed by groundhog as soon as the first script is run. Note that this can take several minutes.

3. Folders
3.1 data

List of content:

- Data_RedSeaMP_FTIR_Final.txt

	Variables

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"replicate": A counter for the replicates on a specific sample site.

		"location": Describes where the spectra were obtained. Inside means that the measurement was taken on the intersection after cutting the MP particle in halves, whereas Outside indicates that spectra were recorded on the particle surface.

		"wavenumber [1/cm]": Span of wavenumbers that were meausred during FTIR.

		"intensity [a. u.]": Intensity at a certain wavenumber.

		"id": A numerical identifier for each MP particle.


- Data_RedSeaMP_PSDShape_Final.txt

	Variables

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"diam [mm o. µm]": Equivalent diameter of a ball as an estimate for 3D particle diameter.
		
		"f1 [-]": Shape descriptor f1.
		
		"flatness [-]": 3D flatness.
		
		"elongation [-]": 3D elongation. 


- Data_RedSeaMP_Color_Final.txt

	Variables

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"colour": A character that names the respective color.

		"percentage [%]": Proportion of the color in the subsample.


- Data_RedSeaMP_Mass_Final.txt

	Variables

		"replicate": A counter for the replicates on a specific sample site.

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"mass [g]": The mass of the MP resin pellet.


- Data_RedSeaMP_DSC_Thermal_Final.txt

	Variables

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"replicate": A counter for the replicates on a specific sample site.

		"time [min]": Measurment time.

		"temp [°C]": Temperature at a given time point.

		"heatcap [mW/mg]": Heat capacity at a given time point.

		"id": An identifier for each MP particle.

		"stadium": This character describes the heating or cooling cycle.


- Data_RedSeaMP_DSC_Crystallinity_Final.txt

	Variables

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"crystallinity [%]": Calculated crystallinity of the MP resin pellet.


- Data_RedSeaMP_GPC_Raw.txt

	Variables

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"Mn [kg/mol]": Number average molar mass.

		"Mw: [kg/mol]": Mass average molar mass.


- Data_ReadSeaMP_Rheology_Final.txt

	Variables

		"site": This variable describes the sample sites on which the respective MP resin pellts was found. Either "Beach" or "Wreck".

		"Freq [rad/s]": Frequency.

		"G' [Pa]": Storage modulus G' at a given frequency.

		"G\" [Pa]": Loss modulus G'' at a given frequency.

		"n* [Pa s]": Complex viscosity at a given frequency.

		"tan [-]": Loss tangent (G''\G') at a given frequency.


3.2 etc

List of content:

- globalSettingsForPlots.R

	This file stores global settings for plots, e.g., colors and font size.


3.3 lib

List of content:

- function_errorbars.R 

	Function to add errorbars to bargraphs.

- package_globalList.R

	From this list of R packages, all additional functions are loaded.
	

3.4 src
The subfolder "src" contains all R scripts relevant for obtaining summary statistics, plots, and results of null hypothesis signficance testing.
Files are numbered according to the order in which the corresponding sections appear in the Results chapter of the main text.

List of content:

- 01_analysis_ftir.R
	
	This code generates the plots of FTIR spectra.

- 02_analysis_particle-measurement.R

	Here, summary statistics of particle size and the three shape descriptors are calculated. Also. frequency distributions are drawn.

- 03_analysis_color.R
	
	Computes the lollipop plot of color proportions.

- 04_analysis_mass.R

	This script is used to calculate summary statistics, percentage change, and conduct null hypothesis siginficance testing.

- 05_analysis_dsc.R

	Visualizes DSC thermal curves and checks for deviations of crystallinity between sample sites.

- 06_analysis_gpc.R

	Loads data from ter Halle and co-workers (doi: 10.1016/j.envpol.2017.04.051) as a reference and compares their values with our own.

- 07_analysis_rheology.R

	We visualize the rheological measures in a panel.