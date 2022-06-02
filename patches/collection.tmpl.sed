# Insert additional JavaScript into the collection view template.
# This JavaScript is specific to the collection view.
# This sed command looks for the line that defines JS in the template, then
# inserts our script tag right after that.
/{{ define "js" }}/ a <script src="/static/extra-collection.js"></script>

# Remove Kanban link from the collection view.  We don't use it.
/>Kanban</d

# Add closure stats to the collection view.  This would normally only be shown
# in Kanban view, which we don't use.
s/^ *Avg wait:.*$/&, Closure rate: {{ printf "%.1f" $.ClosedPerDay }} issues per day/
