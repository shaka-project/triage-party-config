# Find the navbar-brand div in the base template, and select everything between
# that and the closing </div>.
/navbar-brand/,/\/div/ {
  # Delete it all.
  //!d
  # Insert the contents of our patch, replacing the navbar-brand div.
  r navbar-brand.html
  # The pattern space still contains the closing </div>.  Delete it now.
  # This must come last because the "d" command ends the cycle.  If we did it
  # before "r", the new data would not be inserted.
  d
}

# The templates contain multiple elements with the ID "navbarBasicExample".
# This replaces the one in base.tmpl with "mainNavbar".  This becomes important
# when we need to reference one specific one for the mobile-friendly navbar.
s/navbarBasicExample/mainNavbar/
