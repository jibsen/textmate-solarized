# `src/`


## How this directory is organized 

Files in this directory each contain a piece of the Solarized code.  
Each filename followed the form `«language».«theme»`. So, `html.dark` 
contains all the code to style HTML files for the *Solarized (dark)* theme.

The only files that do *not* follow this convention are the `_HEAD.{dark,light}` files. 
These contain the beginning and end of each `*.tmTheme` file, and are the only pieces
that contain code that is not language-specific.


### Files here are **not** valid (or well-formed) XML

To build the two `*.tmTheme` files, these files are simply concatenated together.
Therefore, they’re *not* valid (or well-formed), but the build results are.

(There are other XML tools, like XInclude, that could combine these files together, as well.  
However, they often require Java, and they're more complicated than necessary here.
The current build method is a nice simple shell script.)


## Use `__«COLOR»__`s

In this directory, nearly all color values are specified using the form `__«COLOR»__`,
where `__«COLOR»__` is one of the color names as seen on 
[the official Solarized color table](http://ethanschoonover.com/solarized#the-values).

During the build process, these placeholders are replaced with their hex color values.

There are a few places where a literal color value is used.  
Occasionally this is desireable--but it should always be the exception, not the rule.  
Use your best judgment.