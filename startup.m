% Add that folder plus all subfolders to the path.
folder = fileparts(which(mfilename)); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));
% Load pre-computed finite difference formulas.
global PDF
load(strcat(folder, '\diff\finite-differences.mat'), 'PDF')

set(0, 'defaultTextInterpreter', 'latex');
set(0, 'DefaultLegendInterpreter', 'latex')