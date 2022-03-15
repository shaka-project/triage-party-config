# Insert additional JavaScript into the collection view template.
# This JavaScript is specific to the collection view.
# This sed command looks for the line that defines JS in the template, then
# inserts our script tag right after that.
/{{ define "js" }}/ a <script src="/static/extra-collection.js"></script>
