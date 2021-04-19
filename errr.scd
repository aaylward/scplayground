s.boot;

ServerOptions.inDevices;
Server.default.options.inDevice_("Komplete Audio 6");


{ [SinOsc.ar(200, 0, 0.2), SinOsc.ar(224, 0, 0.2)] }.play;
{ [SinOsc.ar(110, 0, 0.2), SinOsc.ar(114, 0, 0.2)] }.play;
{ [SinOsc.ar(55, 0, 0.2), SinOsc.ar(55, 0, 0.2)] }.play;

// load and play a sample
b = Buffer.readChannel(s, "/Users/andy/sounds/kick.wav", 0, -1, channels:[0]);

(
x = SynthDef("tutorial-PlayBuf",{ arg out = 0, bufnum;
    Out.ar( out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
    )
}).play(s,[\bufnum, b]);
)
x.free; b.free;

// play it weird
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

l = Buffer.readChannel(s, "/Users/andy/sounds/lineareye.wav", 0, -1, channels:[0]);

(
{
	GrainBuf.ar(
		2,
		Impulse.ar(8),
		1/16,
		l.bufnum,
		4,
		(
			Phasor.ar(0, 0.015 * BufRateScale.ir(l), 0, BufSamples.ir(l)-1)
			+ LFNoise1.ar(100).bipolar(0.05 * SampleRate.ir)
		) / BufSamples.ir(l),
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