<?php if ($auth->isUserAllowedTask('GTA')) : ?>
	<!-- GTA modal window -->
    <div id="gta-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="GTAModal" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Go To Assist Sessions</h4>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<i class="fas fa-times"></i>
					</button>
				</div>

				<div class="modal-body">
					<form id="gta-select" role="form">
						<fieldset>
							<legend>
								<p class="lead text-muted">I am currently using:</p>
							</legend>
							<div id="gta-form-radios"></div>
							<input type="hidden" name="type_id" value="4">
							<input type="hidden" name="value_val" value="<?= $userId ?>">
						</fieldset>
					</form>

					<div class="card">
						<h5 class="card-header">Availability</h5>
						<div id="active-gta" class="card-body"></div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary" form="gta-select">Save changes</button>
				</div>
			</div>
		</div>
	</div>
<?php endif ?>
