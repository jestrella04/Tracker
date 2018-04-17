<?php if ($auth->isUserAllowedTask('Manage Users')) : ?>
<!-- Users creation modal window -->
<div id="admin-users-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="AdminCreateModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Users Manager</h4>

			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  <i class="fas fa-times"></i>
			</button>
		  </div>

			<div class="modal-body">
				<form id="admin-usercreate-form" class="" role="form" method="post" target="_blank">
					<fieldset>
						<div class="form-group">
							<label for="emp-userid">User id:</label>
							<input type="text" class="form-control" id="emp-userid" name="emp-userid" placeholder="Enter user id here">
						</div>

						<div class="form-group">
							<label for="emp-username">User's name:</label>
							<input type="text" class="form-control" id="emp-username" name="emp-username" placeholder="Enter user's full name here">
						</div>

						<div class="form-group">
							<label for="emp-useremail">User's email:</label>
							<input type="email" class="form-control" id="emp-useremail" name="emp-useremail" placeholder="Enter user's email here">
						</div>
					</fieldset>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button id="admin-usercreate-submit" type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
	</div>
</div>
<?php endif; ?>