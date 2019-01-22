<CsoundSynthesizer>
<CsOptions>
-odac ;-+rtaudio=jack
-d
--port=6006
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

chnset 1, "volume"
chnset "None", "message"
chnset 400, "freq"

instr 1
	kfreq init 400
	kfreq = 400 + chnget:k("volume")*200
	Sstring chnget "message"
	chnset kfreq, "freq"
	printks Sstring, 0.5
	printk2 kfreq
	out poscil(chnget:k("volume") * linenr(0.2,0.1,0.1,0.001),kfreq)
endin


</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>0</width>
 <height>0</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
