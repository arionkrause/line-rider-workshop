# Line Rider Workshop

An AutoHotkey application to create spirals, circles, and curves; designed mainly for making tracks for Line Rider (hence the name) but can be used on drawing applications — or anywhere else, actually.


## GUI

![](https://github.com/arionkrause/line-rider-workshop/blob/master/doc/gui.png)


## Usage


### Making a spiral

![](https://github.com/arionkrause/line-rider-workshop/blob/master/doc/spiral.gif)


1. Run **Line Rider Workshop.exe**

2. In the _Spiral tool_ section, set the spiral parameters (amount of moves, radius, incrementation per move, starting angle, angle incrementation per move).

3. Set the hotkey (default is F11).

4. Press Ok.

5. In the desired application, press and keep pressed the main mouse button (usually the left button).

6. With the mouse button still pressed, press the hotkey once.


### Making a curve

![](https://github.com/arionkrause/line-rider-workshop/blob/master/doc/curve.gif)


1. Run **Line Rider Workshop.exe**

2. In the _Curve tool_ section, set the desired amount of lines. More lines means a smoother curve.

3. Set the hotkey (default is F12).

4. Press Ok.

5. In the desired application, press the hotkey once.

6. Draw two lines.

7. The program will create a curve between the lines.


## Tips

To stop creating a spiral or curve, press _Esc_ at any time.

It's possible to create as many hotkeys as needed, each one with a distinct set of parameters.

To calculate how many loops the spiral will have, multiply _moves_ by _Angle incrementation per move_ (e.g. 180 moves with increments of 2 degrees each will draw a spiral with one loop).

If you want to modify it, edit **Line Rider Workshop.ahk** and run **Compile.ahk** to create an executable ([AutoHotkey](https://www.autohotkey.com/) must be installed to compile).

This application was made by me in **2008** and has not been modified since.