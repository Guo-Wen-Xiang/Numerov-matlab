% -*- coding: utf-8 -*-

%{
Author: Guo Wenxiang
Email: Guo.Wenxiang@outlook.com

MIT License

Copyright (c) 2022 Guo Wenxiang

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

function [WaveFunction, ratio] = Wave(E_guess)
    %{
        This function This function merges the forward and backward wave functions at merging point ic.
    Parameter:
    ----------
        y1: forward wave function
        y2: backward wave function
        Len: the size of the wave function matrix
        i_Merge : merging point

    Returns:
    --------
        y (2 * Len, matrix)
    %}
    global WaveForward WaveBackward i_Merge Len

    WaveForward = WaveFunctionNumerov(WaveForward, E_guess, 1);
    WaveBackward = WaveFunctionNumerov(WaveBackward, E_guess, -1);

    WaveFunction = WaveForward;

    ratio = WaveForward(2, i_Merge) / WaveBackward(2, i_Merge);

    % Merge at ic
    
    prob = zeros(1, Len);

    for i = 1 : Len

        if i > i_Merge
            WaveFunction(2, i) = WaveBackward(2, i) * ratio; 
        end

        prob(1, i) = WaveFunction(2, i)^2;

    end

    % Normalization
    sum = trapz(WaveFunction(1, :), prob(1, :));
    WaveFunction(2, :) = WaveFunction(2, :) / sqrt(sum);

end