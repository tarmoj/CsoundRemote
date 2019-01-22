<CsoundSynthesizer>
<CsOptions>
--port=6006
</CsOptions>
<CsInstruments>

sr = 44100
nchnls = 2
0dbfs = 1

;;channels
chn_k "_Play",3
chn_k "value",3
chn_k "number",3
chn_k "freq",3
chn_k "volume",3
ksmps = 32

instr 1
	kvolume chnget "volume"
	kfreq chnget "freq"
	kharm chnget "number"
	asig buzz 0.2, kfreq, kharm, -1 
	;asig  moogladder2 asig, kfreq * 4, 0.8
	aout = asig * kvolume * madsr(0.05,0.1, 0.5, 0.1)
	outs aout, aout
endin

instr bell
	asig fmbell 0.1, random:i(300,500), random:i(1, 1.5), random:i(1.5, 2.5), 0.2, 4
	aout = asig * chnget:k("volume") * linen(1,0.05, p3, 0.1)
	outs aout, aout
endin

alwayson 10
instr 10
kval chnget "value"
printk2 kval
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
 <width>668</width>
 <height>357</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>0</r>
  <g>255</g>
  <b>0</b>
 </bgcolor>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>freq</objectName>
  <x>113</x>
  <y>257</y>
  <width>30</width>
  <height>100</height>
  <uuid>{4211040d-6f4a-494e-bde2-8283370a23e4}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>200.00000000</minimum>
  <maximum>1000.00000000</maximum>
  <value>1000.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>63</x>
  <y>28</y>
  <width>243</width>
  <height>46</height>
  <uuid>{bcb69fe5-bd2a-42b3-baf2-e09003ce1fcb}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>QML export test</label>
  <alignment>center</alignment>
  <font>Courier New</font>
  <fontsize>20</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>255</b>
  </color>
  <bgcolor mode="background">
   <r>170</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>5</borderradius>
  <borderwidth>2</borderwidth>
 </bsbObject>
 <bsbObject type="BSBButton" version="2">
  <objectName>button3</objectName>
  <x>80</x>
  <y>192</y>
  <width>100</width>
  <height>30</height>
  <uuid>{82e32b30-cbbe-4cad-868c-70e47ced6faf}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Play</text>
  <image>/</image>
  <eventLine>i1 0 -1</eventLine>
  <latch>true</latch>
  <latched>false</latched>
 </bsbObject>
 <bsbObject type="BSBKnob" version="2">
  <objectName>volume</objectName>
  <x>159</x>
  <y>258</y>
  <width>127</width>
  <height>99</height>
  <uuid>{d7d80187-2702-43e0-9a88-dff230fb3725}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>3.00000000</maximum>
  <value>1.05000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBSpinBox" version="2">
  <objectName>number</objectName>
  <x>192</x>
  <y>114</y>
  <width>52</width>
  <height>34</height>
  <uuid>{fc573845-e80d-40d4-9936-defbc4d11b76}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Andale Mono</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <resolution>1.00000000</resolution>
  <minimum>0</minimum>
  <maximum>99</maximum>
  <randomizable group="0">false</randomizable>
  <value>0</value>
 </bsbObject>
 <bsbObject type="BSBButton" version="2">
  <objectName>none</objectName>
  <x>90</x>
  <y>422</y>
  <width>100</width>
  <height>30</height>
  <uuid>{beb8a347-d6f6-471d-ace1-af1abd89a284}</uuid>
  <visible>true</visible>
  <midichan>1</midichan>
  <midicc>42</midicc>
  <type>event</type>
  <pressedValue>1.00000000</pressedValue>
  <stringvalue/>
  <text>Bell</text>
  <image>/</image>
  <eventLine>i 2 0 2</eventLine>
  <latch>false</latch>
  <latched>false</latched>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>72</x>
  <y>119</y>
  <width>80</width>
  <height>25</height>
  <uuid>{f4233cda-45cc-4a9d-9571-afa2ba0b41a4}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Harmonics:</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>12</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>42</x>
  <y>306</y>
  <width>48</width>
  <height>26</height>
  <uuid>{18c492cf-0c03-4fde-b904-ef579074ff35}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Freq</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
