Changelog PaperElements
=======================

v0.0.10 (6.8.2015)
----------------------
* __PaperCard:__ Removed the light gray border around the element to make the
  box-shadow crisper and less fuzzy looking; very nice visual improvement to
  appear more like native Android elements.
* Upgraded to CoreIcon package v0.0.7+ which is renamed to CoreIcon instead of
  CoreElements and is better at using ShadowRoots.
* __PaperCard:__ Removed the unnecessary, complicated-to-style-externally-for-
  the-client ShadowRoot layer out of PaperCard elements.
* Added /deep/ to the CSS for so that paper elements will retain styling even
  if they are inside of another ShadowRoot; edit: this has since been deprecated
  and will be changed in a future release.
* Clean-up and improvements from the Dart Analyzer; fixed some typos/extra
  parameters in code that were throwing errors, but not in code that was ready
  for public use yet, but other projects referring to this locally were repeating
  the warnings.

v0.0.9 (3.11.2015)
------------------
* My first GitHub commit of the project (has been used in local projects for a
  while); edit: initial Github commit changed to 9.29.2015.
* Creation of many PaperElements.