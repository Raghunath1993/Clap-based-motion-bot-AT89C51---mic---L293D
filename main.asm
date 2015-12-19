/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * Raghunath Reddy
 * 2012,Manipal Institiute of Technology
 * ---------------------------------------
 * This file is application based, which sends signals to L293D to move in different directions based on the input from the mic circuit provided by rookie electronics
 * ------------------------------------------------------------------------------------------------------------------------------------------------------------------ */


ORG 0000H
mov tmod,#16h;timer1 in mode,timer2 as count in mode 2;
mov sp,#60h
clr p2.0;checking
setb p3.4;counter0 input
mov p0,#00h;output port
start:mov th0,#00H;intial vale to counter
setb p2.0;
setb tr0;start the timer
acall delay1;delay of 2seconds so that we can know the number of claps
clr p2.0;
acall delay1; delay of 2seconds so that we can know the number of claps
mov r3,tl0;counter value  is stored in r3 register
mov a,r3;to use jz instruction should store in acc
jz start;if there is no input that is no claps it should wait for number of claps
subb a,#01h;if there  is an input and we dont know how many claps we have to check if 1,2....here we  are checking for one clap
jz first ;if there is one clap how the bot is moved in the first function
mov a,r3; if the no. of claps are 2  or more  we come to this step ans then copy r3 to acc
subb a,#02h;check if the number of claps is 2
jz second;if 2 go to the second function  which is right turn
subb a,#03h;chek if the number of claps is 3
jz third;if 3 left turn
sjmp start;
first:setb p0.0;connected to the motor1 through l293d input1
clr p0.1;connected to the motor1 through l293d input2...........input1-1;input2-0;motor1 moves forward
setb p0.2;connected to the motor2 through l293d input3
clr p0.3;connected to the motor2 through l293d input4...........input1-1;input2-0;motor2 moves forward
acall delay2;this is the time for the bot to move in forward direction this 2 sec
mov p0,#00h;make the bot in ideal state
mov tl0,#00h;not workin according to the theory
sjmp start;this mode is completedgo again checking if any claps are detected
second:clr p0.0; motor1 off
clr p0.1;motor 1 off
setb p0.2; motor2 moving forward
clr p0.3;motor2 moving forward
acall delay2;mostly keep around 0.5 seconds (trial  and error method)
mov p0,#00h;make the bot in ideal state
mov tl0,#00h;not workin according to the theory
sjmp start
third:setb p0.0; motor1 off
clr p0.1;motor 1 off
clr p0.2; motor2 moving forward
clr p0.3;motor2 moving forward
acall delay2;mostly keep around 0.5 seconds (trial  and error method)
mov p0,#00h;make the bot in ideal state
mov tl0,#00h;not workin according to the theory
sjmp start
delay1:mov r2,#28h
wait1:mov th1,#4ch
mov tl1,#01h
setb tr1
wait:jnb tf1,wait
clr tf1
djnz  r2,wait1
ret
delay2:mov r2,#14h
wait3:mov th1,#4ch
mov tl1,#01h
setb tr1
wait2:jnb tf1,wait2
clr tf1
djnz  r2,wait3
ret
end
