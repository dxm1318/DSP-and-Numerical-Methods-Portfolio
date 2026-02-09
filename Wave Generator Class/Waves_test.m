fs = 48000;
f = 2000;
dur = 5;

%generate sine wave
sine = Waves(fs,f,dur,'sine');
gen_sine = sine.generate;
sine.plotwave();

%generate sawtooth wave

saw = Waves(fs,f,dur,'sawtooth');
gen_saw = saw.generate;
saw.plotwave();


%generate square wave

sq = Waves(fs,f,dur,'square');
gen_sq = sq.generate;
sq.plotwave();



%generate triangle wave

triangle = Waves(fs,f,dur,'triangle');
gen_triangle = triangle.generate;
triangle.plotwave();
