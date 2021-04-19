s.boot;
b = Buffer.readChannel(s, "/Users/andy/kick.wav", 0, -1, channels:[0]);
b.play;

ServerOptions.inDevices;
Server.default.options.inDevice_("Komplete Audio 6");

"Hello World!".postln;

{ [SinOsc.ar(200, 0, 0.2), SinOsc.ar(224, 0, 0.2)] }.play;
{ [SinOsc.ar(110, 0, 0.2), SinOsc.ar(114, 0, 0.2)] }.play;
{ [SinOsc.ar(55, 0, 0.2), SinOsc.ar(55, 0, 0.2)] }.play;

// read a soundfile
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

// now play it
(
x = SynthDef("tutorial-PlayBuf",{ arg out = 0, bufnum;
    Out.ar( out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
    )
}).play(s,[\bufnum, b]);
)
x.free; b.free;

(
{
	GrainBuf.ar(
		2,
		Impulse.ar(55),
		1/20,
		b.bufnum,
		4,
		(
			Phasor.ar(0, 0.015 * BufRateScale.ir(b), 0, BufSamples.ir(b)-1)
			+ LFNoise1.ar(100).bipolar(0.05 * SampleRate.ir)
		) / BufSamples.ir(b),
		2,
		0,
		-1,
		512
	);
}.play
)

(
{
	var zz;
	zz = { LPF.ar(Saw.ar([MouseX.kr(55, 2200, 1), MouseX.kr(55, 2000, 1)],1,0.2), MouseY.kr(1e2,2e4,1), 0.2) }.scope(1);
}.play;
)


s.quit;