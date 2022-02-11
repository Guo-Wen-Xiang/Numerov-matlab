% -*- coding: utf-8 -*-

%{
Description: 

Author: Guo Wenxiang
Email: Guo.Wenxiang@outlook.com

MIT License

Copyright (c) 2022 Guo Wenxiang

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to dealing the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%}

function diff = f(E_guess)

    global y WaveForward WaveBackward step i_Merge

    [y, ratio] = Wave(E_guess);

    diff = (ratio * (WaveBackward(2, i_Merge+1) - WaveBackward(2, i_Merge-1)) - (WaveForward(2, i_Merge+1) - WaveForward(2, i_Merge-1))) / (2*step) / WaveForward(2, i_Merge); 
end