
% -*- coding: utf-8 -*-

%{
Description: This module defines a Numerov Scrodinger equation solver function.

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

function WaveFunction = WaveFunctionNumerov(WaveFunction, E_guess, sgn)
    %{
        This function calculates the wave function values depending on the potential by using the Numerov method. The function returns a matrix that contains the wave function value.
    Parameter:
    ----------
        WaveFunction: the initialized wave function with the coordinates in the first row, the first two columns as the initial
        V_eff: 2 * (E_guess - Potential)
        Len: the size of the wave function matrix
        E_guess: the energy level guessed
        h: the step
        sgn: +1 (forward propagating), -1 (backward propagating)

    Returns:
    --------
        WaveFunction (2 * Len, matrix)
    %}
    global Potential Len step

    if size(WaveFunction, 2) ~= size(Potential, 2)
        error('Error!!!\nThe size of WaveFunction or Potential Wrong!')
    end

    V_eff = 2 * (E_guess - Potential);

    for j = 3 : Len

        % Forward or backward propagating
        if sgn == -1
            i = Len - j + 1;
        else
            i = j;
        end

        c0 = 1/12 * step^2 * V_eff(1, i);
        c1 = 1/12 * step^2 * V_eff(1, i - sgn*1);
        c2 = 1/12 * step^2 * V_eff(1, i - sgn*2);
        
        WaveFunction(2, i) = ((2 - 10*c1) * WaveFunction(2, i - sgn*1) - (1 + c2) * WaveFunction(2, i - sgn*2)) / (1 + c0);
    end
end