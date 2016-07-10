(*
  Category: SWAG Title: BITWISE TRANSLATIONS ROUTINES
  Original name: 0016.PAS
  Description: RANDOM2.PAS
  Author: SWAG SUPPORT TEAM
  Date: 05-28-93  13:53
*)

{ MR> I have started playing With Borland Turbo Pascal 7.0 and I have a
 MR> problem. The Random routine is not the same as the one in TP 6.0.
 MR> Using the same RandSeed, they generate different series of numbers.
 MR> I have a couple of applications that depend upon the number series
 MR> generated by the TP 6.0 version. Can anyone supply me With the
 MR> algorithm used in the TP 6.0 Random routine? or maybe point me in
 MR> the right direction? I want to Construct my own TP 7 Random routine
 MR> that will behave as the one in TP 6.

The way both generators work is to update System.Randseed, then calculate the
new random value from that one.  There have been several different ways to
calculate the value; I think TP 6 is different from TP 5.5, and TP 7 is
different again.  The update algorithm has been pretty Constant.

As I recall, you can simulate the TP 6 Random(N) Function in TP 7 as follows:
}
Function TP6Random(N:Word):Word;
Var
  junk : Word;
  myrandseed : Record
  lo, hi : Word
  end Absolute system.randseed;
begin
  junk := Random(0);   { Update Randseed }
  TP6Random := myrandseed.hi mod N;
end;

{
You might want to keep the following around in Case the update algorithm gets
changed sometime in the future:

Demonstration Program to show how the TP 6.0 random number generator
updates System.Randseed.  Allows the seed to be cycled backwards. }

Procedure CycleRandseed(cycles:Integer);
{ For cycles > 0, mimics cycles calls to the TP random number generator.
  For cycles < 0, backs it up the given number of calls. }
Var
  i : Integer;
begin
  if cycles > 0 then
    For i := 1 to cycles do
      system.randseed := system.randseed*134775813 + 1
  else
    For i := -1 downto cycles do
      system.randseed := (system.randseed-1)*(-649090867);
end;

Var
  i : Integer;
begin
  randomize;
  Writeln('Forwards:');
  For i:=1 to 5 do
    Writeln(random);
  Writeln('Backwards:');
  For i:=1 to 5 do
  begin
    CycleRandseed(-1);    { Back to previous value }
    Writeln(random);      { Show it }
    CycleRandseed(-1);    { Back up over it again }
  end;
end.
