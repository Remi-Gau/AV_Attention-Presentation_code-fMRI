#-- scenario file --#

scenario = "Audio-Visual integration at 7 tesla";

# --------------------------------------------------- #
# 								HEADER 								#
# --------------------------------------------------- #
pcl_file = "7T_AV_Integration.pcl";

#scenario_type = fMRI;
scenario_type = fMRI_emulation;
scan_period = 3000;

pulse_code = 30;
pulses_per_scan = 1;


default_text_color = 255,255,255; #white text by default
default_background_color = 25,25,25; #black backgrounds

default_text_align = align_center;
default_font = "Arial"; #Arial font by default
default_font_size = 24; 

response_matching = simple_matching;
response_logging = log_all;

active_buttons = 1;
button_codes = 1;
target_button_codes = 1;

default_stimulus_time_in = 0;
default_stimulus_time_out = never;
default_clear_active_stimuli = false;


# --------------------------------------------------- #
#					           SDL									#
# --------------------------------------------------- #
begin;

# SDL variables

# VISUAL HARWARE
$RefreshRate = 60.0;

#Compute the number of pixel per degree
$MonitorWidth = 21.5;
$ViewDist = 30.0;
$MaxFOV = 40.0;  #2.0 * 180.0 * arctan(MonitorWidth/2.0/ViewDist)/ Pi;
$Win_W = 1024.0 ;
$Win_H = 728.0 ; 
$PPD = '$Win_W/$MaxFOV';

# for ViewDist = 30
# MonWidth	MaxFOV
# 48.0			77.0
# 21.5			40.0

$White = "230, 230, 230";
$Blue = "0, 0, 255";

$xpos = 0;
$ypos = 0;


# Fixation Cross
$FixationCrossLineWidth = 2;
$FixationCrossHalfWidth = 8;
$NegativeFixationCrossHalfWidth = '-($FixationCrossHalfWidth)';

# Stimuli
$StimDuration = 500;

$SOAFix = 100;

$AnnuliWidth = 50.0;

# Targets
$Target_Size = 0.5;
$Target_Size_Pixel = '$Target_Size * $PPD';

# Fixation
$LongFixationDuration = 16000.0;
$FinalFixationDuration = 40000.0;



#------------------#
# STIMULI ELEMENTS #
#------------------#

# VISUAL

# Text
text {
	caption = "V";
} Text_Attend2Visual;

text {
	caption = "A";
} Text_Attend2Auditory;


# Individual circles
annulus_graphic{
	inner_width = 0;
	inner_height = 0;
	outer_width = 0;
	outer_height = 0;
	color = $White;
}circle1;

annulus_graphic{
	inner_width = 0;
	inner_height = 0;
	outer_width = 0;
	outer_height = 0;
	color = $White;
}circle2;

annulus_graphic{
	inner_width = 0;
	inner_height = 0;
	outer_width = 0;
	outer_height = 0;
	color = $White;
}circle3;

annulus_graphic{
	inner_width = 0;
	inner_height = 0;
	outer_width = 0;
	outer_height = 0;
	color = $White;
}circle4;


# Fixation Cross
line_graphic {
	coordinates = $NegativeFixationCrossHalfWidth, 0, $FixationCrossHalfWidth, 0;
	coordinates = 0, $NegativeFixationCrossHalfWidth, 0, $FixationCrossHalfWidth;
	line_width = $FixationCrossLineWidth;
	line_color = $White;
}FixationCross;

# Blue Fixation Cross
line_graphic {
	coordinates = $NegativeFixationCrossHalfWidth, 0, $FixationCrossHalfWidth, 0;
	coordinates = 0, $NegativeFixationCrossHalfWidth, 0, $FixationCrossHalfWidth;
	line_width = $FixationCrossLineWidth;
	line_color = $Blue;
}BlueFixationCross;


# Target Ellipse
ellipse_graphic {
	ellipse_width = $Target_Size_Pixel;
	ellipse_height = $Target_Size_Pixel;
}Ellipse;


# AUDIO

# Sounds
array{
sound {wavefile { filename = "Looming_Sound.wav                            "; } ; } Looming_Sound                             ;
} SOUNDS;

array{
sound {wavefile { filename = "Target_alone_01_Attenuation_01.wav            "; } ; } Target_alone_01_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_02.wav            "; } ; } Target_alone_01_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_03.wav            "; } ; } Target_alone_01_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_04.wav            "; } ; } Target_alone_01_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_05.wav            "; } ; } Target_alone_01_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_06.wav            "; } ; } Target_alone_01_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_07.wav            "; } ; } Target_alone_01_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_08.wav            "; } ; } Target_alone_01_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_09.wav            "; } ; } Target_alone_01_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_01_Attenuation_10.wav            "; } ; } Target_alone_01_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_02_Attenuation_01.wav            "; } ; } Target_alone_02_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_02.wav            "; } ; } Target_alone_02_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_03.wav            "; } ; } Target_alone_02_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_04.wav            "; } ; } Target_alone_02_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_05.wav            "; } ; } Target_alone_02_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_06.wav            "; } ; } Target_alone_02_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_07.wav            "; } ; } Target_alone_02_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_08.wav            "; } ; } Target_alone_02_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_09.wav            "; } ; } Target_alone_02_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_02_Attenuation_10.wav            "; } ; } Target_alone_02_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_03_Attenuation_01.wav            "; } ; } Target_alone_03_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_02.wav            "; } ; } Target_alone_03_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_03.wav            "; } ; } Target_alone_03_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_04.wav            "; } ; } Target_alone_03_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_05.wav            "; } ; } Target_alone_03_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_06.wav            "; } ; } Target_alone_03_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_07.wav            "; } ; } Target_alone_03_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_08.wav            "; } ; } Target_alone_03_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_09.wav            "; } ; } Target_alone_03_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_03_Attenuation_10.wav            "; } ; } Target_alone_03_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_04_Attenuation_01.wav            "; } ; } Target_alone_04_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_02.wav            "; } ; } Target_alone_04_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_03.wav            "; } ; } Target_alone_04_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_04.wav            "; } ; } Target_alone_04_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_05.wav            "; } ; } Target_alone_04_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_06.wav            "; } ; } Target_alone_04_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_07.wav            "; } ; } Target_alone_04_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_08.wav            "; } ; } Target_alone_04_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_09.wav            "; } ; } Target_alone_04_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_04_Attenuation_10.wav            "; } ; } Target_alone_04_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_05_Attenuation_01.wav            "; } ; } Target_alone_05_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_02.wav            "; } ; } Target_alone_05_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_03.wav            "; } ; } Target_alone_05_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_04.wav            "; } ; } Target_alone_05_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_05.wav            "; } ; } Target_alone_05_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_06.wav            "; } ; } Target_alone_05_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_07.wav            "; } ; } Target_alone_05_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_08.wav            "; } ; } Target_alone_05_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_09.wav            "; } ; } Target_alone_05_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_05_Attenuation_10.wav            "; } ; } Target_alone_05_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_06_Attenuation_01.wav            "; } ; } Target_alone_06_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_02.wav            "; } ; } Target_alone_06_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_03.wav            "; } ; } Target_alone_06_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_04.wav            "; } ; } Target_alone_06_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_05.wav            "; } ; } Target_alone_06_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_06.wav            "; } ; } Target_alone_06_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_07.wav            "; } ; } Target_alone_06_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_08.wav            "; } ; } Target_alone_06_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_09.wav            "; } ; } Target_alone_06_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_06_Attenuation_10.wav            "; } ; } Target_alone_06_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_07_Attenuation_01.wav            "; } ; } Target_alone_07_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_02.wav            "; } ; } Target_alone_07_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_03.wav            "; } ; } Target_alone_07_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_04.wav            "; } ; } Target_alone_07_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_05.wav            "; } ; } Target_alone_07_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_06.wav            "; } ; } Target_alone_07_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_07.wav            "; } ; } Target_alone_07_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_08.wav            "; } ; } Target_alone_07_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_09.wav            "; } ; } Target_alone_07_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_07_Attenuation_10.wav            "; } ; } Target_alone_07_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_08_Attenuation_01.wav            "; } ; } Target_alone_08_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_02.wav            "; } ; } Target_alone_08_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_03.wav            "; } ; } Target_alone_08_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_04.wav            "; } ; } Target_alone_08_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_05.wav            "; } ; } Target_alone_08_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_06.wav            "; } ; } Target_alone_08_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_07.wav            "; } ; } Target_alone_08_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_08.wav            "; } ; } Target_alone_08_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_09.wav            "; } ; } Target_alone_08_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_08_Attenuation_10.wav            "; } ; } Target_alone_08_Attenuation_10             ;

sound {wavefile { filename = "Target_alone_09_Attenuation_01.wav            "; } ; } Target_alone_09_Attenuation_01             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_02.wav            "; } ; } Target_alone_09_Attenuation_02             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_03.wav            "; } ; } Target_alone_09_Attenuation_03             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_04.wav            "; } ; } Target_alone_09_Attenuation_04             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_05.wav            "; } ; } Target_alone_09_Attenuation_05             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_06.wav            "; } ; } Target_alone_09_Attenuation_06             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_07.wav            "; } ; } Target_alone_09_Attenuation_07             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_08.wav            "; } ; } Target_alone_09_Attenuation_08             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_09.wav            "; } ; } Target_alone_09_Attenuation_09             ;
sound {wavefile { filename = "Target_alone_09_Attenuation_10.wav            "; } ; } Target_alone_09_Attenuation_10             ;
} TARGET_SOUNDS;


array{
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_01_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_01_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_02_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_02_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_03_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_03_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_04_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_04_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_05_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_05_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_06_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_06_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_07_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_07_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_08_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_08_Attenuation_10 ;

sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_01.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_01 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_02.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_02 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_03.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_03 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_04.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_04 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_05.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_05 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_06.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_06 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_07.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_07 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_08.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_08 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_09.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_09 ;
sound {wavefile { filename = "Looming_Sound_And_Target_09_Attenuation_10.wav"; } ; } Looming_Sound_And_Target_09_Attenuation_10 ;
} SOUNDS_AND_TARGETS;


#---------#
# STIMULI #
#---------#
# Visual Circles
picture {
   annulus_graphic circle1;
   x = $xpos; y = $ypos;

   annulus_graphic circle2;
   x = $xpos; y = $ypos;

   annulus_graphic circle3;
   x = $xpos; y = $ypos;

   annulus_graphic circle4;
   x = $xpos; y = $ypos;

	line_graphic FixationCross;
	x = $xpos; y = $ypos;	
} Circles;

# Visual Circles + Visual target
picture {	
   annulus_graphic circle1;
   x = $xpos; y = $ypos;

   annulus_graphic circle2;
   x = $xpos; y = $ypos;

   annulus_graphic circle3;
   x = $xpos; y = $ypos;

   annulus_graphic circle4;
   x = $xpos; y = $ypos;

	line_graphic FixationCross;
	x = $xpos; y = $ypos;
	
	ellipse_graphic Ellipse;
	x = $xpos; y = $ypos;
	on_top = true;
}TargetEllipse;

# Picture Fixation Cross
picture {
	line_graphic FixationCross;
	x = $xpos; y = $ypos;	
} PictureFixationCross;

#--------#
# TRIALS #
#--------#
trial {	
	nothing {};
	mri_pulse = 1;
	code = "START";
} Start_Trial;

trial {
   save_logfile {
      filename = "temp.log"; # use temp.log in default logfile directory
   };
} Temp_Save;


# EVENTS & TRIALS
# AudioVisual_Trial;
trial {
	monitor_sounds = false;
	all_responses = true;
	
	picture Circles;
	
	code = "AudioVisual_Trial";
} AudioVisual_Trial;


# VisualOnly_Trial;
trial {
	all_responses = true;
	
	picture Circles;

	code = "VisualOnly_Trial";
} VisualOnly_Trial;


# AudioOnly_Trial;
trial {
	monitor_sounds = false;
	all_responses = true;
	
	picture {
	line_graphic FixationCross;
	x = $xpos; y = $ypos;
	};
	
	code = "AudioOnly_Trial";
} AudioOnly_Trial;


# TARGETS
# Visual Target
trial {
	monitor_sounds = false;
   all_responses = true;

	nothing {};
	
	target_button = 1;
	code = "Visual_Target";
} Visual_Target;

# Auditory Target
trial {
	all_responses = true;
	monitor_sounds = false;
	
	nothing {};
	
	target_button = 1;	
	code = "Auditory_Target";
} Auditory_Target;

# FIXATIONS
# Stimulus_Offset
trial {
	monitor_sounds = true; # KEEP TRUE
	all_responses = true;
	
	picture {
	line_graphic FixationCross;
	x = $xpos; y = $ypos;
	};
	
	code = "Stimulus_Offset";
} Stimulus_Offset;

# SOA fixed component
trial {
	all_responses = true;
   trial_duration = $SOAFix;
	
	picture {
	line_graphic FixationCross;
	x = $xpos; y = $ypos;
	};
	
	code = "SOA_Fix";
} SOA_Fix;


# LONG FIXATIONS
# Attend to auditory fixation 
trial {
	all_responses = true;
   trial_duration = 'int($LongFixationDuration)';
	
	picture {
	line_graphic BlueFixationCross;
	x = $xpos; y = $ypos;
	};
	time = 0;
	duration = 'int($LongFixationDuration)-3000';
	
	picture {
	text Text_Attend2Auditory;
	x = $xpos; y = $ypos;
	};
	time = 'int($LongFixationDuration)-3000';
	duration = 3000;	
	
	code = "Attend2Audio_Fixation";
} Attend2Audio_Fixation;


# Attend to visual fixation 
trial {
	all_responses = true;
   trial_duration = 'int($LongFixationDuration)';
	
	picture {
	line_graphic BlueFixationCross;
	x = $xpos; y = $ypos;
	};
	time = 0;
	duration = 'int($LongFixationDuration)-3000';
	
	picture {
	text Text_Attend2Visual;
	x = $xpos; y = $ypos;
	};
	time = 'int($LongFixationDuration)-3000';
	duration = 3000;	
	
	code = "Attend2Visual_Fixation";
} Attend2Visual_Fixation;


# Long Fixation (interblock)
trial {
	all_responses = true;
   trial_duration = 'int($LongFixationDuration)';
	
	picture {
	line_graphic BlueFixationCross;
	x = $xpos; y = $ypos;
	};
	
	code = "Long_Fixation";
} Long_Fixation;


# Final Fixation
trial {
	all_responses = true;
   trial_duration = 'int($FinalFixationDuration)';
	
	picture {
	line_graphic BlueFixationCross;
	x = $xpos; y = $ypos;
	};
	
	code = "Final_Fixation";
} Final_Fixation;