%% Import Script for EBSD Data
%
% This script was automatically created by the import wizard. You should
% run the whoole script or parts of it in order to import your data. There
% is no problem in making any changes to this script.

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = {... 
  'notIndexed',...
  crystalSymmetry('6/mmm', [3 3 4.7], 'X||a*', 'Y||b', 'Z||c*', 'mineral', 'Titanium')};

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');

%% Specify File Names

% path to files
pname = 'C:\Users\abhala1.ASURITE\Downloads\PythonSimulation';

% which files to be imported
fname = [pname '\recovered_parameters_green_subsection1.txt'];

%% Import the Data

% create an EBSD variable containing the data
ebsd = EBSD.load(fname,CS,'interface','generic',...
  'ColumnNames', { 'x' 'y' 'phi1' 'Phi' 'phi2'}, 'Bunge', 'Radians');


plot(ebsd, ebsd.orientations);

%plotPDF(ebsd.orientations,Miller(0,0,1,ebsd.CS),'points','all');