<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="/resources/css/fullcalendar.css" rel="stylesheet" />
<link href="/resources/css/fullcalendar.print.css" rel="stylesheet"
	media="print" />
<script src="/resources/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="/resources/js/jquery-ui.custom.min.js"
	type="text/javascript"></script>
<script src="/resources/js/fullcalendar.js" type="text/javascript"></script>
<title>Insert title here</title>
<link href="/resources/css/signupConsume.css" rel="stylesheet" />
<script>
	$(function() {
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		$('#large').change(function() {
			$.ajax({
				type : 'post',
				url : '/category/getSmallCategory',
				data : {
					id : $(this).val()
				},

				success : function(result) {
					alert(JSON.stringify(result));
					$('#small').empty();
					for (key in result) {
					    $('#small').append('<option value="' + key + '">' + result[key] + '</option>');
					}
				}
			})
		});
		$('#external-events div.external-event').each(function() {
			// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
			// it doesn't need to have a start or end
			var eventObject = {
				title : $.trim($(this).text()), // use the element's text as the event title
			};
			// store the Event Object in the DOM element so we can get to it later
			$(this).data('eventObject', eventObject);
			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex : 999,
				revert : true, // will cause the event to go back to its
				revertDuration : 0, //  original position after the drag
			});
		});
		/* initialize the calendar
		-----------------------------------------------------------------*/
		var calendar = $('#calendar').fullCalendar(
				{
					header : {
						left : 'title',
						center : 'month',
						right : 'prev,next today',
					},
					editable : true,
					firstDay : 1, //  1(Monday) this can be changed to 0(Sunday) for the USA system
					selectable : true,
					defaultView : 'month',
					axisFormat : 'h:mm',
					columnFormat : {
						month : 'ddd', // Mon
						week : 'ddd d', // Mon 7
						day : 'dddd M/d', // Monday 9/7
						agendaDay : 'dddd d',
					},
					titleFormat : {
						month : 'MMMM yyyy', // September 2009
						week : 'MMMM yyyy', // September 2009
						day : 'MMMM yyyy', // Tuesday, Sep 8, 2009
					},
					allDaySlot : false,
					selectHelper : true,
					select : function(start, end, allDay) {
						$('.modal').fadeIn();
						$('#close').click(function() {
							$('.modal').fadeOut();
						});
						var title = prompt('Event Title:');
						console.log(title);
						if (title) {
							calendar.fullCalendar('renderEvent', {
								title : title,
								start : start,
								end : end,
								allDay : allDay,
							}, true // make the event "stick"
							);
						}
						calendar.fullCalendar('unselect');
					},
					droppable : true, // this allows things to be dropped onto the calendar !!!
					drop : function(date, allDay) {
						// this function is called when something is dropped
						// retrieve the dropped element's stored Event Object
						var originalEventObject = $(this).data('eventObject');
						// we need to copy it, so that multiple events don't have a reference to the same object
						var copiedEventObject = $.extend({},
								originalEventObject);
						// assign it the date that was reported
						copiedEventObject.start = date;
						copiedEventObject.allDay = allDay;
						// render the event on the calendar
						// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
						$('#calendar').fullCalendar('renderEvent',
								copiedEventObject, true);
						// is the "remove after drop" checkbox checked?
						if ($('#drop-remove').is(':checked')) {
							// if so, remove the element from the "Draggable Events" list
							$(this).remove();
						}
					},
					events : [ {
						title : 'All Day Event',
						start : new Date(y, m, 1),
					}, ],
				});
	});
</script>
</head>
<body>
	<jsp:include page="/resources/component/header.jsp"></jsp:include>
	<div class="container">
		<div id="hea">
			<h3>회원가입 마지막 단계</h3>
			<p>전달 소비 정보를 입력해주세요!</p>
		</div>
		<div id="wrap">
			<div id="calendar"></div>
			<div style="clear: both"></div>
		</div>
		<div class="button">
			<button>응애</button>
		</div>
	</div>
	<div class="modal">
		<div class="modal_content" title="">
			<form action="#" id='Frm'>
				<h1>소비 등록</h1>
				<h3 id='span'>대분류</h3>
				<select class="selec" name="large" id="large">
					<option value="0">대분류</option>
					<c:forEach var="item" items="${list}">
						<option value="${item.largeCategoryId}">${item.largeCategoryName}</option>
					</c:forEach>
				</select> <br>
				<h3 id='span'>소분류</h3>
				<select class="selec" name="small" id="small">
					<option value="0">소분류</option>
				</select> <br>
				<h3 id='span'>금액</h3>
				<input type="number" name="price" value="0" /> <br> <input
					class="btn" type="submit" value="modalSend" /> <input class="btn"
					id="close" type="button" value="close" />
			</form>
		</div>
	</div>
</body>
</html>