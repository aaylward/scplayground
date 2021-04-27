s.boot;
s.quit;

ServerOptions.inDevices;
ServerOptions.outDevices;
Server.default.options.inDevice_("Komplete Audio 6");
Server.default.options.outDevice_("Loopback Audio");



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
		1,
		b.bufnum,
		4,
		(
			Phasor.ar(0, 0.015 * BufRateScale.ir(b), 0, BufSamples.ir(b)-1)
			+ LFNoise1.ar(100).bipolar(0.05 * SampleRate.ir)
		) / BufSamples.ir(b),
		2,
		0,
		-1,
		512,
		0.5
	);
}.play
)

(
{
	GrainBuf.ar(
		2,
		Impulse.ar(55),
		0.5,
		b.bufnum,
		MouseX.kr(0.5, 2.1).poll,
		(
			Phasor.ar(0, 0.05 * BufRateScale.ir(b), 0, BufSamples.ir(b)-1)
			+ LFNoise1.ar(100).bipolar(0.05 * SampleRate.ir)
		) / BufSamples.ir(b),
		2,
		0,
		-1,
		512,
		0.5
	);
}.play
)



(
)

(
	var rippy;
	rippy = Buffer.readChannel(s, "/Users/andy/sounds/bloops.wav", 0, -1, channels:[0]);
{
	GrainBuf.ar(
		2,
		Impulse.ar(8),
		6,
		rippy.bufnum,
		1,
		(
			SinOsc.ar(0, 0.015 * BufRateScale.ir(rippy), 0, BufSamples.ir(rippy)-1)
			+ LFNoise1.ar(12).bipolar(0.15 * SampleRate.ir)
		) / BufSamples.ir(rippy),
		2,
		0,
		-1,
		16,
		0.3
	);
}.scope(1);
)



l = Buffer.readChannel(s, "/Users/andy/sounds/lineareye.wav", 0, -1, channels:[0]);

(
{
	GrainBuf.ar(
		2,
		Impulse.ar(1.5),
		12,
		l.bufnum,
		0.5,
		0,
		2,
		0,
		-1,
		512,
		0.25
	);
}.play
)

(
fork {
    loop {
        play {
            var mod = SinOsc.kr(Rand(0.1, 0.9), 0, Rand(4, 20));
            Pan2.ar(DynKlang.ar(`[ Array.rand(12, 200.0, 2000.0), Array.rand(0.2, 0.5, 0.04), mod ]), 1.0.rand)
                * EnvGen.kr(Env.sine(4), 0.5, 0.02, doneAction: Done.freeSelf)
        };
		(0.810810810810811).wait;
		//(0.405405405405405).wait;
        //2.wait;
    }
}
)

(
{
	var zz;
	zz = { LPF.ar(Saw.ar([MouseX.kr(55, 2200, 1), MouseX.kr(55, 2000, 1)],1,0.2), MouseY.kr(1e2,2e4,1), 0.2) }.scope(1);
}.play;
)


s.quit;