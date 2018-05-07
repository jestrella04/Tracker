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
				<div class="d-flex justify-content-center">
					<div id="admin-usercreate-response" class="d-none text-center alert"></div>
				</div>

				<form id="admin-usercreate-form" role="form">
					<fieldset>
						<legend>
							<p class="lead text-muted">Create a new user</p>
						</legend>

						<div class="form-group row">
							<label for="user-id" class="col-sm-3 col-form-label">User Id:</label>

							<div class="col-sm-9">
								<input type="text" class="form-control" id="user-id" name="user_id" placeholder="Enter user id here" required>
							</div>
						</div>

						<div class="form-group row">
							<label for="user-name" class="col-sm-3 col-form-label">Full name:</label>
							
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user-name" name="user_name" placeholder="Enter user's full name here" required>
							</div>
						</div>

						<div class="form-group row">
							<label for="user-email" class="col-sm-3 col-form-label">Email:</label>

							<div class="col-sm-9">
								<input type="email" class="form-control" id="user-email" name="user_email" placeholder="Enter user's email here" required>
							</div>
						</div>

						<div class="form-group row">
							<div class="col-sm-10 offset-sm-3">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="user-password-auto" name="user_password_auto" value="1" checked>
									<label class="form-check-label" for="user-password-auto">Generate password automatically.</label>
								</div>
							</div>
						</div>

						<div class="form-group row d-none">
							<label for="user-password" class="col-sm-3 col-form-label">Password:</label>

							<div class="col-sm-9">
								<input type="password" class="form-control" id="user-password" name="user_password" placeholder="Enter user's password here">
							</div>
						</div>

						<div class="form-group row">
							<label for="role-id" class="col-sm-3 col-form-label">Role:</label>

							<div class="col-sm-9">
								<select class="form-control" id="role-id" name="role_id" required>
									<option value="">--- Select Role ---</option>
									<?php foreach ($roleList as $idx => $role) : ?>
									<option value="<?= $role['id'] ?>"><?= $role['name'] ?></option>
									<?php endforeach ?>
								</select>
							</div>
						</div>

						<div class="form-group row">
							<label for="department-id" class="col-sm-3 col-form-label">Department:</label>

							<div class="col-sm-9">
								<select class="form-control" id="department-id" name="department_id" required>
									<option value="">--- Select Department ---</option>
									<?php foreach ($departmentList as $idx => $department) : ?>
									<option value="<?= $department['id'] ?>"><?= $department['name'] ?></option>
									<?php endforeach ?>
								</select>
							</div>
						</div>
					</fieldset>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" form="admin-usercreate-form">Save changes</button>
			</div>
		</div>
	</div>
</div>
<?php endif; ?>