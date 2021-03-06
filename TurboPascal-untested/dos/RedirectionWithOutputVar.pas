(*
  Category: SWAG Title: DOS & ENVIRONMENT ROUTINES
  Original name: 0077.PAS
  Description: Redirection with Output Var
  Author: ARNE DE.BRUIJN
  Date: 11-26-94  05:08
*)

{
 Small program to demostrate redirection of TP's Output variable
 Arne de Bruijn, 1994, PD
}

Unit SmallCrt;
interface
procedure AssignCrt(var F:text);
implementation
uses Dos; {For TextRec, fmClosed, fmOutput}

function InOutCrtOut(var F:text):byte; far; assembler;
asm
 cld                          { Count forwards }
 mov dx,ds                    { Save DS }
 lds si,F                     { Get address of F }
 mov cx,[si].TextRec.BufPos   { Get number of bytes to write }
 lds si,[si].TextRec.BufPtr   { Get address of buffer }
@OutChars:
 lodsb                        { Load character to output in AL, and }
                              { set SI to next character }
 int 29h                      { Output AL with DOS undocumented fast write }
 loop @OutChars               { Do all characters (dec(cx); until cx=0) }
 mov ds,dx                    { Restore DS }
end;

function CloseCrtOut(var F:text):byte; far;
begin
 TextRec(F).Mode:=fmClosed;
 CloseCrtOut:=0;
end;

function OpenCrtOut(var F:text):byte; far;
begin
 with TextRec(F) do
  begin
   Mode:=fmOutput;
   BufPos:=0; BufEnd:=0;
   InOutFunc:=@InOutCrtOut;
   FlushFunc:=@InOutCrtOut;
   CloseFunc:=@CloseCrtOut;
  end;
 OpenCrtOut:=0;
end;

procedure AssignCrt(var F:text);
begin
 with TextRec(F) do
  begin
   Mode:=fmClosed;
   BufSize:=SizeOf(Buffer);
   BufPtr:=@Buffer;
   Name[0]:=#0;
   OpenFunc:=@OpenCrtOut;
  end;
end;

begin
 AssignCrt(Output);
 Rewrite(Output);
end.

