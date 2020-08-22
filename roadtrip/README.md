# Roadtrip
## Introduction
We have to make a trip from one city to another one in less than T minutes. We can choose to rent one of the Ν cars available. Each car has an economy and a sport mode while in an economy mode burns C_s L/Km and has a speed of T_s minutes/Km and while in a sport mode burns C_f\ L/Km and has a speed of T_f minutes/Km. A car i costs p_i and gas a tank that can hold up to c_i. The driver can switch from one mode to the other with no cost and as many times as wanted.
## What we want
We need to find the minimum cost of renting a car that can complete the trip in less than T minutes.
## Input
As **input**, our program while have at the first line 4 integers, N K D T, where N is the number of cars that we have to choose from, K is the number of stops that we can refill our tank, D is the distance in Km and T the time limit. Then in each of the next N lines we will have 2 numbers one for the p_i\ and\ c_i. Then in the next line there while be K numbers for the distances of each station from the initial city. Finally, in the last line we will have 4 numbers for the T_s\ \ \ C_s\ \ \ \ T_f{\ \ \ \ }C_f
## Output
As **output**, our program while print a integer number for the minimum cost or -1 if it's not possible to complete the trip.
