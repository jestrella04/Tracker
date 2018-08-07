<?php if ($auth->isUserAllowedTask('Change User Status')) : ?>
<!-- Sessions management modal window -->
<div id="admin-session-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="AdminUsersModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		  	<div class="modal-header">
				<h4 class="modal-title">Session Manager</h4>

				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  		<i class="fas fa-times"></i>
				</button>
		  	</div>

			<div id="admin-users-panel" class="modal-body">
				<form id="admin-users-form" role="form">
					<div id="admin-change-user-status"></div>
				</form>

				<form id="admin-users-submit-form" role="form" class="d-none">
					<div id="admin-submit-user-status"></div>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" form="admin-users-submit-form">Save changes</button>
			</div>
		</div>
	</div>
</div>
<?php endif; ?>
