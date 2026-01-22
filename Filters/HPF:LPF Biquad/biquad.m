classdef biquad
    properties
        fs 
        fc
        gain
        type
        a0
        a1
        a2
        b0
        b1
        b2
    end

    methods
        
        function obj = biquad(fc,gain,type,fs) %constructor function
            if nargin > 0
            obj.fc = fc; %cutoff
            obj.fs = fs; %sample rate
            obj.gain = gain;
            obj.type = type;  %type of filter: LPF or HPF
            end 
        end
        function obj = computeCoeff(obj)
            w0 = (2*pi*obj.fc)/ obj.fs;
            Q = 1/sqrt(2); %quality factor
            alpha = sin(w0)/(2*Q);
            %coefficients are from Digital Audio Theory (Bennett) Ch. 10.5
            if strcmp(obj.type,'LPF')
                obj.a0 = (1-cos(w0))/2;
                obj.a1 = 1-cos(w0);
                obj.a2 = (1-cos(w0))/2;
                obj.b0 = 1 + alpha;
                obj.b1 = -2*cos(w0);
                obj.b2 = 1- alpha;
            elseif strcmp(obj.type,'HPF')
                obj.a0 = (1+cos(w0))/2;
                obj.a1 = -(1-cos(w0));
                obj.a2 = (1+cos(w0))/2;
                obj.b0 = 1 + alpha;
                obj.b1 = -2*cos(w0);
                obj.b2 = 1 - alpha;
            else
                disp('For type of filter, please input "LPF" or "HPF".')
            end
            obj.a0 = obj.a0/obj.b0;
            obj.a1 = obj.a1/obj.b0;
            obj.a2 = obj.a2/obj.b0;
            obj.b1 = obj.b1/obj.b0;
            obj.b2 = obj.b2/obj.b0;
            obj.b0 = 1;
                 
            disp([obj.a0,obj.a1,obj.a2,obj.b0,obj.b1,obj.b2]/obj.b0);
        end
           
        function y = filter_sig(obj,x) %x = input signal
            gain_linear = 10^(obj.gain/20);
            y = filter([obj.a0 obj.a1 obj.a2],[obj.b0 obj.b1 obj.b2],x);       
            y = y*gain_linear;
        end
    end
end


              




