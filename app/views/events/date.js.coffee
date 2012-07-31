

msg  = "<div class='span6'><div class='row target-append'>"
msg += "<h1>Event <%= @date.to_s(:date_month_and_year)%></h1>"
msg += "<br/><br/>"

<% @events.each do |event| %>
msg += "<div class='row add-bottom'><div class='span6'>"
msg += "<div class='row'><h2><a href='<%=event_path(event)%>'><%= event.nama %></a></h2>"
msg += "</div>"
msg += "</div></div><hr/>"
<% end %>

msg += "</div></div>"

$('.target-append').remove()
$('.event-calendar-date').append(msg)