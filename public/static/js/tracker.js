import '../../../node_modules/jquery/dist/jquery.js';
import '../../../node_modules/bootstrap/dist/js/bootstrap.js';
import '../../../node_modules/jquery.filtertable/jquery.filtertable.js';
import '../../../node_modules/jquery-table2excel/dist/jquery.table2excel.js';
import '../../../node_modules/print-this/printThis.js';
import '../../../node_modules/sticky-table-headers/js/jquery.stickytableheaders.js';
import '../../../node_modules/gasparesganga-jquery-loading-overlay/src/loadingoverlay.js';
import '../../../node_modules/moment/moment.js';

$(document).ready(function () {
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
	function formatUserStatus(userId) {
		var userInfo = $('#active-agents li').children('span[data-userid="' + userId + '"]');
		var userStatus = $(userInfo).parent().find('.badge-status').text();

		if ('Available' == userStatus) {
			$('#quicklink-oncall').removeClass('d-none');
			$('#quicklink-available').addClass('d-none');
		} else {
			$('#quicklink-oncall').addClass('d-none');
			$('#quicklink-available').removeClass('d-none');
		}
	}

	// Check if current user has a GTA session
	function checkCurrentUserGTA(userId, gtaSessions) {
		var found = false;

		$.each(gtaSessions, function (idx, gta) {
			if (gta.value == userId) found = true;
		});

		return found;
	}

	// Print GTA sessions
	function printGtaSessions(userId, gtaSessions) {
		var gtaSessionsRadios = '';
		var gtaSessionsAvailability = '';

		$('#gta-form-radios').empty();
		$('#active-gta').empty();
		gtaSessionsRadios += '<div class="form-check form-check-inline">';
		gtaSessionsRadios += '	<label><input type="radio" class="form-check-input" name="value_name" value="">None</label>';
		gtaSessionsRadios += '</div>';

		$.each(gtaSessions, function (index, gta) {
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

		if (checkCurrentUserGTA(userId, gtaSessions)) $('.gta-radio').attr('disabled', 'disabled');
	}

	// Print users currently online
	function printOnlineUsers(user, onlineUsers, gtaSessions = {}) {
		var printUsers = '';

		$('#active-agents').empty();

		$.each(onlineUsers, function (row, session) {
			var gta;
			var lastUpdate = moment.utc(session.date_last_status_change).local();
			var timeDiff = moment().diff(lastUpdate, 'minutes');
			var onCallWarning = '';

			if (session.id_status == 4 && timeDiff > 10) {
				onCallWarning = 'list-group-item-warning';
			}

			if (!$.isEmptyObject(gtaSessions)) {
				gta = gtaSessions.filter(function (data) { return data.value == session.id_user });
			}

			printUsers += '<li class="list-group-item tracker-online-item ' + onCallWarning + '">';
			printUsers += '	<span class="full-name" data-userid="' + session.id_user + '">' + session.user_name + '</span>';
			printUsers += '	<span class="badge badge-status ' + getStatusBadge(session.priority) + ' float-right">' + session.status_name + '</span>';

			if (gta) {
				if (gta.length) {
					printUsers += '	<span class="badge badge-gta badge-primary float-right">' + gta[0].name + '</span>';
				}
			}

			printUsers += '	<span class="relative-date-format text-muted float-right">' + lastUpdate.fromNow() + '</span>';
			printUsers += '</li>';
		});

		$('#active-agents').append(printUsers);

		formatUserStatus(user.id);

		$('#active-agents').trigger('db-updated');
	}

	// Print phone directory
	function getDirectoryNumbers(permissions) {
		if (checkCurrentUserPermission('Directory', permissions) && $("#dir-modal").length) {
			var dirRequest1 = $.getJSON('api/get/custom-data/1');
			var dirRequest2 = $.getJSON('api/get/custom-data/2');
			var dirRequest3 = $.getJSON('api/get/custom-data/3');

			$.when(dirRequest1, dirRequest2, dirRequest3).done(function (local, miami, external) {
				var directory = {};

				directory.local = local[0];
				directory.miami = miami[0];
				directory.external = external[0];

				printDirectoryNumbers(directory);
			});
		}
	}

	// Create or update session
	function updateSessionActivity() {
		var postData = preparePostRequest('uno=1');

		$.post('api/update/session/activity', postData);
	}

	// Print directory numbers
	function printDirectoryNumbers(directory) {
		var localDir = '';
		var miamiDir = '';
		var externalDir = '';

		// Clear old data
		$('#directory-dom').empty();
		$('#directory-mia').empty();
		$('#directory-ext').empty();

		// Local numbers
		$.each(directory.local, function (type, dir) {
			localDir += '<tr>';
			localDir += '	<td>' + dir.name + '</td>';
			localDir += '	<td>' + dir.value + '</td>';
			localDir += '</tr>';
		});

		$('#directory-dom').append(localDir);

		// Miami numbers
		$.each(directory.miami, function (type, dir) {
			miamiDir += '<tr>';
			miamiDir += '	<td>' + dir.name + '</td>';
			miamiDir += '	<td>' + dir.value + '</td>';
			miamiDir += '	<td>' + dir.description + '</td>';
			miamiDir += '</tr>';
		});

		$('#directory-mia').append(miamiDir);

		// External numbers
		$.each(directory.external, function (type, dir) {
			externalDir += '<tr>';
			externalDir += '	<td>' + dir.name + '<br><small>' + dir.description + '</small></td>';
			externalDir += '	<td>' + dir.value + '</td>';
			externalDir += '</tr>';
		});

		$('#directory-ext').append(externalDir);
	}

	// End the current session
	function sessionLogout(silent = true) {
		window.focus();

		if (false == silent) {
			showNotification('Tracker Session Expired', 'Your Tracker session expired, please log back in.');
		}

		window.location.replace('logout');
	}

	// Verify if the current user has an specific permission
	function checkCurrentUserPermission(task, permissions) {
		var found = false;

		$.each(permissions, function (key, val) {
			if (task == val.task_name) {
				found = true;
				return false;
			}
		});

		return found;
	}

	// Get users allowed status
	function getUsersAllowedStatus(allUsers) {
		var allowedStatus = '';

		$('#admin-change-user-status').empty();
		$('#admin-submit-user-status').empty();

		$.each(allUsers, function (idx, user) {
			var deptStatus = user.department_info.allowed_status;

			allowedStatus += '<div class="form-group row">';
			allowedStatus += '	<label for="' + user.id + '" class="col-sm-4 col-form-label">' + user.id + '</label>';
			allowedStatus += '	<div class="col-sm-8">';
			allowedStatus += '		<select id="' + user.id + '" class="form-control change-user-status" name="user_id[' + user.id + ']">';
			allowedStatus += '			<option value="">-- SELECT --</option>';
			allowedStatus += '			<option value="0">Logout</option>';

			$.each(deptStatus, function (id, status) {
				allowedStatus += '			<option value="' + status.id_status + '">' + status.status_name + '</option>';
			});

			allowedStatus += '		</select>';
			allowedStatus += '	</div>';
			allowedStatus += '</div>';
		});

		$('#admin-change-user-status').append(allowedStatus);
		$('#admin-submit-user-status').trigger('status-updated');
	}

	// Populate the list of users/offices for the Reporting tools
	function getReportUsers(userData, users, offices) {
		var permissions = userData.role_info.allowed_tasks;

		if (checkCurrentUserPermission('Reports', permissions)) {
			$('#report-userid').append('<option value="">All</option>');
			$('#report-officeid').append('<option value="">All</option>');

			$.each(users, function (idx, user) {
				$('#report-userid').append('<option value="' + user.id + '">' + user.id + '</option>');
			});

			$.each(offices, function (idx, office) {
				$('#report-officeid').append('<option value="' + office.id + '">' + office.name + '</option>');
			});
		} else {
			$('#report-userid').append('<option>' + userData.id + '</option>');
			$('#report-officeid').append('<option value="' + userData.id_office + '">' + userData.office_name + '</option>');

			$('#report-userid').prop("disabled", true);
			$('#report-officeid').prop("disabled", true);
		}
	}

	// Show notifications on user's desktop
	function showNotification(theTitle, theBody, theIcon = '', theTimeout = 5000) {
		var options = {
			body: theBody,
			icon: theIcon
		}

		var notification = new Notification(theTitle, options);

		notification.onclick = function (e) {
			window.focus();
		};

		setTimeout(notification.close.bind(notification), theTimeout);
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

	// Reports table content
	function getReportTableBody(row) {
		var op = '';

		op += '	<tr>';

		$.each(row, function (idx, cell) {
			cell = String(cell).replace('null', '--');

			if (/((0[1-9]|1[0-2])\-(0[1-9]|1[0-9]|2[0-9]|3[01])\-\d{4})(\s+)(([0-1][0-9]|[2][0-3]):([0-5][0-9])|24:00:00)/g.test(cell)) {
				op += '		<td>' + moment.utc(cell, 'MM-DD-YYYY HH:mm').local().format('MM-DD-YYYY') + '</td>';
			} else if (/^(([1][0-2])|([0][1-9])):[0-5][0-9] (AM|PM)$/gi.test(cell)) {
				op += '		<td>' + moment.utc(cell, 'hh:mm A').local().format('hh:mm A') + '</td>';
			} else {
				op += '		<td>' + cell + '</td>';
			}
		});

		op += '	<tr>';

		return op;
	}

	// Validate password strenght
	function validatePassword(password) {
		return /^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/.test(password);
	}

	// Async Ajax call implementation
	async function asyncAjaxCall(ajaxUrl) {
		const result = await $.ajax({
			url: ajaxUrl,
			dataType: 'json',
		});
	
		return result;
	}

	// Get current user information
	async function getCurrentUserInfo() {
		const user = await asyncAjaxCall('api/get/session/user');
		return user;
	}

	// Check if user is online
	function checkIfOnline() {
		consoleLog('Checking if user is online');

		$.getJSON('api/get/session/status/user', function(data) {
			var userStatus = parseInt(data);

			if (0 == userStatus) {
				sessionLogout(false);
			};
		});
	}

	// Update all tracker data
	function trackerUpdateAll(user) {
		consoleLog('Reloading tracker information.');
		
		var permissions = user.role_info.allowed_tasks;
		var onlineUsersRequest = $.getJSON("api/get/session");

		$.when(onlineUsersRequest).done(function (onlineUsers) {
			// Print online users and GTA sessions
			if (checkCurrentUserPermission('GTA', permissions) && $("#gta-modal").length) {
				var gtaRequest = $.getJSON('api/get/custom-data/4');

				$.when(gtaRequest).done(function (gtaSessions) {
					printGtaSessions(user.id, gtaSessions);
					printOnlineUsers(user, onlineUsers, gtaSessions);
				});
			} else {
				printOnlineUsers(user, onlineUsers);
			}

			// Hide the non active users
			$('#admin-users-form .form-group').addClass('d-none');

			$.each(onlineUsers, function(idx, user) {
				$('#' + user.id_user).val('');
				$('#' + user.id_user).parent().parent().removeClass('d-none');
			});

			// Update session activity date and time
			updateSessionActivity();
		});
	}

	// Events triggering trackerUpdateAll()
	function triggerTrackerUpdateAll(trackerUser) {
		// User trying to set himself available by clicking on the quick link
		$('#quicklink-available').on('click', function () {
			var postData = preparePostRequest('session=1&status_id=1');

			$.post('api/update/status', postData, function () {
				trackerUpdateAll(trackerUser);
			});
		});

		// User trying to set himself on call by clicking on the quick link
		$('#quicklink-oncall').on('click', function () {
			var postData = preparePostRequest('session=1&status_id=4');

			$.post('api/update/status', postData, function () {
				trackerUpdateAll(trackerUser);
			});
		});

		// User is willing to change status, let's update it
		$('#status-update').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());

			e.preventDefault();

			$.post('api/update/status', formData, function () {
				trackerUpdateAll(trackerUser);
				$('#change-status-modal').modal('hide');
			});
		});

		// User updating GTA data
		$('#gta-select').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());

			e.preventDefault();

			$.post('api/update/custom-data-value', formData, function () {
				trackerUpdateAll(trackerUser);
				$('#gta-modal').modal('hide');
			});
		});

		// Admin updating users status
		$('#admin-users-form').on('submit', function (e) {
			var formData = preparePostRequest($("#admin-users-form :input").filter(function(index, element) {
        		return $(element).val() != '';
    		}).serialize());

			e.preventDefault();

			$.post('api/update/status', formData, function (data) {
				trackerUpdateAll(trackerUser);
				$('#admin-session-modal').modal('hide');
			});
		});
	}

	// Log a message to the browser's console
	function consoleLog(msg)
	{
		console.log(msg);
	}

	// Request permission to run notifications
	Notification.requestPermission().then(function(result) {
		consoleLog('Current notifications status: ' + result + '.');
	});

	// Enable the login forms only after the page is loaded (Tricky way to enforce javascript)
	$('.form-signin fieldset').attr('disabled', false);

	// Init variables
	var trackerCurrentPage = window.location.pathname;
	var trackerSessionTimer;

	// Check if the user is logged in
	if (!trackerCurrentPage.includes('/login')) {
		// Display loading overlay
		$('body').LoadingOverlay('show');

		// Check if user is online
		checkIfOnline();

		// Get current user information
		consoleLog('Grabbing active user information from server session.');

		getCurrentUserInfo().then(function(trackerUser) {
			var permissions = trackerUser.role_info.allowed_tasks;

			$.when(
				$.getJSON('api/get/users'),
				$.getJSON('api/get/offices')
			).then(function (allUsers, allOffices) {
				// Populate list of users/offices for reports
				getReportUsers(trackerUser, allUsers[0], allOffices[0]);

				// Populate the status list for all users
				if (checkCurrentUserPermission('Change User Status', permissions) && $("#admin-session-modal").length) {
					getUsersAllowedStatus(allUsers[0]);
				}

				// Load initial data
				trackerUpdateAll(trackerUser);
			});

			// Populate the directory of phone numbers
			getDirectoryNumbers(permissions);

			// Reload data every minute
			trackerSessionTimer = setInterval(function () {
				checkIfOnline();
				trackerUpdateAll(trackerUser);
			}, 60000);

			// Hide loading overlay
			$('body').LoadingOverlay('hide');

			// Events triggering trackerUpdateAll
			triggerTrackerUpdateAll(trackerUser);
		});

		/******************************/
		/* Event driven functionality */
		/******************************/

		// Admin/User generating a report
		$('#admin-reports-form').on('submit', function (e) {
			var user = $('#report-userid').val();
			var office = $('#report-officeid').val();
			var type = $('#report-type').val();
			var start = moment($('#report-start').val()).utc().format('YYYY-MM-DD HH');
			var end = moment($('#report-end').val()).utc().format('YYYY-MM-DD HH');

			//var formData = preparePostRequest($(this).serialize());
			var formData = preparePostRequest('user_id=' + user + '&office_id=' + office + '&report_type=' + type + '&start_date=' + start + '&end_date=' + end);
			var op = '';

			e.preventDefault();

			$('#admin-reports-modal').LoadingOverlay('show');
			$('#admin-reports-empty').addClass('d-none');
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
					$('#admin-reports-modal').LoadingOverlay('hide');

					$('#reports-excel-button').attr('disabled', 'disabled');
					$('#reports-print-button').attr('disabled', 'disabled');
				} else {
					$('#admin-reports-table').append(op);
					$('#admin-reports-empty').addClass('d-none');
					$('#admin-reports-container').removeClass('d-none');
					$('#admin-reports-modal').LoadingOverlay('hide');

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

			$('#admin-settings-modal').LoadingOverlay('show');

			$.post('api/update/settings', formData, function (data) {
				$('#admin-settings-modal').modal('hide');
				$('#admin-settings-modal').LoadingOverlay('hide');
			});
		});

		// Admin toggling if password should be generated automatically or not
		$('#user-password-auto').on('change', function (e) {
			if ($(this).is(':checked')) {
				$(this).val('1');
				$('#user-password').attr('required', false);
				$('#user-password').parent().parent().addClass('d-none');
			} else {
				$(this).val('0');
				$('#user-password').attr('required', 'required');
				$('#user-password').parent().parent().removeClass('d-none');
			}
		});

		// Admin changing the department for a new user
		$('#department-id').on('change', function () {
			var departmentId = $(this).val();
			var statusInput = $('#status-id');
			var op = '';

			statusInput.empty();

			if (departmentId.length) {
				statusInput.attr('disabled', false);

				$.when(
					$.getJSON("api/get/departments/" + departmentId + "/status"),
				).then(function (data) {
					op += '<option value="0">Department Default</option>';

					$.each(data, function (idx, status) {
						op += '<option value="' + status.id_status + '">' + status.status_name + '</option>';
					});

					statusInput.append(op);
				});
			} else {
				statusInput.attr('disabled', 'disabled');
			}
		});

		// Admin creating a user
		$('#admin-usercreate-form').on('submit', function (e) {
			var formData = preparePostRequest($(this).serialize());
			var password = $('#user-password').val();
			var passwordAuto = $('#user-password-auto').val();

			e.preventDefault();

			$('#admin-users-modal').LoadingOverlay('show');
			$('#admin-usercreate-response').addClass('d-none');
			$('#admin-usercreate-response').removeClass('alert-danger');
			$('#admin-usercreate-response').removeClass('alert-success');
			$('#admin-usercreate-response').empty();

			if ('0' == passwordAuto && !validatePassword(password)) {
				$('#admin-usercreate-response').append('Please verify password strenght requirements');
				$('#admin-usercreate-response').addClass('alert-danger');
				$('#admin-usercreate-response').removeClass('d-none');
			} else {
				var msg = 'An error ocurred while creating the user';
				var alert = 'alert-danger';

				$.post('api/insert/users', formData, function (data) {
					var insertedUserId = $.parseJSON(data);

					if (insertedUserId) {
						if (insertedUserId.id) {
							msg = 'User created successfully';
							alert = 'alert-success';
						}
					}

					$('#admin-usercreate-response').append(msg);
					$('#admin-usercreate-response').addClass(alert);
					$('#admin-usercreate-response').removeClass('d-none');
					$('#admin-usercreate-form')[0].reset();
					$('#admin-users-modal').LoadingOverlay('hide');
				});
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

		// User logging out
		$('#btn-logout').on('click', function () {
			sessionLogout();
		});
	}
});
