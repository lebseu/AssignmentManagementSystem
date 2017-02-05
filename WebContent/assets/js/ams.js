function getAllCourses()
{
	$.ajax(
	{
		method : "POST",
		url : "CourseHandlerServlet",
		data :
		{
			method : "all"
		}
	}).done(function(html)
	{
		alert(html);
	});

	var courses = html.spit("<br>");

}

function refresh()
{
	var html = "";
	courses = getAllCourses();
	for (course in courses)
	{
		html = html
				+ '<li><a href="#" data-course="'
				+ course
				+ '">'
				+ course
				+ '<button type="button" class="btn btn-default btn-xs btnModifyCourse pull-right"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button><button type="button" class="btn btn-default btn-xs btnRemoveCourse pull-right"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></a></li>';
	}
	$('.dropdown-menu').html();
}

$(document).on("click", ".btnRemoveCourse", function(event)
{
	event.stopPropagation();
	if (confirm('Are you sure to remove the course?'))
	{
		var clickedButton = $(this);
		var removeCourseName = clickedButton.parent().data('course');
		$.ajax(
		{
			method : "POST",
			url : "CourseHandlerServlet",
			data :
			{
				method : "removeCourse",
				removeCourseName : removeCourseName
			}
		}).done(function(html)
		{
			if (html !== "")
			{
				alert(html);
			}
			else
			{
				clickedButton.parent().parent().remove();
			}
		});
	}

});

$(document).on(
		"click",
		".btnModifyCourse",
		function(event)
		{
			event.stopPropagation();
			var clickedButton = $(this);
			var modifyOldCourseName = clickedButton.prev().text();
			var modifyNewCourseName = prompt(
					"Please input the new course name:", modifyOldCourseName);

			if (modifyNewCourseName !== "" && modifyNewCourseName !== null)
			{
				$.ajax(
				{
					method : "POST",
					url : "CourseHandlerServlet",
					data :
					{
						method : "modifyCourse",
						modifyOldCourseName : modifyOldCourseName,
						modifyNewCourseName : modifyNewCourseName
					}
				}).done(
						function(html)
						{
							if (html !== "")
							{
								alert(html);
							}
							else
							{
								clickedButton.prev().html(modifyNewCourseName);
								clickedButton.parent().data('course',
										modifyNewCourseName);

							}
						});

			}
		});

$(document)
		.on(
				"click",
				"#btnNewCourse",
				function(event)
				{
					event.stopPropagation();
					var newCourseName = $('#inputNewCourseName').val();
					if (newCourseName !== "")
					{
						$
								.ajax(
								{
									method : "POST",
									url : "CourseHandlerServlet",
									data :
									{
										method : "newCourse",
										newCourseName : newCourseName
									}
								})
								.done(
										function(html)
										{
											if (html !== "")
											{
												alert(html);
											}
											else
											{
												$('#inputNewCourseName')
														.val("");
												$('ul li:last')
														.before(
																'<li><a href="#" data-course="'
																		+ newCourseName
																		+ '"><span>'
																		+ newCourseName
																		+ '</span><button type="button" class="btn btn-default btn-xs btnModifyCourse pull-right"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button><button type="button" class="btn btn-default btn-xs btnRemoveCourse pull-right"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></a></li>');

											}

										});
					}

				});

$(document).on("click", "a", function(event)
{
	var courseName = $(this).data('course');
	
	$.ajax(
	{
		method : "POST",
		url : "assignments.jsp",
		data :
		{
			courseName : courseName
		}
	}).done(function(html)
	{
		$('#assignments').html(html);
	});
});

$(document)
		.on(
				"click",
				"#btnNewStudent",
				function(event)
				{
					var stuName = $('#inputStuName').val();
					var stuNumber = $('#inputStuNumber').val();
					var finishedAssignments = $('#inputFinishedAssignments')
							.val();
					var courseName = $('#currentCourse').data('current-course');

					if (stuNumber !== "")
					{
						$
								.ajax(
										{
											method : "POST",
											url : "CourseHandlerServlet",
											data :
											{
												method : "newStudent",
												stuName : stuName,
												stuNumber : stuNumber,
												finishedAssignments : finishedAssignments,
												courseName : courseName
											}
										})
								.done(
										function(html)
										{
											if (html !== "")
											{
												alert(html);
											}
											else
											{

												$('#inputStuName').val("");
												$('#inputStuNumber').val("");
												$('#inputFinishedAssignments')
														.val("");
												$('tr:last')
														.before(
																'<tr><td>'
																		+ stuNumber
																		+ '</td><td>'
																		+ stuName
																		+ '</td><td>'
																		+ finishedAssignments
																		+ '</td><td><button type="button" class="btn btn-default btn-xs btnModifyAssignment pull-right"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> </button> <button type="button" class="btn btn-default btn-xs btnRemoveStudent pull-right"> <span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></td></tr>');

											}

										});
					}

				});

$(document).on(
		"click",
		".btnRemoveStudent",
		function(event)
		{
			event.stopPropagation();
			var clickedButton = $(this);
			var removeStudentNumber = clickedButton.parent().prev().prev()
					.prev().text();
			if (confirm('Are you sure to remove the student('
					+ removeStudentNumber + ')?'))
			{

				var courseName = $('#currentCourse').data('current-course');

				$.ajax(
				{
					method : "POST",
					url : "CourseHandlerServlet",
					data :
					{
						method : "removeStudent",
						removeStudentNumber : removeStudentNumber,
						courseName : courseName
					}
				}).done(function(html)
				{
					if (html !== "")
					{
						alert(html);
					}
					else
					{
						clickedButton.parent().parent().remove();
					}
				});
			}

		});

$(document).on(
		"click",
		".btnModifyAssignment",
		function(event)
		{
			// event.stopPropagation();
			var clickedButton = $(this);
			var modifyStudentNumber = clickedButton.parent().prev().prev().prev()
					.text();
			var finishedAssignments = prompt("Finished Assignments:", clickedButton.parent().prev().text());
			
			var courseName = $('#currentCourse').data('current-course');

			if(finishedAssignments !== null){
				$.ajax(
				{
					method : "POST",
					url : "CourseHandlerServlet",
					data :
					{
						method : "modifyAssignment",
						modifyStudentNumber : modifyStudentNumber,
						courseName : courseName,
						finishedAssignments : finishedAssignments
					}
				}).done(function(html)
				{
					if (html !== "")
					{
						alert(html);
					}
					else
					{
						clickedButton.parent().prev().text(finishedAssignments);
					}
				});
			}

		});
