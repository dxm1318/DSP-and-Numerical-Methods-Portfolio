classdef Waves
    %requires Signal Processing Toolbox
    properties
        fs %sample rate
        f %frequency
        dur %duration
        type %type of wave generated
    end
    methods
        function obj = Waves(fs,f,dur,type)
            if nargin > 0
                obj.fs = fs;
                obj.f = f;
                obj.dur = dur;
                obj.type = type;
            end
        end
        function gen_wave = generate(obj)
            t = 0:1/obj.fs:obj.dur-1/obj.fs;
            %gen_wave = generated wave
            if strcmp(obj.type,'sine')
                gen_wave = sin(2*pi*obj.f*t);

            elseif strcmp(obj.type,'sawtooth')
                gen_wave = sawtooth(2*pi*obj.f*t);

            elseif strcmp(obj.type,'square')
                gen_wave = square(2*pi*obj.f*t);

            elseif strcmp(obj.type,'triangle')
                gen_wave = sawtooth(2*pi*obj.f*t,0.5);

            else
                error('Please display a valid wave type');
            end
        end

        function plotwave(obj)
            gen_wave = obj.generate();
            figure;
            subplot(2,1,1);
            plot(gen_wave);
            title(obj.type);
            subplot(2,1,2);
            spectrogram(gen_wave,128,64,512,obj.fs);
            title('Spectrogram');
        end
    end
end

              

       
