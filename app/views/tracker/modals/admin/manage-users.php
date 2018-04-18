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
				<form id="admin-usercreate-form" role="form">
					<fieldset>
						<div class="form-group row">
							<label for="emp-userid" class="col-sm-4 col-form-label">User Id:</label>

							<div class="col-sm-8">
								<input type="text" class="form-control" id="emp-userid" name="emp-userid" placeholder="Enter user id here">
							</div>
						</div>

						<div class="form-group row">
							<label for="emp-username" class="col-sm-4 col-form-label">Full name:</label>
							
							<div class="col-sm-8">
								<input type="text" class="form-control" id="emp-username" name="emp-username" placeholder="Enter user's full name here">
							</div>
						</div>

						<div class="form-group row">
							<label for="emp-useremail" class="col-sm-4 col-form-label">Email:</label>

							<div class="col-sm-8">
								<input type="email" class="form-control" id="emp-useremail" name="emp-useremail" placeholder="Enter user's email here">
							</div>
						</div>

						<div class="form-group row">
							<label for="emp-password" class="col-sm-4 col-form-label">Password:</label>

							<div class="col-sm-8">
								<input type="password" class="form-control" id="emp-password" name="emp-password" placeholder="Enter user's password here">
							</div>
						</div>

						<div class="form-group row">
							<label for="emp-role" class="col-sm-4 col-form-label">Role:</label>

							<div class="col-sm-8">
								<select class="form-control" id="emp-role" name="emp-role"></select>
							</div>
						</div>

						<div class="form-group row">
							<label for="emp-dept" class="col-sm-4 col-form-label">Department:</label>

							<div class="col-sm-8">
								<select class="form-control" id="emp-dept" name="emp-dept"></select>
							</div>
						</div>
					</fieldset>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" form="admin-usercreate-form">Save changes</button>
			</div>
		</div>
	</div>
</div>
<?php endif; ?>