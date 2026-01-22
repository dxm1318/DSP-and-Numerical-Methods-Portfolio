classdef biquad_filter
    %implementation of a biquad peaking filter
    properties
        fc %cutoff frequency
        Q %Q factor
        gain %dB
        fs %sampling rate
    end

    methods
        function obj = biquad_filter(fc,Q,gain,fs) 
            if nargin > 0
                obj.fc = fc;
                obj.Q = Q;
                obj.gain = gain;
                obj.fs = fs;
            end
        end
        
        function [a,b] = get_coeff(obj)
            w0 = 2*pi*obj.fc/obj.fs;
            alpha = sin(w0)/ (2*obj.Q);
            A = db2mag(obj.gain);

            a0 = 1+alpha*A;
            a1 = -2*cos(w0);
            a2 = 1-alpha*A;

            b0 = 1+alpha/A;
            b1 = -2*cos(w0);
            b2 = 1-alpha/A;
            
            a = [a0 a1 a2];
            b = [b0 b1 b2];

            %normalize coeff
            a = a/b0;
            b = b/b0;
        end

        function y = peaking_filter(obj,x)
            %x = input signal
            [a,b] = obj.get_coeff();
            y = filter(a,b,x);
        end

        function plot_freq_resp(obj)
            [a,b] = obj.get_coeff();
            freqz(a,b,2048, obj.fs);
        end

        function plot_sig(obj,x)
            figure;
            spectrogram(x,128,64,512,obj.fs);
        end
    end
end

      

                