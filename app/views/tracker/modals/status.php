	<!-- Status change modal window -->
    <div id="change-status-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="ChangeStatusModal" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Status Update</h4>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<i class="fas fa-times"></i>
					</button>
				</div>

				<div class="modal-body">
					<form id="status-update" role="form">
						<fieldset>
							<legend>
								<p class="lead text-muted">Select your current status:</p>
							</legend>
							
							<?php foreach ($user->getUserAllowedStatus($userId) as $row => $data) :?>
							<div class="form-check">
								<label>
									<input type="radio" name="status_id" value="<?= $data['id_status'] ?>"> <?= $data['status_name'] ?>
								</label>
							</div>
							<?php endforeach; ?>

							<input type="hidden" name="user_id" value="<?= $userId ?>">
						</fieldset>
					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary" form="status-update">Save changes</button>
				</div>
			</div>
		</div>
	</div>
