<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>FullCalendar by Creative Tim</title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="/resources/css/fullcalendar.css" rel="stylesheet" />
    <link href="/resources/css/fullcalendar.print.css" rel="stylesheet" media="print" />
    <script src="/resources/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="/resources/js/jquery-ui.custom.min.js" type="text/javascript"></script>
    <script src="/resources/js/fullcalendar.js" type="text/javascript"></script>
    <script>
      $(function () {
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        $('#external-events div.external-event').each(function () {
          // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
          // it doesn't need to have a start or end
          var eventObject = {
            title: $.trim($(this).text()), // use the element's text as the event title
          };
          // store the Event Object in the DOM element so we can get to it later
          $(this).data('eventObject', eventObject);
          // make the event draggable using jQuery UI
          $(this).draggable({
            zIndex: 999,
            revert: true, // will cause the event to go back to its
            revertDuration: 0, //  original position after the drag
          });
        });
        /* initialize the calendar
		-----------------------------------------------------------------*/
        var calendar = $('#calendar').fullCalendar({
          header: {
            left: 'title',
            center: 'month',
            right: 'prev,next today',
          },
          editable: true,
          firstDay: 1, //  1(Monday) this can be changed to 0(Sunday) for the USA system
          selectable: true,
          defaultView: 'month',
          axisFormat: 'h:mm',
          columnFormat: {
            month: 'ddd', // Mon
            week: 'ddd d', // Mon 7
            day: 'dddd M/d', // Monday 9/7
            agendaDay: 'dddd d',
          },
          titleFormat: {
            month: 'MMMM yyyy', // September 2009
            week: 'MMMM yyyy', // September 2009
            day: 'MMMM yyyy', // Tuesday, Sep 8, 2009
          },
          allDaySlot: false,
          selectHelper: true,
          select: function (start, end, allDay) {
            $('.modal').fadeIn();
            $('#close').click(function () {
               $('.modal').fadeOut();
            });
             var title = prompt('Event Title:');
             console.log(title);
            if (title) {
              calendar.fullCalendar(
                'renderEvent',
                {
                  title: title,
                  start: start,
                  end: end,
                  allDay: allDay,
                },
                true // make the event "stick"
              );
            }
            calendar.fullCalendar('unselect');
          },
          droppable: true, // this allows things to be dropped onto the calendar !!!
          drop: function (date, allDay) {
            // this function is called when something is dropped
            // retrieve the dropped element's stored Event Object
            var originalEventObject = $(this).data('eventObject');
            // we need to copy it, so that multiple events don't have a reference to the same object
            var copiedEventObject = $.extend({}, originalEventObject);
            // assign it the date that was reported
            copiedEventObject.start = date;
            copiedEventObject.allDay = allDay;
            // render the event on the calendar
            // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
            $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
            // is the "remove after drop" checkbox checked?
            if ($('#drop-remove').is(':checked')) {
              // if so, remove the element from the "Draggable Events" list
              $(this).remove();
            }
          },
          events: [
            {
              title: 'All Day Event',
              start: new Date(y, m, 1),
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d - 3, 16, 0),
              allDay: false,
              className: 'info',
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d + 4, 16, 0),
              allDay: false,
              className: 'info',
            },
            {
              title: 'Meeting',
              start: new Date(y, m, d, 10, 30),
              allDay: false,
              className: 'important',
            },
            {
              title: 'Lunch',
              start: new Date(y, m, d, 12, 0),
              end: new Date(y, m, d, 14, 0),
              allDay: false,
              className: 'important',
            },
            {
              title: 'Birthday Party',
              start: new Date(y, m, d + 1, 19, 0),
              end: new Date(y, m, d + 1, 22, 30),
              allDay: false,
            },
            {
              title: 'Click for Google',
              start: new Date(y, m, 28),
              end: new Date(y, m, 29),
              url: 'http://google.com/',
              className: 'success',
            },
          ],
        });
      });
    </script>
    <style>
      @font-face {
        font-family: 'GongGothicMedium';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
      }
      body {
        font-size: 14px;
        font-family: 'GongGothicMedium', Arial, Verdana, sans-serif;
      }
      #external-events {
        float: left;
        width: 150px;
        padding: 0 10px;
        text-align: left;
      }
      #external-events h4 {
        font-size: 16px;
        margin-top: 0;
        padding-top: 1em;
      }
      .external-event {
        /* try to mimick the look of a real event */
        margin: 10px 0;
        padding: 2px 4px;
        background: #3366cc;
        color: #fff;
        font-size: 0.85em;
        cursor: auto;
      }
      #external-events p {
        margin: 1.5em 0;
        font-size: 11px;
        color: #666;
      }
      #external-events p input {
        margin: 0;
        vertical-align: middle;
      }
      #calendar {
        /* 		float: right; */
        margin-top: 2%;
        width: 90vmax;
        background-color: #ffffff;
        border-radius: 6px;
        box-shadow: 0 1px 2px #c3c3c3;
        /* border: 1px solid black; */
      }
      .modal{
        z-index: 1050;
      }
      #span{
        display: inline-block;
        margin-right: 5%;
      }
      #large{
        width: 30vmax;
        height: 5vmax;
      }
      .btn{
        background-color: #db4437;
        color: white;
        width: 15vmax;
        padding: 2%;
        margin: 5% 4% auto;
        border-radius: 10px;
      }
      select, select option, input{
        font-family: GongGothicMedium;
      }
    </style>
  </head>
  <body>
    <div id="wrap">
      <div id="calendar"></div>

      <div style="clear: both"></div>
    </div>
    <div class="modal">
      <div class="modal_content" title="클릭하면 창이 닫힙니다.">
        <form action="#" id='Frm'>
          <h1>소비 등록</h1>
          <h3 id='span'>대분류</h3>
          <select name="large" id="large">
            <option value="cafe">카페</option>
            <option value="etc">등등</option>
          </select>
          <br>
          <h3 id='span'>소분류</h3>
          <select name="large" id="large">
            <option value="startbucks">스타벅스</option>
            <option value="tomntoms">탐앤탐스</option>
          </select>
          <br>
          <h3 id='span'>금액</h3>
          <input type="number" name="price" value="0" />
          <br>
          <input class="btn" type="submit" value="modalSend" />
          <input class="btn" id="close" type="button" value="close" />
        </form>
      </div>
    </div>
  </body>
</html>