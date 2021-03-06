s.boot;
s.quit;
ServerOptions.inDevices;
Server.default.options.inDevice_("Komplete Audio 6");
Server.default.options.outDevice_("Loopback Audio");

"open -a 'Audio MIDI Setup'".unixCmd;

{ Out.ar(GbmanN.ar([2300,2300]),LFSaw.ar(Pulse.ar(4,[1,2],1,LFPulse.ar(1)))+2) }.play;
{ Saw.ar(XLine.kr(100,15000,6),0.2) }.scope(1);
{ Blip.ar(XLine.kr([30, 30],[550, 500],1),1,0.2) }.scope(1);
{ Saw.ar(XLine.kr([30, 30],0.5,1),0.5,0.2) }.scope(1);
{ Saw.ar(XLine.kr([30, 30],[250, 200],1),1,0.2) }.scope(1);

{ Blip.ar([MouseX.kr(55, 2200, 1), MouseX.kr(11, 2000, 1)],1,0.2) }.scope(1);
{ Blip.ar(XLine.kr([30, 30],[550, 500],1),100,0.2) }.scope(1);

{ SinOsc.ar(SinOsc.kr([55, 55], 0, 50),0, 1) }.scope(1);

{ LPF.ar(Saw.ar([MouseX.kr(55, 2200, 1), MouseX.kr(11, 2000, 1)],1,0.2), MouseY.kr(1e2,2e4,1), 0.2) }.scope(1);

{ Blip.ar([XLine.kr(550, 22, 0.345), XLine.kr(550, 22, 0.345)],1,0.2) }.scope(1);

{ SinOsc.ar([XLine.kr(2600, 22, 0.1724), XLine.kr(2600, 22, 0.1724)],1,0.2) }.scope(1);

(
{
	var pitchEnv = Env([4, 0.3, 1, 0.6, 0.2], [0, 0.01, 0.15, 0.7, 1], curve: 'exp');
	var another1 = Env([4, 0.3, 1, 0.6, 0.2], [0, 0.01, 0.15, 0.7, 1], curve: 'exp').plot;
	var ampEnv = Env([0, 1, 0.5, 0], [0, 0.001, 0.5, 0.5]);
	var filterEnv = Env([0, 0.1, 0.2, 1], [0, 0.5, 0.5, 0.5]);
	HPF.ar(
		Saw.ar(
			[EnvGen.kr(pitchEnv, doneAction: Done.freeSelf) * 1000, EnvGen.kr(pitchEnv, doneAction: Done.freeSelf) * 1000],
			EnvGen.kr(ampEnv, doneAction: Done.freeSelf)),
		EnvGen.kr(filterEnv, doneAction: Done.freeSelf) * 2000
	)
}.scope(1);
)

(
z = {
	arg noiseHz = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200, 1000);
	amp = LFNoise1.kr(12).exprange(0.02, 1);
	sig = SinOsc.ar([freq, freq + 5]) * amp;
}.play;
)

z.set(\noiseHz, 16);
z.set(\noiseHz, 8);

z.free;

(
{
	var x = SinOsc.ar(MouseX.kr(1, 100), 0, MouseY.kr(0, 1));
	//var x = Saw.ar(MouseX.kr(1, 100), MouseY.kr(0, 1));
	//SinOsc.ar([300 * x + 700, 300 * x + 690], 0, 0.5)
	Saw.ar([300 * x + 700, 300 * x + 690], 0.5)
}.scope(1);
)