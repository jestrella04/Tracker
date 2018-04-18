$(document).ready(function () {
	// Global variables
	var trackerUser;
	var trackerUserPermissions;
	var trackerInitialData = 0;
	var trackerSessionTimer;
	var trackerNotificationTimer;
	var trackerQueue;
	var trackerOnlineUsers;
	var trackerGtaSessions;

	// Return the visual badge corresponding to a status priority
	function getStatusBadge(priority) {
		if (1 == priority) return 'badge-success';
		if (2 == priority) return 'badge-warning';
		if (3 == priority) return 'badge-danger';
		if (4 == priority) return 'badge-primary';
		if (5 == priority) return 'badge-info';
		if (6 == priority) return 'badge-secondary';
	}

	// Getting the next in line and formatting its status
	function formatUserStatus() {
		var li = $('#active-agents li:first-child');
		var span = $('#active-agents li:first-child .badge-status');
		var userInfo = $('#active-agents li').children('span[data-userid="' + trackerUser.id + '"]');
		var userStatus = $(userInfo).parent().find('.badge-status').text();

		if ('Available' == userStatus) {
			$('#quicklink-oncall').removeClass('d-none');
			$('#quicklink-available').addClass('d-none');
		} else {
			$('#quicklink-oncall').addClass('d-none');
			$('#quicklink-available').removeClass('d-none');
		}

		if ('Available' == span.text()) {
			li.addClass('list-group-item-warning');
		}
	}

	// Reload GoToAssist data
	function getGtaSessions() {
		$.ajax({
			url: "api/get/custom-data/4",
			async: false,
			dataType: 'json',
			success: function (json) {
				trackerGtaSessions = json;
			}
		});
	}

	// Check if current user has a GTA session
	function checkCurrentUserGTA() {
		var found = false;

		$.each(trackerGtaSessions, function (idx, gta) {
			if (gta.value == trackerUser.id) found = true;
		});

		return found;
	}

	// Print GTA sessions
	function printGtaSessions() {
		var gtaSessionsRadios = '';
		var gtaSessionsAvailability = '';

		$('#gta-form-radios').empty();
		$('#active-gta').empty();
		gtaSessionsRadios += '<div class="form-check form-check-inline">';
		gtaSessionsRadios += '	<label><input type="radio" class="form-check-input" name="value_name" value="">None</label>';
		gtaSessionsRadios += '</div>';

		$.each(trackerGtaSessions, function (index, gta) {
			var badge = 'badge-success';
			var owned = 'Available';
			var disabled = '';

			if ('' !== gta.value) {
				badge = 'badge-danger';
				owned = 'In use by <strong>' + gta.value + '</strong>';
				disabled = 'disabled';
			}

			gtaSessionsRadios += '<div class="form-check form-check-inline">';
			gtaSessionsRadios += '	<label>';
			gtaSessionsRadios += '		<input type="radio" class="form-check-input gta-radio" name="value_name" value="' + gta.name + '" ' + disabled + '>' + gta.name;
			gtaSessionsRadios += '	</label>';
			gtaSessionsRadios += '</div>';
			gtaSessionsAvailability += '<p class="lead"><span class="badge ' + badge + '">' + gta.name + '</span>' + owned + '</p>';
		});

		$('#gta-form-radios').append(gtaSessionsRadios);
		$('#active-gta').append(gtaSessionsAvailability);

		if (checkCurrentUserGTA()) $('.gta-radio').attr('disabled', 'disabled');
	}

	// Print users currently online
	function printOnlineUsers() {
		var onlineUsers = '';

		$('#active-agents').empty();

		$.each(trackerOnlineUsers, function (row, session) {
			var gta = trackerGtaSessions.filter(function (data) { return data.value == session.id_user });

			onlineUsers += '<li class="list-group-item tracker-online-item">';
			onlineUsers += '	<span class="full-name" data-userid="' + session.id_user + '">' + session.user_name + '</span>';
			onlineUsers += '	<span class="badge badge-status ' + getStatusBadge(session.priority) + ' float-right">' + session.status_name + '</span>';

			if (gta.length) {
				onlineUsers += '	<span class="badge badge-gta badge-primary float-right">' + gta[0].name + '</span>';
			}

			onlineUsers += '	<span class="relative-date-format text-muted float-right" data-last-update="' + session.date_last_status_change + '"></span>';
			onlineUsers += '</li>';
		});

		$('#active-agents').append(onlineUsers);

		formatUserStatus();

		// Format date and time
		dateFormat();

		$('#active-agents').trigger('db-updated');
	}

	// Reload and populate all information
	function trackerUpdateAll() {
		if (checkCurrentUserPermission('GTA') && $("#gta-modal").length) {
			getGtaSessions();
			printGtaSessions();
		}

		updateSessionActivity();
		getOnlineUsers();
		printOnlineUsers();

		if (checkCurrentUserPermission('Change User Status') && $("#admin-session-modal").length) {
			getOnlineUsersAllowedStatus();
		}
	}

	// Create or update session
	function updateSessionActivity() {
		var postData = preparePostRequest('uno=1');

		$.post('api/update/session', postData);
	}

	// Get directory phone numbers
	function getDirectoryInfo() {
		var localDir = '';
		var miamiDir = '';
		var externalDir = '';

		// Clear old data
		$('#directory-dom').empty();
		$('#directory-mia').empty();
		$('#directory-ext').empty();

		// Local numbers
		$.getJSON('api/get/custom-data/1', function (json) {
			$.each(json, function (type, dir) {
				localDir += '<tr>';
				localDir += '	<td>' + dir.name + '</td>';
				localDir += '	<td>' + dir.value + '</td>';
				localDir += '</tr>';
			});

			$('#directory-dom').append(localDir);
		});

		// Miami numbers
		$.getJSON('api/get/custom-data/2', function (json) {
			$.each(json, function (type, dir) {
				miamiDir += '<tr>';
				miamiDir += '	<td>' + dir.name + '</td>';
				miamiDir += '	<td>' + dir.value + '</td>';
				miamiDir += '	<td>' + dir.description + '</td>';
				miamiDir += '</tr>';
			});

			$('#directory-mia').append(miamiDir);
		});

		// External numbers
		$.getJSON('api/get/custom-data/3', function (json) {
			$.each(json, function (type, dir) {
				externalDir += '<tr>';
				externalDir += '	<td>' + dir.name + '<br><small>' + dir.description + '</small></td>';
				externalDir += '	<td>' + dir.value + '</td>';
				externalDir += '</tr>';
			});

			$('#directory-ext').append(externalDir);
		});
	}

	// Get current session information
	function getCurrentSession() {
		$.ajax({
			url: "api/get/session/user",
			async: false,
			dataType: 'json',
			success: function (json) {
				trackerUser = json;
			}
		});
	}

	// Verify current session is still active, otherwise log user out
	function checkCurrentSession() {
		getCurrentSession();

		if (trackerUser) {
			if (!trackerUser.id) {
				window.location.replace('logout');
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	}

	// Get current user permissions
	function getCurrentUserPermissions() {
		$.ajax({
			url: "api/get/users/tasks/" + trackerUser.id,
			async: false,
			dataType: 'json',
			success: function (json) {
				trackerUserPermissions = json;
			}
		});
	}

	// Verify if the current user has an specific permission
	function checkCurrentUserPermission(task) {
		var found = false;

		$.each(trackerUserPermissions, function (key, val) {
			if (task == val.task_name) {
				found = true;
				return false;
			}
		});

		return found;
	}

	// Get users currently online
	function getOnlineUsers() {
		$.ajax({
			url: "api/get/session",
			async: false,
			dataType: 'json',
			success: function (json) {
				trackerOnlineUsers = json;
			}
		});
	}

	// Get online users allowed status
	function getOnlineUsersAllowedStatus() {
		var allowedStatus = '';
		var status;

		$('#admin-change-user-status').empty();

		$.each(trackerOnlineUsers, function (row, session) {
			allowedStatus += '<div class="form-group row">';
			allowedStatus += '	<label for="' + session.id_user + '" class="col-sm-4 col-form-label">' + session.id_user + '</label>';
			allowedStatus += '	<div class="col-sm-8">';
			allowedStatus += '		<select id="' + session.id_user + '" class="form-control" name="user_id[' + session.id_user + ']" >';
			allowedStatus += '			<option value="0">Logout</option>';

			$.ajax({
				url: 'api/get/users/status/' + session.id_user,
				async: false,
				dataType: 'json',
				success: function (json) {
					status = json;
				}
			});

			$.each(status, function (id, stat) {
				if (session.id_status == stat.id_status) {
					allowedStatus += '			<option value="' + stat.id_status + '" selected="selected">' + stat.status_name + '</option>';
				} else {
					allowedStatus += '			<option value="' + stat.id_status + '">' + stat.status_name + '</option>';
				}
			});

			allowedStatus += '		</select>';
			allowedStatus += '	</div>';
			allowedStatus += '</div>';
		});

		$('#admin-change-user-status').append(allowedStatus);
	}

	// Show notifications on user's desktop
	function desktopNotification(title, body, timeout) {
		if (window.Notification && Notification.permission !== "granted") {
			Notification.requestPermission(function (status) {
				if (Notification.permission !== status) {
					Notification.permission = status;
				}
			});
		}

		var tag = 'tracker';
		var icon = 'public/img/favicon.png';

		if (window.Notification && Notification.permission === "granted") {
			var notification = new Notification(title, {
				'body': body,
				'tag': tag,
				'icon': icon
			});

			notification.onclick = function (e) {
				window.focus();
			};
			setTimeout(function () {
				notification.close();
			}, timeout);

		} else if (window.Notification && Notification.permission !== "denied") {
			Notification.requestPermission(function (status) {

				if (Notification.permission !== status) {
					Notification.permission = status;
				}

				// If the user said okay
				if (status === "granted") {
					var notification = new Notification(title, {
						'body': body,
						'tag': tag,
						'icon': icon
					});

					notification.onclick = function (e) {
						window.focus();
					};
					setTimeout(function () {
						notification.close();
					}, timeout);
				}
			});
		}
	}

	function numberPad(number) {
		return (number < 10 ? '0' : '') + number;
	}

	// Date and time formatting
	function dateFormat() {
		var shortDateFormat = 'dd/MM/yyyy';
		var longDateFormat = 'dd/MM/yyyy HH:mm:ss';

		$(".short-date-format").each(function (idx, elem) {

		});

		$(".long-date-format").each(function (idx, elem) {

		});

		$(".relative-date-format").each(function (idx, elem) {
			var date = $(elem).attr('data-last-update');

			if ($(elem).is(":input")) {
				$(elem).val(moment(date).fromNow());
			} else {
				$(elem).text(moment(date).fromNow());
			}
		});
	}

	// Get CSRF token for post requests
	function getCsrfToken() {
		var csrfNameKey = $('#tokenKeyName').attr('name');
		var csrfName = $('#tokenKeyName').val();
		var csrfValueKey = $('#tokenKeyValue').attr('name');
		var csrfValue = $('#tokenKeyValue').val();
		var csrfToken = {}

		csrfToken[csrfNameKey] = csrfName;
		csrfToken[csrfValueKey] = csrfValue;

		return csrfToken;
	}

	// Prepare POST requests before sending to the server
	function preparePostRequest(data) {
		var token = getCsrfToken();
		return data + '&' + $.param(token);
	}

	// Reports table header
	function getReportTableHeader(headers) {
		var op = '';

		op += '<thead>';
		op += '	<tr>';

		$.each(headers, function (idx, heading) {
			op += '		<th>' + String(heading).toUpperCase().replace('_', ' ') + '</th>';
		});

		op += '	</tr>';
		op += '</thead>';

		return op;
	}

	// Repprts table content
	function getReportTableBody(row) {
		var op = '';

		op += '	<tr>';

		$.each(row, function (idx, cell) {
			op += '		<td>' + String(cell).replace('null', '--') + '</td>';
		});
		op += '	<tr>';

		return op;
	}

	// Pre-validate password
	function validatePassword(pass) {
		/**
		 * Password validation RegEx for JavaScript
		 * 
		 * Passwords must be 
		 * - At least 8 characters long, max length anything
		 * - Include at least 1 lowercase letter
		 * - 1 capital letter
		 * - 1 number
		 * - 1 special character => !@#$%^&*
		 *
		 * @author Harish Chaudhari <harishchaudhari.com>
		 * 
		 */
		var isValid = /^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/.test(pass);

		return isValid;
	}

	// Check if the user is logged in
	if (checkCurrentSession()) {
		// User is logged in, get permissions
		getCurrentUserPermissions();

		// Load initial data
		trackerUpdateAll();

		// Out of the trackerUpdateAll to load it just the very first time
		if (checkCurrentUserPermission('Directory') && $("#dir-modal").length) {
			getDirectoryInfo();
		}

		// Populate list of users for reports
		if (checkCurrentUserPermission('Reports')) {
			$('#report-userid').append('<option value="">All</option>');

			$.getJSON('api/get/users', function (json) {
				$.each(json, function (idx, user) {
					$('#report-userid').append('<option value="' + user.id + '">' + user.id + '</option>');
				});
			});
		} else {
			$('#report-userid').append('<option>' + trackerUser.id + '</option>');
		}

		// Every minute, check session is still active and reload data
		trackerSessionTimer = setInterval(function () {
			checkCurrentSession();
			trackerUpdateAll();
		}, 60000);

		// Every 5 minutes, display queue order to support agents
		if (checkCurrentUserPermission('Call Center')) {
			trackerQueue = setInterval(function () {
				var innerHtml = '\n';
				var max = 5;
				var order = $('#active-agents li').find('span:has(.badge-success)');
				var orderCount = $(order).length;

				if (5 >= orderCount) {
					max = orderCount;
				}

				for (var i = 0; i < max; i++) {
					innerHtml += (i + 1) + '. ' + $(order).eq(i).children('.full-name').text() + '\n';
				}

				desktopNotification('Now available:', innerHtml, 15000);
			}, 300000);
		}

		// Actions triggered every time tracker is updated
		$('#active-agents').bind('db-updated', function () {
			// Get the next agent
			var next = $('#active-agents li:first-child span').attr('data-userid');

			// Get next agent status
			var status = $('#active-agents li:first-child .badge-status').text();

			// Reset notification timer
			if (trackerUser.id !== next || 'Available' !== status) {
				trackerInitialData = 0;

				// Somehow Chrome continues to display notifications
				// even when the user changes status to not available.
				// Attempting to clear interval everytime db-updated is
				// triggered and then initialize it again.
				clearInterval(trackerNotificationTimer);
				trackerNotificationTimer = null;
			}

			// Check for current user availability
			if (trackerUser.id == next && 'Available' == status) {
				// If needed, display notification on load
				if (0 == trackerInitialData) {
					desktopNotification('Tracker Update', 'Watch out: Next call is yours!', 7000);
				}

				// Check if there are any reminders already set
				// If no reminders, remind current user every two minutes
				if (null == trackerNotificationTimer || 0 == trackerNotificationTimer) {
					trackerNotificationTimer = setInterval(function () {
						desktopNotification('Tracker Update', 'Watch out: Next call is yours!', 7000);
					}, 120000);
				}

				trackerInitialData++;
			}
		});

		/******************************/
		/* Event driven functionality */
		/******************************/

		// User is willing to change status, let's update it
		$('#status-update').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());

			e.preventDefault();

			$.post('api/update/status', formData, function () {
				trackerUpdateAll();
				$('#change-status-modal').modal('hide');
			});
		});

		// User trying to set himself available by clicking on the quick link
		$('#quicklink-available').click(function () {
			var postData = preparePostRequest('user_id=' + trackerUser.id + '&status_id=1');

			$.post('api/update/status', postData, function () {
				trackerUpdateAll();
			});
		});

		// User trying to set himself on call by clicking on the quick link
		$('#quicklink-oncall').click(function () {
			var postData = preparePostRequest('user_id=' + trackerUser.id + '&status_id=4');

			$.post('api/update/status', postData, function () {
				trackerUpdateAll();
			});
		});

		// User updating GTA data
		$('#gta-select').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());

			e.preventDefault();

			$.post('api/update/custom-data-value', formData, function () {
				trackerUpdateAll();
				$('#gta-modal').modal('hide');
			});
		});

		// Admin updating users status
		$('#admin-users-form').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());

			e.preventDefault();

			$.post('api/update/status', formData, function (data) {
				trackerUpdateAll();
				$('#admin-session-modal').modal('hide');
			});
		});

		// Admin/User generating a report
		$('#admin-reports-form').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());
			var op = '';

			e.preventDefault();

			$('#admin-reports-empty').addClass('d-none');
			$('#admin-reports-loading').removeClass('d-none');
			$('#admin-reports-table').empty();

			$.post('api/get/report', formData, function (json) {
				var parsedJson = $.parseJSON(json);

				if (parsedJson.length) {
					var headers = $.map(parsedJson[0], function (element, index) { return index });

					op += getReportTableHeader(headers);
					op += '<tbody>';

					$.each(parsedJson, function (idx, report) {
						op += getReportTableBody(report);
					});

					op += '</tbody>';
				}

				if (0 === op.length) {
					$('#admin-reports-empty').removeClass('d-none');
					$('#admin-reports-container').addClass('d-none');
					$('#admin-reports-loading').addClass('d-none');

					$('#reports-excel-button').attr('disabled', 'disabled');
					$('#reports-print-button').attr('disabled', 'disabled');
				} else {
					$('#admin-reports-table').append(op);
					$('#admin-reports-empty').addClass('d-none');
					$('#admin-reports-container').removeClass('d-none');
					$('#admin-reports-loading').addClass('d-none');

					$('#reports-excel-button').attr('disabled', false);
					$('#reports-print-button').attr('disabled', false);
				}

				// Sticky table headers for reports
				$('#admin-reports-table').stickyTableHeaders();
			});
		});

		// Admin updating app settings
		$('#admin-settings-form').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());

			e.preventDefault();

			$.post('api/update/settings', formData, function (data) {
				$('#admin-settings-modal').modal('hide');
			});
		});

		// Admin creating a user
		$('#admin-usercreate-form').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());
			var password = $('#user-password').val();

			e.preventDefault();

			$('#admin-usercreate-response').addClass('d-none');
			$('#admin-usercreate-response').removeClass('alert-danger');
			$('#admin-usercreate-response').removeClass('alert-success');
			$('#admin-usercreate-response').empty();

			if (validatePassword(password)) {
				$.post('api/insert/users', formData, function (data) {
					if (data.length) {
						$('#admin-usercreate-response').append('User created successfully');
						$('#admin-usercreate-response').addClass('alert-success');
						$('#admin-usercreate-response').removeClass('d-none');
						$('#admin-usercreate-form')[0].reset();
					}
				});
			} else {
				$('#admin-usercreate-response').append('Please verify password strenght requirements');
				$('#admin-usercreate-response').addClass('alert-danger');
				$('#admin-usercreate-response').removeClass('d-none');
			}
		});

		// Directory filters
		$('.dir-table-filter').filterTable({
			inputSelector: '#dir-filter-input', minRows: 0
		});

		// User clicking on button to clear applied filter on directory
		$('#dir-filter-clear').on('click', function () {
			$('#dir-filter-input').val('').focus().trigger('click');
		});

		// User is changing password after a successful login with the default one
		$('#password-update-form').on('submit', function (e) {
			var pass1 = $('#password1').val();
			var pass2 = $('#password2').val();
			var pass3 = $('#password3').val();

			if (pass2 !== pass3 || !validatePassword(pass2) || !validatePassword(pass3)) {
				e.preventDefault();
				alert('Please verify password strenght requirements.');
			}
		});

		// Print a report
		$('#reports-print-button').on('click', function () {
			$("#admin-reports-table").printThis({
				debug: false,
				importCSS: true,
				printContainer: true
			});
		});

		// Export report to Excel
		$('#reports-excel-button').on('click', function () {
			$('#admin-reports-table').table2excel({
				//exclude: ".excludeThisClass",
				name: 'Tracker Report',
				filename: 'TrackerReport' //do not include extension
			});
		});
	}
});