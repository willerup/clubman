var root = "/";

$(document).ready(function() {

    $("#StudentRatings, #EventTable, #Pairings, #UserList").tablesorter();

    $('.StudentList').tablesorter({
        headers: { 0: { sorter: false }}
    });

    $(".EventHeader", "#StudentRatingHistory").click(function() {
        var open = $(this).attr('data-event-closed') == "false";
        document.location = root + "events/show/" + $(this).attr('data-event-id');
    });


    $(".PlayerIncluded").click(function() {
        var control = $(this);
        if (control.attr("checked")) {
            var event_id = control.attr("data-event-id");
            var student_id = control.attr("data-student-id");
            $.ajax({
                type: 'GET',
                url: root + "events/add_player/" + event_id,
                data: { student: student_id },
                error: function () {
                    control.attr("checked", false);
                },
                success: function (data) {
                    $('.rating', '#student-' + student_id).text(data);
                    control.attr("disabled", true);
                }
            });
        }
    });

    $('.GroupSelect').change(function() {
				var groups = $('.GroupSelect:checked').map(function() {
					return 'StudentGroup-' + $(this).attr('data-group-id');
				});
				$('.StudentList tbody tr').each(function() {
					var show = false;
					for (var i = 0; i < groups.length; i++) {
						if ($(this).hasClass(groups[i])) show = true;
					}
					$(this).toggle(show);
				});
				$('#count').text($('.StudentList tbody tr:visible').size());
    });

    $('.EmailNone').click(function() {
        $(this).closest('table').find('tr:visible').removeClass("selected");
    });

    $('.EmailAll').click(function() {
        $(this).closest('table').find('tr:visible').addClass("selected");
    });

    $('.StudentList .selection').click(function() {
        $(this).closest("tr").toggleClass("selected");
    });

    $('#CreateEmail').click(function() {
        var emails = [];
        $("tr.selected:visible").find(".email").map(function() {
            emails.push($(this).text());
        });
        $("<div class='emails'>" + emails.join(', ') + "</div>").dialog();
    });

    $('#CreatePairings').click(function() {
        var ids = [];
        $('tr.selected:visible').map(function() {
            if (typeof($(this).attr('data-student-id')) != "undefined") {
                ids.push($(this).attr('data-student-id'));
            }
        });
        document.location = root + "students/pairings/" + ids.join(',');
    });


    $('.removeGame').click(function() {
        var game = $(this).closest('.game');
        $.post('/games/destroy/' + game.attr('data-game-id'), function() {
            game.remove();
        });
    });

    $('.ClosedWarning').change(function() {
        if ($(this).is(":checked")) {
            alert('Closing the event means that no changes can be made.');
        }
    });

    $('#game_student1').focus();

    var matched = /\/\/[^\/]+(\/\w+)/.exec(document.location);
    var method = matched[1];
    $('li', '#tabs').each(function() {
        var link = $(this).find('a').attr('href');
        if (link.indexOf(method) == 0) {
            $(this).addClass("TabSelected");
        }
    });
    
    
    $('.TermList .selection').click(function() {
        var term = $(this).closest('tr');
        if (!term.hasClass('selected')) {
          $.get(root + 'terms/set_current/' + term.attr('data-term-id'), function() {
            $('.TermList tr').removeClass('selected');
            term.addClass("selected");
          });
        }
    });


    $('#previous_student_id').change(function() {
        var student = $(this).val();
        document.location = root + "students/edit/" + student + "?add_to_term=true";      
    });

		$('#pay').click(function() {
			var amount = $('#amount').val() * 100;
			var student = $(this).attr('data-student');
			document.location = root + "account_events/payment/" + student + "?amount=" + amount;
			return false;
		});
});