<CsoundSynthesizer>
<CsOptions>
-odac -d
--port=6006
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

chnset 1, "carr"
chnset 2, "mod"

schedule 1, 0, 1
instr 1
	kcarr chnget "carr"
	kmod chnget "mod"
	asig foscil adsr(0.05,0.1,0.4,p3/2)*0.2, 500, kcarr, kmod, 4, -1
	outs asig, asig
endin

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
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
