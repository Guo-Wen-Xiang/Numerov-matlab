% -*- coding: utf-8 -*-

%{
Numerov Schrodinger equation solver

Description: This script solves the 1 dimensional time-independant Schrodinger equation for any given potential. It takes a potentiel as an entry and outputs the wanted energy level and a figure with the potential and the wave fonctions corresponding to the energy level that have been specicied. 

The script is adapted from Félix's python codes.

Indications: The script ask for the number of energy levels that are desired and the potential. The potential must be centered at x=0 (the programm will itself translate the potential in y so that all the values are positive). Also if the potential behaves weirdly or the desired number of energy level is big, you may encounter some problem with the MeetingPoints function. Usually changing the x_V_min and x_V_max fixes the problem.

Author: Guo Wenxiang
Email: Guo.Wenxiang@outlook.com

MIT License

Copyright (c) 2017 Félix Desrochers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
%}


% potential = x^2;

clc;
clear;

%--------------------------------------------------------------------------------
% Initializing parameters

% global parameters
global y WaveForward WaveBackward Potential Len step i_Merge

% Number of energy levels needed
%fid = fopen('Nlevel.dat', 'r');
%N_level = fscanf(fid, '%d');

N_step = 1e5;
x_min = -30.0;
x_max = 30.0;
step = (x_max - x_min)/N_step;
Len = N_step + 1;
i_Merge = 10;

WaveForward = zeros(2, Len);
WaveForward(1, :) = x_min : step : x_max;
WaveForward(2, 1) = 0;
WaveForward(2, 2) = step;

WaveBackward = zeros(2, Len);
WaveBackward(1, :) = x_min : step : x_max;
WaveBackward(2, Len) = 0;
WaveBackward(2, Len-1) = step;

y = zeros(2, Len);
y(1, :) = x_min : step : x_max;

Potential = zeros(1, Len);
for i = 1 : Len
    Potential(1, i) = WaveForward(1, i)^2/2;
end

%--------------------------------------------------------------------------------
% Numerov methods
% Continue if we don't obtain all the levels we need
iteration = 1;

E_level = zeros(1, N_level);

E_level = 0;
while iteration < 2

    E_guess = 200.934;

    V_eff = 2 * (E_guess - Potential);
    for i = 2 : Len
        if V_eff(1, i-1) * V_eff(1, i) < 0 && V_eff(1, i) > 0
            i_Merge = i;
            break;
        end
    end

    %diff = f(E_guess);

    E_level(1, N_lvl) = fzero(@f, E_guess);

    
    iteration = iteration + 1;

    E_guess 
end
%--------------------------------------------------------------------------------
% Output data and figures
E_level
plot(y(1, :), y(2, :))