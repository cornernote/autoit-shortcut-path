#cs ----------------------------------------------------------------------------

Shortcut Path

Copies the path of a file or folder into your clipboard.

usage: 
shortcut_path.exe [file or folder]

returns: 
path to the file or folder


Copyright (c) 2013 - Brett O'Donnell <cornernote@gmail.com>

Download: https://github.com/cornernote/mtgo-shortcut_path/archive/master.zip
Source Code: https://github.com/cornernote/mtgo-shortcut_path

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

#ce ----------------------------------------------------------------------------

; includes
#include <Array.au3>

; check if an argument was provided
If Not $CmdLine[0] Then
   MsgBox(64, "Error", "Usage: shortcut_path.exe [file or folder]")
   Exit
EndIf

; find file in path
$aPaths = StringSplit(EnvGet("PATH"), ";")
For $i = 1 to $aPaths[0]
   $sFile = $aPaths[$i] & '\' & $CmdLine[1]
   
   ; check if file exists
   If FileExists($sFile) Then
	  ; found, put in clipboard
	  ClipPut($sFile)
	  Exit
   EndIf

   ; check if file is a link
   If FileExists($sFile & ".lnk") Then
	  ; found, get link info then put in clipboard
	  $aDetails = FileGetShortcut($sFile & ".lnk")
	  ClipPut($aDetails[0])
	  Exit
   EndIf

Next

; not found
$sPaths = _ArrayToString($aPaths, @CRLF, 1, $aPaths[0])
MsgBox(64, "Could not find '" & $CmdLine[1] & "'", "Looked in:" & @CRLF & $sPaths)